Gem::Specification.new do |s|
  s.name        = 'parallel_tests_extension'
  s.version     = '1.3.7'
  s.date        = '2015-04-30'
  s.summary     = "parallel_tests_extension"
  s.description = "extends parallel_tests to enable cucumber rerun"
  s.authors     = ["You Lin"]
  s.executables = 'parallel_cucumber_ext'
  s.add_runtime_dependency 'parallel_tests', '1.3.7'
end