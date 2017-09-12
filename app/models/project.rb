class Project < ApplicationRecord

    ###   VALIDATIONS    ###
    validates :name, presence: true, length: { maximum: 16, too_long: "Veuillez ne pas dépasser les %{count} caractères" }
    validates :short_description, length: { maximum: 175, too_long: "Veuillez ne pas dépasser les %{count} caractères" }
    validates :collect_amount_goal, numericality: { only_integer: true, :greater_than_or_equal_to => 20 }, presence: true
    validates :statement, inclusion: {in: ["Draft", "Upcoming", "Ongoing", "Success", "Failure"] }

    ###   ASSOCIATIONS   ###
    belongs_to :category
    has_many :counterparts
    accepts_nested_attributes_for :counterparts, :allow_destroy => true
    #has_many associations with the states is inside the states

    

    ###    UPLOADERS     ###
    include LandscapeImageUploader::Attachment.new(:landscape)
    include PortraitImageUploader::Attachment.new(:portrait)


    ###      STATES      ###
    include Statesman::Adapters::ActiveRecordQueries

    has_many :project_transitions

    # Initialize the state machine
    def state_machine
      @state_machine ||= ProjectStateMachine.new(self, transition_class: ProjectTransition)
    end

    delegate :can_transition_to?, :transition_to!, :transition_to, :current_state, to: :state_machine

    def set_statement(state)
        update_attributes(:statement => state)
    end


    private
        def self.transition_class
            ProjectTransition
        end

        def self.initial_state
            :new
        end


    ###      SCOPING     ###
    scope :draft, -> { where(statement: "Draft") }
    scope :ongoing, -> { where(statement: "Ongoing") }
    scope :upcoming, -> { where(statement: "Upcoming") }
    scope :success, -> { where(statement: "Success") }
    scope :failure, -> { where(statement: "Failure") }

    scope :displayed, -> { where(statement: ["Upcoming", "Ongoing", "Success"]) }


end
