# cucumber -d -f Cucumber::Formatter::UpdateConfig
#
require 'cucumber/formatter/console'
require 'cucumber/formatter/io'

module Cucumber
  module Formatter
    class UpdateConfig
      include Io
      include Console

      def initialize(step_mother, path_or_io, options)
        @io = ensure_io(path_or_io, "update_config")
        @cucumber_mappings = []
      end

      def after_features(features)
        features.each do |feature|
          feature.feature_elements.each do |el|
            el.source_tag_names.each do |tag_name|
              unless tag_name.nil?
                matches = tag_name.match(/(TC.)(\d+)/)
                unless matches.nil?
                  @cucumber_mappings << "#{matches[2]}::#{el.name}" if matches.length == 3
                end
              end
            end
          end
        end
        update_cucumber_mappings if @cucumber_mappings.length > 0
      end

      def update_cucumber_mappings
        file_path = "config.properties"
        text = File.open(file_path, 'r').read
        replace = text.gsub(/cucumber_mappings = (.+)/, "cucumber_mappings = #@cucumber_mappings")
        File.open(file_path, "w") { |file| file.puts replace}
        puts "#{@cucumber_mappings.length} cucumber mappings updated"
      end
    end
  end
end
