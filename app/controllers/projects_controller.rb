class ProjectsController < ApplicationController

	
	def new
		@project = Project.new
	end

	def create
		@project = Project.new(project_params)
		if @project.save 
			redirect_to @project, flash[:notice] = "Le projet a bien été sauvegardé"
		else 
			render 'new'
		end
	end


	def index
		project_all
		categories_all
	end

	def show
		project_find
	end

	def edit
		project_find
	end

	def update
		project_find
	    if @project.update_attributes(project_params)
	      flash[:notice] = 'Projet modifié !'
	      redirect_to root_url
	    else
	      render 'edit'
	    end
	end	

	private

	def project_params
		params.require(:project).
			permit(
				:name, 
				:short_description, 
				:long_description, 
				:display, 
				:landscape, 
				:remove_landscape, 
				:portrait, 
				:remove_portrait
				)
	end

	def project_find
		@project = Project.find(params[:id])
	end

	def project_all
		@projects = Project.all
	end

	def categories_all
		@categories = Category.all
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