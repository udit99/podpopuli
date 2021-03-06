require_relative '../podfile_parser'

describe PodfileParser do
  context "should parse versionless pod declarations" do
    let(:pod_statements){["pod 'TBXML'", "pod 'TSMessages'"]}
    it "should return 2 pod names" do
      actual_podnames = PodfileParser.parse_podnames(pod_statements)
      actual_podnames.should == ["TBXML", "TSMessages"]
    end
  end

  context "should parse pod names with double quotes" do
    let(:pod_statements){["pod \"TBXML\"", "pod \"TSMessages\""]}
    it "should return 2 pod names" do
      actual_podnames = PodfileParser.parse_podnames(pod_statements)
      actual_podnames.should == ["TBXML", "TSMessages"]
    end
  end

  context "should parse versioned pod declarations" do
    let(:pod_statements){["pod 'AFNetworking', '~> 2.0'", "pod 'ASIHTTPRequest', '~> 1.8.1'"]}
    it "should return 2 pod names" do
      actual_podnames = PodfileParser.parse_podnames(pod_statements)
      actual_podnames.should == ["AFNetworking", "ASIHTTPRequest"]
    end
  end
end
