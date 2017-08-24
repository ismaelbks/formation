ActiveAdmin.register Category do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :title, :description, :image, :remove_image
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end


	index do
		column "ID", :id
		column "Nom", :title
		column "Description de la catégorie", :description
		column "Nombre de projets de cette catégorie" do |f|
			f.projects.count
		end
		column "Image de la catégorie" do |f|
			image_tag f.image_url(:image), class: "aa-index-image" unless f.image_data.nil?
		end
		actions
	end


	form do |f|
		f.semantic_errors
		f.inputs do
			f.input :title, label: "Nom de la catégorie" 
			f.input :description, label: "Description de la catégorie"
	      	f.file_field :image, label: "Image de la catégorie", class: "aa-file-field-form"
	    end
	    f.actions
	end

	show do |f| 
      attributes_table do
		row "Nom de la catégorie" do 
			f.title.capitalize
		end

		row "Description de la catégorie" do
			f.description
		end

		row "Nombre de projets dans cette catégorie" do |f|
			f.projects.count
		end

		row "Image de la catégorie" do |f|
			image_tag f.image_url(:image), class: "aa-show-image" unless f.image_data.nil?
		end

      	row "Raccourcis" do 
            link_to "Revenir à la liste des catégories", admin_categories_path, class: "btn btn-primary"
        end   		

	  end
	end


end
