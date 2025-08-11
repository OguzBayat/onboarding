# Onboarding API - Ruby on Rails Application

## Project Overview

This is a Ruby on Rails API application that manages company onboarding processes. The system tracks companies through structured onboarding steps, with features for step progression, side effects, and email notifications upon completion.

## Core Architecture

### Technology Stack
- **Ruby**: 3.1.4
- **Rails**: ~7.0.8
- **Database**: PostgreSQL
- **Background Processing**: Sidekiq
- **Scheduled Jobs**: Whenever gem (cron jobs)
- **Email**: ActionMailer with Letter Opener for development
- **CORS**: Rack CORS for cross-origin requests

### Main Dependencies
```ruby
gem "rails", "~> 7.0.8"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rack-cors"
gem "active_model_serializers"
gem "sidekiq"
gem "whenever", require: false
gem "letter_opener", :group => :development
```

## Application Structure

### Models
- **User**: Base user model
- **Company**: Central entity belonging to a user, tracks onboarding status and progress
  - Status: `not_start`, `in_progress`, `completed`
  - Has many onboarding steps ordered by `step_order`
- **OnboardingStep**: Individual steps in the onboarding process
  - Validates sequential completion (cannot skip steps)
  - Supports locking mechanism
  - Has side effects system for triggering services/workers
  - Tracks completion timestamps and input values

### API Endpoints (v1)
```
GET    /api/v1/:company_id/iam                    # User info
GET    /api/v1/:company_id/sync_progress_infos    # Progress sync info
GET    /api/v1/:company_id/onboarding_steps       # List all steps
GET    /api/v1/:company_id/onboarding_steps/:id   # Show specific step
PUT    /api/v1/:company_id/onboarding_steps/:id   # Update step (complete/skip)
```

### Background Jobs
- **SendSyncCompletedEmailJob**: Sends completion notification emails
- **UnlockStepJob**: Handles step unlocking logic
- **RefreshCalculationsWorker**: Updates progress calculations

### Services
- **LeadTimeUpdater**: Updates lead time metrics
- **ProgressInfoService**: Manages progress information

### Key Features

#### Sequential Step Progression
- Steps must be completed in order (`step_order`)
- Previous steps must be completed before advancing
- Steps can be locked to prevent updates
- Support for skipping steps

#### Side Effects System
- Steps can trigger services or background workers upon completion
- Configured via `related_class_name` and `related_class_type` fields
- Supports both immediate service calls and async worker jobs

#### Email Notifications
- Automatic email notifications when onboarding is completed
- Uses ActionMailer with Sidekiq for background delivery
- Template support for HTML and text formats

#### Progress Tracking
- Company-level completion counters
- Step-level completion timestamps
- Status tracking across the entire onboarding flow

## Development Setup

### Database Setup
```bash
rails db:create db:migrate db:seed
```

### Background Jobs
```bash
bundle exec sidekiq
```

### Scheduled Tasks
```bash
whenever --update-crontab --set environment='development'
rake 'check_progress:unlock_steps'
rake 'check_progress:send_sync_completed_mail'
```

### Server
```bash
rails s
```

## Testing

The application includes comprehensive test coverage:
- Controller tests for API endpoints
- Model tests for business logic
- Mailer tests for email functionality
- Background job tests
- Fixtures for test data

## Key Business Logic

### Step Completion Flow
1. User submits step completion via API
2. System validates step can be updated (not locked, previous steps completed)
3. Step is marked completed with timestamp
4. Company's completion counter is incremented
5. Company status is updated if all steps completed
6. Side effects are triggered if configured
7. Email notification sent if onboarding fully completed

### Validation Rules
- Steps must be completed sequentially
- Locked steps cannot be updated
- Step input must be numeric (when provided)
- All required fields must be present

### Error Handling
- Comprehensive error messages for validation failures
- Proper HTTP status codes
- JSON error responses for API consistency