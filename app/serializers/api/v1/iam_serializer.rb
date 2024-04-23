module Api
  module V1
    class IamSerializer < ActiveModel::Serializer
      attributes :company_id, :company_title, :user_id, :user_name, :user_surname, :user_email

      def company_id
        object.id
      end

      def company_title
        object.title
      end

      def user_name
        object.user.name
      end

      def user_surname
        object.user.surname
      end

      def user_email
        object.user.email
      end
    end
  end
end
