require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class JiraBuildNumberHelper
      # class methods that you define here become available in your action
      # as `Helper::JiraBuildNumberHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the jira_build_number plugin helper!")
      end
    end
  end
end
