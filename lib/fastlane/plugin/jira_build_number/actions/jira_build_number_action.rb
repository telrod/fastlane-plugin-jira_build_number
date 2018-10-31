require 'fastlane/action'
require_relative '../helper/jira_build_number_helper'

module Fastlane
  module Actions
    module SharedValues
      JIRA_ISSUE_ID_VALUE = :JIRA_ISSUE_ID_VALUE
    end

    class JiraBuildNumberAction < Action
      def self.run(params)
        UI.message("Running jira build number action...")

        UI.message "Commit message: #{params[:commit_message]}"
        UI.message "Commit branch: #{params[:commit_branch]}"

        commitMessage = params[:commit_message]
        commitBranch = params[:commit_branch]

        # jiraTicketId = commitMessage.match((?<!([A-Za-z]{1,10})-?)[A-Z]+-\d+))
        jiraTicketId = searchForJiraTicketId(commitMessage)

        #UI.message "Jira ticket id: #{jiraTicketId}"

        if(jiraTicketId.nil?)
          jiraTicketId = searchForJiraTicketId(commitBranch)
        end

        UI.message "Jira ticket id: #{jiraTicketId}"

        buildNumber = params[:build_number]
        buildVersion = params[:version_name]

        UI.message "Build version: #{buildVersion}"
        UI.message "Build number: #{buildNumber}"

        jiraHostname = params[:jira_hostname]
        #jiraBasicToken = params[:jira_token]
        jiraUsername = params[:jira_username]
        jiraPassword = params[:jira_password]

        jiraBasicToken = Base64.encode64("#{jiraUsername}:#{jiraPassword}")

        if(!jiraTicketId.nil?)
          response = RestClient.post "https://#{jiraHostname}/rest/api/2/issue/#{jiraTicketId}/comment",
                                     {body => "Build: #{buildVersion}.#{buildNumber}"},
                                     {:Authorization => "Basic #{jiraBasicToken}"}
        end
        
        UI.message "Jira post response: #{response}"

        # sh "shellcommand ./path"

        # Actions.lane_context[SharedValues::JIRA_BUILD_NUMBER_CUSTOM_VALUE] = "my_val"
      end

      def self.searchForJiraTicketId(str)
        /[A-Z]+[-](\d+)/.match(str)
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Adds build number from CI as comment to associated jira issue."
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "Looks for the jira issue id in the branch or commit message and will insert the build number as a comment into that jira issue if found."
      end

      def self.available_options
        # Define all options your action supports.

        # Below a few examples
        [
            FastlaneCore::ConfigItem.new(key: :jira_username,
                                         env_name: "FL_JIRA_BUILD_NUMBER_JIRA_USERNAME", # The name of the environment variable
                                         description: "Jira username for JiraBuildNumberAction", # a short description of this parameter
                                         verify_block: proc do |value|
                                           UI.user_error!("No jira username for JiraBuildNumberAction given, pass using `build_number: 'build'`") unless (value and not value.empty?)
                                           # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                         end),
            FastlaneCore::ConfigItem.new(key: :jira_password,
                                         env_name: "FL_JIRA_BUILD_NUMBER_JIRA_PASSWORD", # The name of the environment variable
                                         description: "Jira password for JiraBuildNumberAction", # a short description of this parameter
                                         verify_block: proc do |value|
                                           UI.user_error!("No jira password for JiraBuildNumberAction given, pass using `build_number: 'build'`") unless (value and not value.empty?)
                                           # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                         end),
            FastlaneCore::ConfigItem.new(key: :jira_hostname,
                                         env_name: "FL_JIRA_BUILD_NUMBER_JIRA_HOSTNAME", # The name of the environment variable
                                         description: "Jira hostname for JiraBuildNumberAction", # a short description of this parameter
                                         verify_block: proc do |value|
                                           UI.user_error!("No jira hostname for JiraBuildNumberAction given, pass using `build_number: 'build'`") unless (value and not value.empty?)
                                           # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                         end),
            FastlaneCore::ConfigItem.new(key: :jira_token,
                                         env_name: "FL_JIRA_BUILD_NUMBER_JIRA_TOKEN", # The name of the environment variable
                                         description: "Jira token for JiraBuildNumberAction", # a short description of this parameter
                                         verify_block: proc do |value|
                                           UI.user_error!("No jira basic token for JiraBuildNumberAction given, pass using `build_number: 'build'`") unless (value and not value.empty?)
                                           # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                         end),
            FastlaneCore::ConfigItem.new(key: :build_number,
                                         env_name: "FL_JIRA_BUILD_NUMBER_BUILD_NUMBER", # The name of the environment variable
                                         description: "Build number for JiraBuildNumberAction", # a short description of this parameter
                                         verify_block: proc do |value|
                                           UI.user_error!("No build number for JiraBuildNumberAction given, pass using `build_number: 'build'`") unless (value and not value.empty?)
                                           # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                         end),
            FastlaneCore::ConfigItem.new(key: :version_name,
                                         env_name: "FL_JIRA_BUILD_NUMBER_VERSION_NAME", # The name of the environment variable
                                         description: "Build version for JiraBuildNumberAction", # a short description of this parameter
                                         verify_block: proc do |value|
                                           UI.user_error!("No build version for JiraBuildNumberAction given, pass using `version_name: 'version'`") unless (value and not value.empty?)
                                           # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                         end),
            FastlaneCore::ConfigItem.new(key: :commit_branch,
                                         env_name: "FL_JIRA_BUILD_NUMBER_COMMIT_BRANCH", # The name of the environment variable
                                         description: "Commit branch for JiraBuildNumberAction", # a short description of this parameter
                                         verify_block: proc do |value|
                                           UI.user_error!("No commit branch for JiraBuildNumberAction given, pass using `commit_branch: 'branch'`") unless (value and not value.empty?)
                                           # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                         end),
            FastlaneCore::ConfigItem.new(key: :commit_message,
                                         env_name: "FL_JIRA_BUILD_NUMBER_COMMIT_MESSAGE", # The name of the environment variable
                                         description: "Commit message for JiraBuildNumberAction", # a short description of this parameter
                                         verify_block: proc do |value|
                                           UI.user_error!("No commit message for JiraBuildNumberAction given, pass using `commit_message: 'message'`") unless (value and not value.empty?)
                                           # UI.user_error!("Couldn't find file at path '#{value}'") unless File.exist?(value)
                                         end)
        ]
      end

      def self.output
        [
            ['JIRA_ISSUE_ID_VALUE', 'The jira issue id if found within comment or branch name']
        ]
      end

      def self.return_value
        "Returns jira issue id if found within comment or branch"
      end

      def self.authors
        ["https://github.com/telrod"]
      end

      def self.is_supported?(platform)
        #  true
        [:ios, :android].include?(platform)

      end
    end
  end
end
