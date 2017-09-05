ActiveAdmin.register Project do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :name, :collect_amount_goal, :short_description, :long_description, :portrait, :landscape, :remove_landscape, :remove_portrait, :category_id, :statement,
 	counterparts_attributes: [ :amount, :name, :description, :number, :project_id, :portrait, :remove_portrait, :stock_illimite, :stock, :_destroy, :id]


 filter :name
 filter :collect_amount_goal
 filter :category
filter :statement, as: :check_boxes, collection: ["Draft","Ongoing","Upcoming","Success","Failure"]


 config.create_another = true
 config.batch_actions = false

 before_action :authenticate_admin_user!

scope "Brouillons", :draft
scope "Bientôt", :upcoming
scope "Publiés", :ongoing
scope "Succés", :success
scope "Echec", :failure

scope "Tous les projets visibles", :displayed


# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

	member_action :draft,  method: :put do
		project = Project.find(params[:id])
		if current_admin_user
			if project.state_machine.transition_to(:Draft)
				project.set_statement(project.state_machine.current_state)
				redirect_to admin_project_path(project)
				flash[:notice] = "Statut du projet mis à jour"
			else 
				redirect_to admin_project_path
				flash[:alert] = "Action refusée"
			end
		else
			redirect_to admin_root_url
			flash[:alert] = "Petit coquin, tu n'es pas autorisé à faire ça !"
		end			
	end

	member_action :upcoming,  method: :put do
		project = Project.find(params[:id])
		if current_admin_user
			if project.state_machine.transition_to(:Upcoming)
				project.set_statement(project.state_machine.current_state)
				redirect_to admin_project_path(project)
				flash[:notice] = "Statut du projet mis à jour"
			else 
				redirect_to admin_project_path
				flash[:alert] = "Action refusée"
			end
		else
			redirect_to admin_root_url
			flash[:alert] = "Petit coquin, tu n'es pas autorisé à faire ça !"
		end			
	end

	member_action :ongoing,  method: :put do
		project = Project.find(params[:id])
		if current_admin_user
			if project.state_machine.transition_to(:Ongoing)
				project.set_statement(project.state_machine.current_state)
				redirect_to admin_project_path(project)
				flash[:notice] = "Le projet a bien été publié"
			else 
				redirect_to admin_project_path
				flash[:alert] = "Action refusée"
			end
		else 
			redirect_to admin_root_url
			flash[:alert] = "Petit coquin, tu n'es pas autorisé à faire ça !"
		end
	end

	member_action :success,  method: :put do
		project = Project.find(params[:id])
		if current_admin_user		
			if project.state_machine.transition_to(:Success)
				project.set_statement(project.state_machine.current_state)
				redirect_to admin_project_path(project)
				flash[:notice] = "Le projet est bien passé au statut succés."
			else 
				redirect_to admin_project_path
				flash[:alert] = "Action refusée"
			end
		else
			redirect_to admin_root_url
			flash[:alert] = "Petit coquin, tu n'es pas autorisé à faire ça !"
		end			
	end

	member_action :failure,  method: :put do
		project = Project.find(params[:id])
		if current_admin_user		
			if project.state_machine.transition_to(:Failure)
				project.set_statement(project.state_machine.current_state)
				redirect_to admin_project_path(project)
				flash[:notice] = "Le projet est bien passé au statut échec."
			else 
				redirect_to admin_project_path
				flash[:alert] = "Action refusée"
			end
		else
			redirect_to admin_root_url
			flash[:alert] = "Petit coquin, tu n'es pas autorisé à faire ça !"
		end			
	end	


	action_item :draft, only: :show, 
		if: proc{ Project.find(params[:id]).state_machine.can_transition_to?(:Draft) } do
			link_to 'Repasser en brouillon', draft_admin_project_path, method: :put
	end

	action_item :upcoming, only: :show, 
		if: proc{ Project.find(params[:id]).state_machine.can_transition_to?(:Upcoming) } do
			link_to 'Accepter le projet', upcoming_admin_project_path, method: :put
	end

	action_item :ongoing, only: :show, 
		if: proc{ Project.find(params[:id]).state_machine.can_transition_to?(:Ongoing) } do
			link_to 'Publier le projet', ongoing_admin_project_path, method: :put
	end    

	action_item :success, only: :show, 
		if: proc{ Project.find(params[:id]).state_machine.can_transition_to?(:Success) } do
			link_to 'Passer en succés', success_admin_project_path, method: :put
	end 

	action_item :failure, only: :show, 
		if: proc{ Project.find(params[:id]).state_machine.can_transition_to?(:Failure) } do
			link_to 'Passer en échec', failure_admin_project_path, method: :put
	end 

	action_item :preview, only: :show do
		link_to 'Aperçu', project_path, method: :get
	end 	




	controller do 
		def show
			@counterparts = Project.find(params[:id]).counterparts
		end

	end


	index title: "Projets" do 
		h1 "Projets"
		column "ID", :id
		column "Nom du projet", :name
		column "Statut", :statement
		column "Objectif de collecte", :sortable => :collect_amount_goal do |f|
			number_to_currency f.collect_amount_goal , :unit => "€ "
		end
		column "Contreparties" do |f|
			f.counterparts.count
		end
		column "Catégorie associée", :category
		column "Image du porteur"  do |f|
			image_tag f.portrait_url(:portrait), class: "aa-index-image" unless f.portrait_data.nil?
		end
		actions
	end

	form do |f|
		tabs do
			tab :Projet do 
				f.semantic_errors
				f.inputs do 
					f.input :name, label: "Nom du projet"
					f.input :category, label: "Catégorie associée"
					f.input :collect_amount_goal, label: "Objectif de collecte"
					f.input :short_description, label: "Description courte"   
					f.text_area :long_description, id: "long-description-admin", :class => "redactor", :rows => 40, :cols => 120
					f.file_field :portrait, label: "Image portrait", class: "aa-file-field-form"
					f.file_field :landscape, label: "Image paysage", class: "aa-file-field-form even"
			    end
			end
			
			tab :Contreparties do
				f.inputs do
					f.has_many :counterparts, heading: 'Contreparties',
                             				  allow_destroy: true,
                              				  new_record: "Créer contrepartie" do |a|
                      a.inputs "Contrepartie" do
                       a.input :name, label: "Nom"
                       a.input :description, label: "Description"
                       a.input :amount, label: "Montant plancher"
					   a.input :number, label: "Nombre total"
					   a.input :stock_illimite, label: "Stock illimité ?"
					   a.input :stock, label: "Stock disponible"
                       a.file_field :portrait, label: "Illustration"
                       a.input :portrait, :as => :file
                     end
                    end
                end
		    end

		end
		f.actions

	end

	show do |f|
		tabs do
  			tab :Projet do 
			  	h1 f.name.capitalize
		      	attributes_table do
					#row "Nom du projet" do 
					#	f.name.capitalize
					#end

					row "Statut" do 
						f.statement
					end

					row "Objectif de collecte" do
						number_to_currency f.collect_amount_goal, :unit => "€ "
					end

					row "Description courte" do
						f.short_description
					end

					row "Description longue" do
						f.long_description.html_safe
					end

					row "Catégorie associée" do
						f.category
					end

					row "Image portrait" do |f|
			        	image_tag f.portrait_url(:portrait) unless f.portrait.nil?
			      	end

			      	row "Image Paysage" do |f|
			      		image_tag f.landscape_url(:landscape) unless f.landscape.nil?
			      	end 

			      	row "Raccourcis" do 
			            link_to "Revenir à la liste des projets", admin_projects_path, class: "btn btn-primary"
			        end   
		        end
		    end

		    tab :Contreparties do
		    	render 'counterparts/list'

		    end

		    tab :Commentaires do
		    	h1 "Commentaires"
		    	active_admin_comments
		    end

		end  			
    end

    #sidebar :Contreparties, only: :show do
  	#	render 'counterparts/list'
	#end


end