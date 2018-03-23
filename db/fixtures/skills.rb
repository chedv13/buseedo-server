%i[marketing business programming math science testing].each_with_index do |name, idx|
  number = idx + 1
  Skill.seed do |s|
    s.id = number
    s.name = name
  end
end