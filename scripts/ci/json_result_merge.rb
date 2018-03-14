require 'json'

# merge json result generated by rerun to the first result
def merge (from, to, out)
  begin
    srcFile = open(from)
    destFile = open(to)
    srcJson = JSON.parse(srcFile.read)
    destJson = JSON.parse(destFile.read)
    outFile = File.new(out, 'w')


    srcJson.each do |feature|
      destJson.each do |destFeature|
        if feature['uri'].eql? destFeature['uri']
          feature['elements'].each do |scenario|
            counter = 0
            destFeature['elements'].each do |destScenario|
              if scenario['line'] == destScenario['line']

                # copy rerun result to result_merge only if rerun pass
                rerun_pass = true
                if scenario.has_key?('steps')
                  scenario['steps'].each do |step|
                    if step['result']['status'] == 'failed'
                      rerun_pass = false
                      break
                    end
                  end
                end

                destFeature['elements'][counter] = scenario if rerun_pass

              end
              counter += 1
            end
          end
        end
      end
    end

    outFile.puts JSON.dump destJson

  rescue
  ensure
    srcFile.close if !srcFile.nil?
    destFile.close if !destFile.nil?
    outFile.close if !outFile.nil?
  end


end

# merge the json results (report_rerun*.json) generated by rerun to the results (report_parallel*.json) generated by parallel test
def merge_parallel_json(json_folder)
  reports = Dir.glob("#{json_folder}/report_parallel*.json")
  reports_rerun = Dir.glob("#{json_folder}/report_rerun*.json")

  reports.each do |json|
    nameBegin = json.rindex '/'
    nameBegin = 0 if nameBegin < 0
    nameEnd = json.rindex '.'
    name = json[nameBegin+1..nameEnd-1]
    reports_rerun.each do |rerun_json|
      merge(rerun_json, json, "#{name}_merged.json")
      File.rename("#{name}_merged.json", "#{name}.json")
    end
  end

  reports_rerun.each do |json|
    File.delete json
  end

end