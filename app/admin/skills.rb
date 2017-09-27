ActiveAdmin.register Skill do
  filter :name, filters: [:contains]
end
