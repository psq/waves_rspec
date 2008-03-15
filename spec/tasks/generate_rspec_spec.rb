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
    File.exist?(@app / 'spec').should == true
  end

  it "should create spec_helper.rb" do
    stub!(:puts)
    invoke!
    File.exist?(@app / 'spec' / 'spec_helper.rb').should == true
  end

  it "should create specs.opt file" do
    stub!(:puts)
    invoke!
    File.exist?(@app / 'spec' / 'spec.opts').should == true
  end

  it "should output the creation messages" do
    should_receive(:puts).with("spec created") do
      should_receive(:puts).with("spec/spec.opts created") do
        should_receive(:puts).with("spec/spec_helper.rb created")
      end
    end
    invoke!
  end
  
  it "should not override the files it they are already there" do
    FileUtils.mkdir_p(@app / 'spec')
    FileUtils.touch(@app / 'spec' / 'spec.opts')
    FileUtils.touch(@app / 'spec' / 'spec_helper.rb')
    should_receive(:puts).with("spec exists") do
      should_receive(:puts).with("spec/spec.opts exists") do
        should_receive(:puts).with("spec/spec_helper.rb exists")
      end
    end
    invoke!
  end
    
end
