describe Fastlane::Actions::JiraBuildNumberAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The jira_build_number plugin is working!")

      Fastlane::Actions::JiraBuildNumberAction.run(nil)
    end
  end
end
