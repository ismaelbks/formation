ActiveAdmin.register Project do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :name, :collect_amount_goal, :short_description, :long_description, :portrait, :landscape, :display, :remove_landscape, :remove_portrait, :category_id, :status,
 	counterparts_attributes: [ :amount, :name, :description, :number, :project_id, :portrait, :remove_portrait, :stock_illimite, :stock, :_destroy, :id]

 scope :displayed

 filter :name
 filter :collect_amount_goal
 filter :display, as: :check_boxes
 filter :category

 config.create_another = true

# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

	controller do 
		def show
			@counterparts = Project.find(params[:id]).counterparts
		end

	end

	index title: "Projets" do 
		h1 "Projets"
		column "ID", :id
		column "Nom du projet", :name
		column "Objectif de collecte", :collect_amount_goal
		column "Catégorie associée", :category
		column "Statut", :status
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
					f.input :long_description, label: "Description longue"
					f.input :status, label: "Statut", as: :select, :collection => ["brouillon", "en cours", "échec", "succés"], :allow_blank => "false"
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

					row "Objectif de collecte" do
						number_to_currency f.collect_amount_goal, :unit => "€ "
					end

					row "Description courte" do
						f.short_description
					end

					row "Description longue" do
						f.long_description
					end

					row "Catégorie associée" do
						f.category
					end

					row "Statut" do
						f.status
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

		end  			
    end

    #sidebar :Contreparties, only: :show do
  	#	render 'counterparts/list'
	#end


end