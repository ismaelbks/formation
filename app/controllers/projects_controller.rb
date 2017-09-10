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
		@contribution = Contribution.new
		project_find
		@counterparts = Project.find(params[:id]).counterparts
		if @project.state_machine.current_state == "Failure" || @project.state_machine.current_state == "Draft" 
			if !current_admin_user
				redirect_to root_url
				flash[:alert] = "Ce projet n'est pas disponible pour tout le monde"
			end
		end
	end

	def edit
		project_find
		if @project.state_machine.current_state == "Failure" || @project.state_machine.current_state == "Draft" 
			redirect_to root_url
			flash[:alert] = "Ce projet n'est pas disponible pour tout le monde"
		end
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
				:collect_amount_goal,
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
		@projects = Project.all.displayed
	end

	def categories_all
		@categories = Category.all
	end
end
	