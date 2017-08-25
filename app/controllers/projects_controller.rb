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
		@projects = Project.displayed.all
	end

	def categories_all
		@categories = Category.all
	end
end
	