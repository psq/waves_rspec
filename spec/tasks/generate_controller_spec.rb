require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe_rake_task "generate:controller", "tasks/waves-rspec.rake" do

  module MyTestApp
  end

  before(:each) do
    @app = tmppath(:app)
    FileUtils.mkdir_p(@app)
    ENV['name'] = 'my_controller'
    Waves::Configurations::Default.stub!(:root).and_return(@app)
    Waves.stub!(:application).and_return(MyTestApp)
  end
  
  after(:each) do
    cleanup
  end

  it "should create spec/controller directory" do
    stub!(:puts)
    invoke!
    File.exist?(@app / 'spec' / 'controllers').should == true
  end
    
  it "should create spec/controller/my_controller_spec.rb file" do
    stub!(:puts)
    invoke!
    File.exist?(@app / 'spec' / 'controllers' / "#{ENV['name']}_spec.rb").should == true
  end
    
end
