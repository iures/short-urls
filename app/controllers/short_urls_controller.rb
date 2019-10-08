class ShortUrlsController < ApplicationController

  # Since we're working on an API, we don't have authenticity tokens
  skip_before_action :verify_authenticity_token

  def index
    @urls = ShortUrl.order(:click_count => :desc).limit(100).to_a

    respond_to do |format|
      format.json
    end
  end

  def create
    short_url = ShortUrl.find_or_create_by(full_url: params[:full_url])

    if short_url.errors.present?
      render json: { errors: short_url.errors }
    else
      render json: { short_code: short_url.short_code }
    end
  end

  def show
    short_url = ShortUrl.find_by_short_code(params[:id])

    if short_url
      short_url.update_column(:click_count, short_url.click_count + 1)
      redirect_to short_url.full_url
    else
      render :json => { error: "404 Not found" }, :status => 404
    end
  end

end
