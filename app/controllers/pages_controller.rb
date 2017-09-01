class PagesController < ApplicationController
  def home
  	project_all
  end

  private

  	def project_all
		@projects = Project.all.displayed
	end
end
