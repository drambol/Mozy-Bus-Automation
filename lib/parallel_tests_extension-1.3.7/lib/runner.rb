require "parallel_tests/gherkin/runner"

#Reopen Cucumber runner in parallel_tests lib to handle rerun
module ParallelTests
  module Cucumber
    class Runner < ParallelTests::Gherkin::Runner
      class << self

        # finds all tests and partitions them into groups
        def tests_in_groups(tests, num_groups, options={})
          if tests[0].start_with?('@')
            tests = tests_with_rerun(tests, options)
            Grouper.in_even_groups_by_size(tests, num_groups, options)
          else
            super
          end
        end

        def tests_with_rerun(tests, options)
          rerun_file_name = tests[0][1..tests[0].length]
          rerun_file = File.open(rerun_file_name, 'r')
          rerun_hash = {}
          rerun_file.each_line do |line|
            line = line.chomp
            colon_start = line.index ':'
            feature = line[0..colon_start-1]
            line_no = line[colon_start..line.length]
            if rerun_hash[feature].nil?
              rerun_hash[feature] = line_no
            else
              rerun_hash[feature] = "#{rerun_hash[feature]}#{line_no}"
            end
          end
          rerun_file.close

          tests = []
          rerun_hash.each do |key, value|
            tests << "#{key}#{value}"
          end
          tests
        end

      end
    end
  end
end
