require 'spec_helper'

describe BitbucketPipelinesLocal do
  subject { BitbucketPipelinesLocal::Validations.new }

  describe "validation" do

    let(:input) { File.join(File.dirname(__FILE__), 'fixtures/good.yml') }
    let(:output) {subject.configuration_file(input)}

    it 'configuration file exists' do
      expect(output).to eq true
    end
  end

end
