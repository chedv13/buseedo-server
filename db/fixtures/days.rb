Course.published.each do |course|
  (1..rand(50..365)).each { |number| course.days.create!(number: number) }
end