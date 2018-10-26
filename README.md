# jira\_build\_number plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-jira_build_number)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-jira_build_number`, add it to your project by running:

```bash
fastlane add_plugin jira_build_number
```

## About jira\_build\_number

Insert build number into related jira issues based on commit message or branch containing a jira issue id.  This plugin is intended to be triggered by CI service such as CircleCI or bitrise upon pushing code to a repository.

This plugin requires the following parameters be set or generated and passed to the plugin:
* commit_message - the last commit message
* commit_branch - the branch on which the commit occurred
* version_code - the build number for the code being compiled (e.g. 238)
* version_name - the version number for the code being compiled (e.g. 1.0.1)
* jira_hostname - the URL of the jira instance you are using
* jira_username - the jira username to use to access jira
* jira_password - the jira password to use to access jira

If the plugin can find a jira issue id in either the commit message or the branch name, it will insert a comment into the jira issue with the provided build number.

## Example

The following is an example of a lane within Fastline file.

```
  desc "Execute jira build number plugin"
  lane :jira_build_number do
    commit = last_git_commit
    commit_message = commit[:message]
    commit_branch = git_branch
    version_code = %x(git rev-list --count HEAD)
    version_name = get_version_name(
        gradle_file_path:"app/build.gradle"
     )
     puts "Build number: " + version_code
     puts "Version name: " + version_name
     jira_hostname = ENV["JIRA_HOSTNAME"]
     jira_username = ENV["JIRA_USERNAME"]
     jira_password = ENV["JIRA_PASSWORD"]
    jira_build_number(commit_message: commit_message, commit_branch: commit_branch, build_number: version_code, version_name: version_name, jira_hostname: jira_hostname, jira_username: jira_username, jira_password: jira_password)
  end

```

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
