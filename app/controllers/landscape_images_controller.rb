class LandscapeImagesController < ApplicationController
	
	def show
		@landscape_image = LandscapeImage.find(params[:id])
	end	

	def new
	    @landscape_image = LandscapeImage.new
	    @projects = Project.all
	end
	 
	def create
	    @landscape_image = LandscapeImage.new(landscape_image_params)
	    @projects = Project.all

	    if @landscape_image.save
	        flash[:success] = 'Illustration ajoutée!'
	        redirect_to root_url
	    else
	        render 'new'
	    end
	end	

	def edit
	    @landscape_image = LandscapeImage.find(params[:id])
	end
	 
	def update
	    @landscape_image = LandscapeImage.find(params[:id])
	    if @landscape_image.update_attributes(landscape_image_params)
	      flash[:success] = 'Illustration modifiée!'
	      redirect_to root_url
	    else
	      render 'edit'
	    end
	end	

	private

	def landscape_image_params
		params.require(:landscape_image).permit(:title, :image, :project_id, :remove_image)
	end
end
