class CounterpartsController < ApplicationController

	def list
		counterparts_project
	end


	private

	def counterparties_project
		@counterparts = Project.find(params[:id]).counterparts
	end
end
