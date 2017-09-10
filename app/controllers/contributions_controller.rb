class ContributionsController < ApplicationController

	before_action :authenticate_user!

	def new
		@contribution = Contribution.new
		#@project = Project.find(params[:id])
	end

	def create
		@contribution = Contribution.new(contribution_params)
		#@project = Project.find(params[:id])
	end

		private

		def contribution_params
			params.require(:contribution).permit(
				:amount
				)
		end

end
