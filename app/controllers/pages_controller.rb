class PagesController < ApplicationController
  def home
  	project_all
  end

  private

  	def project_all
		@projects = Project.displayed.all
	end
end
