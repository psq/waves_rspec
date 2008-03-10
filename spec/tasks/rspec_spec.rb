require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe_rake_task "generate:rspec", "tasks/waves-rspec.rake" do

  before(:each) do
    @app = tmppath(:app)
    FileUtils.mkdir_p(@app)
    Waves::Configurations::Default.stub!(:root).and_return(@app)
  end
  
  after(:each) do
    cleanup
  end

  it "should create spec directory" do
    stub!(:puts)
    invoke!
    File.exist?(@app / 'spec')
  end

  it "should create spec_helper.rb" do
    stub!(:puts)
    invoke!
    File.exist?(@app / 'spec' / 'spec_helper.rb')
  end

  it "should create specs.opt file" do
    stub!(:puts)
    invoke!
    File.exist?(@app / 'spec' / 'specs.opt')
  end

  it "should output the creation messages" do
    should_receive(:puts).with("spec created") do
      should_receive(:puts).with("spec/spec.opts created") do
        should_receive(:puts).with("spec/spec_helper.rb created")
      end
    end
    invoke!
  end

end
