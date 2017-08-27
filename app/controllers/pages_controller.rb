class PagesController < ApplicationController
  def home
  	project_all
  end

  private

  	def project_all
		@projects = Project.running.all
	end
end
