class ProjectsController < ApplicationController
	def show
		@project = Project.find(params[:id])
	end

	def edit
		@project = Project.find(params[:id])
	end

	def update
		@project = Project.find(params[:id])
   		if @project.save
         	flash[:success] = 'Photo added!'
        	redirect_to project_url(@project)
   		else
        	render "new"
    	end
	end

end
