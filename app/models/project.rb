class Project < ApplicationRecord

    ########################
    ###   VALIDATIONS    ###
    ########################
    validates :name, presence: true, length: { maximum: 25 }
    validates :short_description, length: { maximum: 300, too_long: "Veuillez ne pas dépasser les %{count} caractères" }
    validates :collect_amount_goal, numericality: { only_integer: true, :greater_than_or_equal_to => 20 }, presence: true
    validates :status, inclusion: { in: ["brouillon", "en cours", "succés", "échec"] }


    ########################
    ###   ASSOCIATIONS   ###
    ########################
    belongs_to :category
    has_many :counterparts
    accepts_nested_attributes_for :counterparts, :allow_destroy => true
    #has_many associations with the states is inside the states

    

    ########################
    ###    UPLOADERS     ###
    ########################
	include LandscapeImageUploader::Attachment.new(:landscape)
	include PortraitImageUploader::Attachment.new(:portrait)



    ########################
    ###      STATES      ###
    ########################
    include Statesman::Adapters::ActiveRecordQueries

    has_many :transitions, class_name: "ProjectTransition", autosave: false

    # Initialize the state machine
    def state_machine
      @state_machine ||= ProjectStateMachine.new(self, transition_class: ProjectTransition, association_name: :transitions)
    end

    # Optionally delegate some methods
    delegate :can_transition_to?, :transition_to!, :transition_to, :current_state, to: :state_machine



    ########################
    ###      SCOPING     ###
    ########################
    #Permet de filtrer les projets visible par tous uniquement.	
	scope :displayed, -> { where(status: ["en cours", "succés", "échec"]) }
	
    #Permet de filtrer les projets en cours uniquement.	
	scope :running, -> {where(status: "en cours")}         

end
