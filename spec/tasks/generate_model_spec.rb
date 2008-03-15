require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe_rake_task "generate:model", "tasks/waves-rspec.rake" do

  module MyTestApp
  end

  before(:each) do
    @app = tmppath(:app)
    FileUtils.mkdir_p(@app)
    ENV['model'] = 'my_model'
    Waves::Configurations::Default.stub!(:root).and_return(@app)
    Waves.stub!(:application).and_return(MyTestApp)
  end
  
  after(:each) do
    cleanup
  end

  it "should create spec/model directory" do
    stub!(:puts)
    invoke!
    File.exist?(@app / 'spec' / 'models').should == true
  end
    
  it "should create spec/model/my_model.rb file" do
    stub!(:puts)
    invoke!
    File.exist?(@app / 'spec' / 'models' / "#{ENV['model']}.rb").should == true
  end
    
end
