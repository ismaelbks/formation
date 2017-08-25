class CategoriesController < ApplicationController
	def index
	end 

	def show
		@category = Category.find(params[:id])
	end

	def list
		project_category
		category_find
	end

		private

		def project_category
			@projects = Category.find(params[:id]).projects.displayed
		end

		def category_find
			@category = Category.find(params[:id])
		end


end
