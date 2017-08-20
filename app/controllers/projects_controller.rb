class ProjectsController < ApplicationController

	def index
		@projects = Project.all
		#@landscape_image = LandscapeImage.find(params[:id])
	end

	def show
		@project = Project.find(params[:id])
		@landscape_image = LandscapeImage.find(params[:id])
	end

end
