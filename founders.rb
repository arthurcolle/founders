#!/Users/stochastic-thread/.rvm/rubies/ruby-2.6.0/bin/ruby
require 'pry'

rgx = /([A-Za-zé'.\/\s+-]+{2})\s+\(([0-9]+),\s+([A-Za-z0-9\s+.-\|]+\s?)\)/
FOUNDERS_FILE = "/Users/stochastic-thread/founders/founders.txt"

file = File.read(FOUNDERS_FILE)
items = file.split(";")
items.each {|item|
  matched = rgx.match(item)
  if matched and matched.size == 4
    group = "#{matched[1]},#{matched[2]},#{matched[3]}\n"
    puts group
    File.open("founders.csv", mode: "a") do |f|
      f.write(group)
    end
  end
}