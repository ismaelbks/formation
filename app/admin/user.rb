ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#

#Never rely on the internet (Amazon will show you)
permit_params :firstname, :lastname, :email, :birthdate, :created_at

#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

	index do
	    column "Prénom", :firstname
	    column "Nom", :lastname
	    column "Adresse email", :email
	    column "Date de naissance", :birthdate
	    actions
	end

	form do |f|
		f.inputs do
	  		f.semantic_errors  # shows errors on :base
	  		f.input :firstname
	  		f.input :lastname
	  		f.input :email
	  		f.input :birthdate, as: :datepicker,
                      datepicker_options: {
                        min_date: "1930-10-8",
                        max_date: "+3D"
                      }
	    end
	    f.actions
	end

	show do |f|
        attributes_table do
            row "Prénom" do 
                f.firstname
            end 
            row "Nom" do 
                f.lastname
            end
            row "Adresse email" do 
                f.email
            end    
            row "birthdate" do 
                f.birthdate.strftime("%d %B %Y")
            end
            row "Nombre de connexion" do 
                f.sign_in_count
            end
            row "Derniere adresse ip" do 
                f.last_sign_in_ip
            end 
            row "Date de création" do 
                f.created_at.strftime("%d %B %Y à %Hh%M")
            end             
            row "Raccourcis" do 
                link_to "Revenir à la liste des utilisateurs", admin_users_path, class: "btn-primary"
            end
          end
    end


end
