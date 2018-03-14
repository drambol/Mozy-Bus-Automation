

RERUN_FILE = File.expand_path('../../../rerun.txt', __FILE__)

def get_rerun_cases()
  result_file = File.open(RERUN_FILE,'r')
  result_lines = result_file.readlines()

  rerun_cases = []

  result_lines.each_index { |k|
    if result_lines[k].match(/^.*.feature/)!= nil
      feature_file =  result_lines[k][/^.*.feature/]
      get_rerun_cases_for_each_line(result_lines[k], feature_file, rerun_cases)
    end
  }

  rerun_cases.join(',')

end

def get_rerun_cases_for_each_line(line, feature_file, rerun_cases)
  phoenix_case_file = File.open(feature_file,'r')
  feature_lines = phoenix_case_file.readlines()


  failed_cases_lines = line[/(:\d+)+/].split(':')
  failed_cases_lines = failed_cases_lines[1,failed_cases_lines.length]
  puts failed_cases_lines
  failed_cases_lines.each_index { |k|
    scenario = feature_lines[ failed_cases_lines[k].to_i - 1 ]

    # get precondition cases of failed cases
    precondition_cases = []
    if scenario.match(/Precondition:\S*$/) != nil
      preconditions = scenario[/Precondition:\S*$/].gsub(/Precondition:/,'')
      precondition_cases = preconditions.split(',')
      precondition_cases.each { |case_number| rerun_cases << case_number unless rerun_cases.include?(case_number)}
    end
    # add failed cases
    failed_case = scenario[/Scenario:\D*\d+/].gsub(/Scenario:\D*/,'@TC.')
    rerun_cases << failed_case unless rerun_cases.include?(failed_case)
  }
end