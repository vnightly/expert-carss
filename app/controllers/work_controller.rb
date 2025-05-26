class WorkController < ApplicationController
  before_action :set_theme, only: [:index, :next_image, :previous_image]
  before_action :set_image, only: [:index, :next_image, :previous_image]

  def index
    @themes = Theme.all
    @theme ||= @themes.first

    if @theme && @theme.images.any?
      @image ||= @theme.images.first

      if @image
        @user_rating = @image.values.find_by(user_id: current_user.id)&.value
        @average_rating = @image.ave_value
      end
    end

    respond_to do |format|
      format.html
      format.json do
        render json: {
          image_url: ActionController::Base.helpers.asset_path(@image.file),
          image_id: @image.id,
          user_rating: @user_rating,
          average_rating: @average_rating
        }
      end
    end
  end

  def next_image
    @image = @theme.images.where('id > ?', @image.id).first || @theme.images.first
    render json: image_response(@image)
  end

  def previous_image
    @image = @theme.images.where('id < ?', @image.id).last || @theme.images.last
    render json: image_response(@image)
  end

  def save_rating
    @image = Image.find(params[:image_id])
    @value = @image.values.find_or_initialize_by(user_id: current_user.id)
    @value.value = params[:value]

    if @value.save
      @image.update(ave_value: @image.values.average(:value))
      render json: {
        user_rating: @value.value,
        average_rating: @image.ave_value
      }
    else
      render json: { error: 'Failed to save rating' }, status: :unprocessable_entity
    end
  end

  private

  def set_theme
    @theme = Theme.find_by(id: params[:theme_id])
  end

  def set_image
    @image = @theme.images.find_by(id: params[:image_id]) if @theme
  end

  def image_response(image)
    {
      image_url: ActionController::Base.helpers.asset_path(image.file),
      image_id: image.id,
      user_rating: image.values.find_by(user_id: current_user.id)&.value,
      average_rating: image.ave_value
    }
  end
end
