class ProjectsController < ApplicationController

	def index
		@projects = Project.all
	end

	def show
		@project = Project.find(params[:id])
	end

	def edit
		@project = Project.find(params[:id])
	end

	def update
		@project = Project.find(params[:id])
	    if @project.update_attributes(project_params)
	      flash[:success] = 'Projet modifié !'
	      redirect_to root_url
	    else
	      render 'edit'
	    end
	end	

	private

	def project_params
		params.require(:project).permit(:name, :short_description, :long_description, :display, :landscape, :remove_landscape)
	end
end
	
=begin	
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
	 
	

	private

	def landscape_image_params
		params.require(:landscape_image).permit(:title, :image, :project_id, :remove_image)
	end
end

=end