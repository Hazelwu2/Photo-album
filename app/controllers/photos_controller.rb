class PhotosController < ApplicationController
  before_action :set_photo, :only => [:show, :edit, :update, :destroy]

  def index
    @photos = Photo.all.order("created_at DESC")
  end

  def new
    @photo = Photo.new
  end

  def update
    if @photo.update_attributes(photo_params)
      redirect_to photo_path(@photo)
    else
      render :edit
    end
  end

  def destroy
    @photo.destroy
    redirect_to photos_url
  end

  def create
    @photo = Photo.new(photo_params)

    if @photo.save
      redirect_to photos_url, notice: '恭喜！您新增的相片已順利上傳。'
    else
      render :action => :new, notice: 'Oh oh!很抱歉，系統並未成功儲存您的相片。'
    end
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:title, :date, :description, :file_location)
  end

end
