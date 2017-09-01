ActiveAdmin.register Counterpart do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
permit_params :amount, :name, :description, :number, :project_id, :portrait, :remove_portrait, :stock_illimite, :stock
#
config.create_another = true
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

controller do 
end


	index title: "Toutes les contreparties" do
		h1 "Contreparties" 
		column "ID", :id
		column "Nom de la contrepartie", :name
		column "Montant plancher", :amount do |m|
     		number_to_currency m.amount, :unit => "€ "
    	end
		column "Projet", :project
		column "Nombre total", :number
		column "Nombre disponible", :stock
		column "Illustration"  do |f|
			image_tag f.portrait_url(:portrait), class: "aa-index-image" unless f.portrait_data.nil?
		end
		actions
	end


	form do |f|
		f.semantic_errors
		f.inputs do 
		  f.input :name, label: "Nom de la contrepartie"
		  f.input :amount, label: "Montant plancher"
		  f.input :number, label: "Nombre total"
		  f.input :stock_illimite, label: "Stock illimité ?"
		  f.input :stock, label: "Stock disponible"
	      f.input :description, label: "Description de la contrepartie"
          f.input :project_id, label: "Projet", as: :select, :collection => Project.all , :allow_blank => "false"
	      f.file_field :portrait, label: "Image portrait", class: "aa-file-field-form"
	  end
	  f.actions
	end

	show do |f| 
		  h1 f.name
	      attributes_table do
			row "Nom de la contrepartie" do 
				f.name.capitalize
			end
			
			row "Projet" do
				f.project
			end

			row "Montant plancher" do
				number_to_currency f.amount, :unit => "€ "
			end

			row "Nombre total" do
				f.number
			end

			row "Stock disponible" do
				f.stock
			end			

			row "Description" do
				f.description
			end

			row "Image portrait" do |f|
	        	image_tag f.portrait_url(:portrait) unless f.portrait.nil?
	      	end

	      	row "Raccourcis" do 
	            link_to "Revenir à la liste des contreparties", admin_counterparts_path, class: "btn btn-primary"
	        end   
	      end  			
	    end	


end
