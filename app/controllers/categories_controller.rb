class CategoriesController < ApplicationController
	def index
	end 

	def show
		@projects = Project.find(params[:category_id]).project
	end
end
