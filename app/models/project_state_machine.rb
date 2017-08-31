class ProjectStateMachine
  include Statesman::Machine

  state :draft, initial: true
  state :upcoming
  state :ongoing
  state :success
  state :failure


  transition from: :draft,      to: [:upcoming]
  transition from: :upcoming,      to: [:ongoing, :draft]
  transition from: :ongoing,      to: [:success, :failure]

  guard_transition(to: :upcoming) do |project|
    project.name? && project.short_description? && project.long_description? && project.category_id? && project.portrait_data? && project.landscape_data? && project.collect_amount_goal? == true
  end


end