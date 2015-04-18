class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  private

    def param_to_boolean(param)
      # Use ActiveRecord's internal method (subject to change)
      ActiveRecord::Type::Boolean.new.type_cast_from_user(param.downcase) if param.present?
        # downcase needed for mixed-case values e.g. True, tRUE
    end
    helper_method :param_to_boolean
end
