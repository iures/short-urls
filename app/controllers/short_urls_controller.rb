class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
  end

  def create
    short_url = ShortUrl.create(full_url: params[:full_url])

    if short_url.errors.present?
      render json: { errors: short_url.errors }
    else
      render json: { short_code: short_url.short_code }
    end
  end

  def show
  end

end
