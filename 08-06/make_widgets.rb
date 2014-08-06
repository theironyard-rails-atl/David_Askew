require "faker"
require "yaml"

F = Faker::Commerce

departments = 10.times.map { F.department }

widgets = 100.times.map do
  monies = [F.price, F.price]

  {
    name:         F.product_name,
    color:        F.color,
    department:   departments.sample,
    price:        monies.max,
    cost_to_make: monies.min,
    sold:         rand(1000)
  }
end

File.open("widgets.yml", "w") do |f|
  f.write widgets.to_yaml
end
