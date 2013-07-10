require 'ffaker'

class Person < Struct.new(:name, :age)
  def to_s
    "#{name}, of age #{age}"
  end
end

def an_person
  Person.new(Faker::Name.name, rand(90))
end

File.open('/dev/null', 'w') do |f|
  1_000.times do
    f.write("#{an_person}\n")
  end
end

