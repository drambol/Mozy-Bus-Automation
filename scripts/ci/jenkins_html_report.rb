#! /usr/bin/env ruby

require 'getoptlong'
require 'nokogiri'
require 'open-uri'
require 'net/https'

opts = GetoptLong.new(
    [ "--help",            "-h", GetoptLong::NO_ARGUMENT       ],
    [ "--job_name",        "-n", GetoptLong::REQUIRED_ARGUMENT ],
    [ "--build_id",        "-i", GetoptLong::OPTIONAL_ARGUMENT ],
    [ "--jenkins",         "-j", GetoptLong::OPTIONAL_ARGUMENT ]
)

help = false
job_name = "bus_smoke_test_qa6.busclient01"
build_id = 1
jenkins = false
build_number = 'Release'

total = 0
passed = 0
failed = 0

opts.each do |opt, arg|
  case opt
    when '--help'
      puts <<-EOF
usage
  `ruby scripts/ci/jenkins_html_report.rb --job_name "bus_smoke_test_qa6.busclient01" --build_id 3`
  `ruby scripts/ci/jenkins_html_report.rb -n "bus_smoke_test_qa6.busclient01" -i 3`
  `ruby scripts/ci/jenkins_html_report.rb --job_name "bus_smoke_test_qa6.busclient05" --build_id lastCompletedBuild`
  `ruby scripts/ci/jenkins_html_report.rb -n "bus_smoke_test_qa6.busclient05" -j`
      EOF
      help = true
      break
    when '--job_name'
      job_name = arg
    when '--build_id'
      build_id = arg
    when '--jenkins'
      jenkins = true
  end
end

exit if help == true

uri = URI.parse("https://www.mozypro.com")
Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https', :verify_mode => OpenSSL::SSL::VERIFY_NONE) do |http|
  url =  "/version.txt"
  request = Net::HTTP::Post.new(url)
  response = http.request request
  build_number = response.body
end
=begin
if jenkins
  doc = Nokogiri::HTML(open("http://jenkins01.tools.mozyops.com/job/#{job_name}/", http_basic_authentication: ["hongyc", "QAP@SSw0rd1!"]))
  doc.xpath("//img[@tooltip='In progress > Console Output']/../../../a").each do |link|
    build_id = link.content.match(/\d+/)
  end
else
  doc = Nokogiri::HTML(open("http://jenkins01.tools.mozyops.com/job/#{job_name}/#{build_id}/cucumber-html-reports/overview-features.html", http_basic_authentication: ["hongyc", "QAP@SSw0rd1!"]))
  doc.xpath("//table[@id='build-info']/tbody/tr/td[2]").each do |link|
    build_id = link.content
  end
end

doc = Nokogiri::HTML(open("http://jenkins01.tools.mozyops.com/job/#{job_name}/#{build_id}/cucumber-html-reports/overview-features.html", http_basic_authentication: ["hongyc", "QAP@SSw0rd1!"]))

doc.xpath("//table[@id='tablesorter']//tfoot/tr[1]/td[10]").each do |link|
  total = link.content
end

doc.xpath("//table[@id='tablesorter']//tfoot/tr[1]/td[8]").each do |link|
  passed = link.content
end

doc.xpath("//table[@id='tablesorter']//tfoot/tr[1]/td[9]").each do |link|
  failed = link.content
end
=end

@passed = 0
@failed = 0
@total = 0

def parseLogOnResult(path)
  result = nil
  file = File.open(path)
  file.each do |line|
    if line.include?("[Test Case Result]") == true
      result = line.split(":")[1].strip
      break
    end
  end
  if(result == "Succeed")
    @passed += 1
    @total += 1
  else
    @failed += 1
    @total += 1
  end
end

# get all *.log under logs directory
files = Dir.entries('logs')

# parse each log file and input the info into the .json file.
files.each do |file|
  #path = 'logs/' + file if file.include?(".log")
  path = 'logs/' + file if (file.include?(".log") && !file.include?("bus_smoke_test_cleanup"))
  puts path
  parseLogOnResult(path) unless path.nil?
end

puts "================"
puts @passed
puts @failed
puts @total
puts "================"

passed = @passed
failed = @failed
total = @total

builder = Nokogiri::HTML::Builder.new do |doc|
  doc.html {
    ## write head
    doc.head {
      doc.title.bold {
        doc.text "Test Summary Report: #{build_number}"
      }
    }
    ## write body
    doc.body(bgcolor: "#FFFFFF", style: "color:black; font-size: 12pt") {
      ## write h1 title
      doc.h1.bold(style: "font-size: 15pt") {
        doc.text "Test Summary Report for BUS #{build_number}"
      }

      doc.h1.bold(style: "font-size: 12pt; text-indent: 1em") {
        doc.text "•    QA Environment: #{ENV['BUS_ENV']}"
      }

      doc.h1.bold(style: "font-size: 12pt; text-indent: 1em") {
        doc.text "•    Test Cases Execution:"
      }

      ## write overall information
      doc.table(border: "1", width: "40%", align: "bottom", style: "color:#0B614B; margin-left: 2em") {

        doc.tbody(style: "font-size: 11pt; text-align: center") {
          doc.tr(border: "1", style: "color:black", BORDERCOLOR: "BLACK") {

            if failed.to_i != 0
              doc.th(style: "color:red") { doc.text "Overall Status" }
            elsif passed.to_i != 0
              doc.th(style: "color:green") { doc.text "Overall Status" }
            else
              doc.th(style: "color:orange") { doc.text "Overall Status" }
            end

            doc.th(class: "center") { doc.text "Total Test Cases" }
            doc.th(class: "center", style: "color:green") { doc.text "Passed Test Cases" }
            doc.th(class: "center", style: "color:red") { doc.text "Failed Test Cases" }
          }

          doc.tr(border: "1", style: "color:black", BORDERCOLOR: "BLACK") {
            if failed.to_i != 0
              doc.td(class: "center", style: "color:red") { doc.text "FAIL" }
            elsif passed.to_i != 0
              doc.td(class: "center", style: "color:green") { doc.text "PASS" }
            else
              doc.td(class: "center", style: "color:orange") { doc.text "NOT RUN" }
            end
            doc.td(class: "center", style: "color:black") { doc.text "#{total}" }
            doc.td(class: "center", style: "color:green") { doc.text "#{passed}" }
            doc.td(class: "center", style: "color:red") { doc.text "#{failed}" }
          }

        } # end of doc.tbody
      } # end of doc.table

      doc.h1.bold(style: "font-size: 12pt; text-indent: 1em") {
        doc.text "•    Checkout detailed test report:"
      }

      doc.h1.bold(style: "color:black; font-size: 11pt; text-indent: 2em") {
        doc.text "http://jenkins01.tools.mozyops.com/view/apps-automation/job/#{job_name}/#{build_id}/cucumber-html-reports/overview-features.html"
      }

      doc.h1.bold(style: "font-size: 12pt; text-indent: 1em") {
        doc.text "•    Checkout test trend:"
      }

      doc.h1.bold(style: "color:black; font-size: 11pt; text-indent: 2em") {
        doc.text "http://jenkins01.tools.mozyops.com/view/apps-automation/job/#{job_name}/#{build_id}/cucumber-html-reports/overview-trends.html"
      }

    }#end of doc.body
  } #end of doc.html
end #end of Nokogiri::HTML::Builder.new
fp = File.new("jenkins_html_report.html",  "w")
fp.puts builder.to_html
fp.close
