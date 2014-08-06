require 'yaml'

YAML.load_file("./widgets.yml")

data = YAML.load_file("./widgets.yml")

puts ""
puts "Lowest priced item > "
puts data.sort { |x,y| x[:price] <=> y[:price] }.first

puts ""
puts "Highest priced item > "
puts data.sort { |x,y| x[:price] <=> y[:price] }.last

puts ""
puts "Total Revenue for all widgets sold >"
total_revenue = data.map { |hash| hash[:price] * hash[:sold] }.inject('+').round(2)
puts total_revenue

puts ""
puts "Total Cost for all widgets sold > "
total_cost = data.map { |hash| hash[:cost_to_make] * hash[:sold] }.inject('+')
puts total_cost

puts ""
puts "Total Profit for all widgets sold> "
total_profit = total_revenue - total_cost
puts total_profit.round(2)

puts ""
puts "The top 10 best selling widgets > "
puts data.sort { |x,y| x[:sold] <=> y[:sold] }.reverse.slice(1,10)

puts ""
puts "The number of widgets sold in each department >"

data.group_by { |hash| hash[:department] }.keys.each do |key|
  dept_total = data.select { |hash| hash[:department] == key }.map {|hash| hash[:sold] }.inject('+')
  puts "Total sold from #{key} is #{dept_total}"
end
