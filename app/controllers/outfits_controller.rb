class OutfitsController < ApplicationController
  respond_to :json, :html
  def index
    @outfits = Outfit.all.reverse
    respond_with @outfits
  end

  def new
    @outfit = Outfit.new
  end

  def edit
    @outfit = Outfit.find(params[:id])
  end

  def create
    @outfit = Outfit.new(set_params)
    @outfit.user_id = current_user.id
    if @outfit.save
      respond_to do |format|
        format.html {redirect_to outfits_path}
        format.json {render json: @outfit, status: :created}
      end
    else
      respond_to do |format|
        format.html {redirect_to 'new'}
        format.json {render json: @outfit.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    @outfit = Outfit.find(params[:id])
    if @outfit.update_attributes(set_params)
      respond_to do |format|
        format.html {redirect_to outfits_path}
        format.json {render nothing: :true, status: :no_content}
      end
    else
      respond_to do |format|
        format.html {render 'edit'}
        format.json {render json: @outfit.errors, status: :unprocessable_entity}
      end
    end
  end

  def show
    @outfit = Outfit.find(params[:id])
    respond_with @outfit
  end

  def destroy
    @outfit = Outfit.find(params[:id])
    @outfit.destroy
    respond_to do |format|
      format.html {redirect_to  :root}
      format.json {render json: {head: :ok}}
    end
  end


protected

  def set_params
    params.require(:outfit).permit(:type_of_outfit, :occasion, :brand_name, :price, :accessories, :sender_comment)
  end
end 


