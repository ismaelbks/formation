class ProjectStateMachine
  include Statesman::Machine

  state :Draft, initial: true
  state :Upcoming
  state :Ongoing
  state :Success
  state :Failure


  transition from: :Draft,      to: [:Upcoming]
  transition from: :Upcoming,      to: [:Ongoing, :Draft]
  transition from: :Ongoing,      to: [:Success, :Failure]

  guard_transition(to: :Upcoming) do |project|
    project.name? && project.short_description? && project.long_description? && project.category_id? && project.portrait_data? && project.landscape_data? && project.collect_amount_goal?
  end

  guard_transition(to: :Ongoing) do |project|
    !project.counterparts.nil?
  end


end