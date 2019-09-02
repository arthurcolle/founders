#!/Users/stochastic-thread/.rvm/rubies/ruby-2.6.0/bin/ruby
require 'pry'

rgx = /([A-Za-zé'.\/\s+-]+{2})\s+\(([0-9]+),\s+([A-Za-z0-9\s+.-\|]+\s?)\)/
# regex = %r{
#       (?<name>  )
#
# }
FOUNDERS_FILE = "founders.txt"

file = File.read(FOUNDERS_FILE)
items = file.split(";")
items.each {|item|
  item.strip!
  if item.include?("|")
    companies_rgx = /(\D*)\((.*)\)/
    cmatches = companies_rgx.match(item)
    if cmatches and cmatches.size == 3
      company_age = cmatches[2].split("|")
      company_age.each { |ca|
        ca.strip!
        age, co = ca.split(",")
        group = "#{cmatches[1].strip},#{age.strip},#{co.strip}\n"
        puts group
        File.open("founders.csv", mode: "a") do |f|
          f.write(group)
        end
      }
    end
  else
    matched = rgx.match(item)
    if matched and matched.size == 4
      group = "#{matched[1].strip},#{matched[2].strip},#{matched[3].strip}\n"
      puts group
      File.open("founders.csv", mode: "a") do |f|
        f.write(group)
      end
    end
  end
}
