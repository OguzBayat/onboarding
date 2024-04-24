# README

## Install

### Clone the repository

```shell
git clone git@github.com:OguzBayat/onboarding.git
cd onboarding
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 3.1.4`

If not, install the right ruby version using [rbenv](https://github.com/rbenv/rbenv) (it could take a while):

```shell
rbenv install 3.1.4
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler):

```shell
bundle install
```


### Initialize the database

```shell
rails db:create db:migrate db:seed
```

### Run background jobs

Run sidekiq at the other terminal

```shell
bundle exec sidekiq
```

For unlock steps:

```shell
rake 'check_progress:unlock_steps'
```

For sync progress completed email:

```shell
rake 'check_progress:send_sync_completed_mail'
```

## Serve

```shell
rails s
```
