#!/usr/bin/env ruby
#This script is used to batch change the case name according to its tag TC.12345. E.g: Scenario: Regression Test => Scenario: 12345 Regression Test

def add_case_number_to_scenario_name(path)
  num = 0
  File.open(path, 'r+') do |file|
    tag_match = []
    out = ""
    file = file.each do |line|
      if line =~ /@TC.\d+/ 
        tag_match = line.scan(/@TC.(\d+)/)
      elsif line =~ /Scenario/
#        puts line
        scenario_match = line.match(/Scenario(|\sOutline):(\s*Mozy|)[^a-zA-Z]*/)[0].scan(/(\d+)/)
        if !tag_match.empty? && tag_match != scenario_match
          add_on = tag_match.flatten.join(' ')
          line = line.gsub(/Scenario Outline:(\d|\s)*/, "Scenario Outline: #{add_on} ").gsub(/Scenario:(\d|\s)*/, "Scenario: #{add_on} ") 
          num = num + 1
        end
        tag_match = []
#        puts line
      end
      out << line
    end
    file.pos = 0
    file.print out
    file.truncate file.pos
    puts "#{path}: #{num} cases are changed" if num > 0
  end
end

def traverse_dir(path)
  if File.directory? path
    Dir.foreach(path) do |file|
      if file != '.' && file != '..'
        traverse_dir(File.join(path, file)) {|x| yield x}
      end
    end
  else
    yield  path
  end
end

# main
# for just one feature file
#path= File.expand_path "../../features/configuration/user_sync.feature", __FILE__
#add_case_number_to_scenario_name(path)
# for all the feature files
path= File.expand_path "../../features", __FILE__
traverse_dir(path) do |file|
  if file.to_s =~ /\.feature/
    add_case_number_to_scenario_name(file)
  end
end

