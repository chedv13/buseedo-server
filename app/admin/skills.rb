ActiveAdmin.register Skill do
  filter :name, filters: [:contains]

  permit_params :name
end
