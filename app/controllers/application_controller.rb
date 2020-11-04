class ApplicationController < ActionController::Base
  rescue_from Recipes::NotFoundError, with: :not_found

  private def not_found
    render file: "#{Rails.root}/public/404", status: :not_found
  end
end
