ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do


    section "User inscrits au cours des 3 derniers jours", class: "admin_table" do
        table_for User.where("created_at between (?) and (?)", 3.days.ago, DateTime.now) do
            column "Prénom", :firstname 
            column "Nom", :lastname
            column "Date de création", :created_at
            column "Lien" do |u|
                link_to "Voir l'utilisateur", [:admin, u], class: "btn-view"
            end

        end
        strong { link_to "Voir tous les utilisateurs", admin_users_path, class: "btn-primary" }
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
