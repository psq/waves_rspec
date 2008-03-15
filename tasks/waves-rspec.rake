require 'fileutils'

begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  require 'spec'
end
begin
  require 'spec/rake/spectask'
rescue LoadError
  puts <<-EOS
To use rspec for testing you must install rspec gem:
    gem install rspec
EOS
  exit(0)
end

desc "Run the specs under spec"
Spec::Rake::SpecTask.new do |t|
  t.spec_opts = ['--options', "spec/spec.opts"]
  t.spec_files = FileList['spec/**/*_spec.rb']
end

namespace :generate do
  desc 'Generate everything needed to use RSpec'
  task :rspec do |task|
    templates = File.expand_path(File.dirname(__FILE__) / '..' / 'generators' / 'rspec' / 'templates')
    chdir Waves::Configurations::Default.root do
      generate_dir("spec")
      generate_file(templates / 'spec.opts', 'spec' / 'spec.opts')
      generate_file(templates / 'spec_helper.rb', 'spec' / 'spec_helper.rb')
    end
  end

  desc 'Generate a new model'
  task :model do |task|
    templates = File.expand_path(File.dirname(__FILE__) / '..' / 'generators' / 'rspec_model' / 'templates')
    chdir Waves::Configurations::Default.root do
      dir = 'spec' / 'models'
      generate_dir(dir)

      name = Waves.application.to_s
      model = ENV['model'].camel_case
      File.write(dir / "#{ENV['model']}.rb",
        Erubis::Eruby.new(File.read(templates / 'model_spec.rb.erb')).result(binding))
    end
  end

  desc 'Generate a new controller'
  task :controller do |task|
    templates = File.expand_path(File.dirname(__FILE__) / '..' / 'generators' / 'rspec_controller' / 'templates')
    chdir Waves::Configurations::Default.root do
      dir = 'spec' / 'controllers'
      generate_dir(dir)

      name = Waves.application.to_s
      controller = ENV['controller'].camel_case
      File.write(dir / "#{ENV['controller']}.rb",
        Erubis::Eruby.new(File.read(templates / 'controller_spec.rb.erb')).result(binding))
    end
  end

  def generate_dir(dir, force=false)
    if File.exist?(dir) && !force
      puts("#{dir} exists")
    else
      FileUtils.mkdir_p(dir)
      puts("#{dir} created")
    end
  end
  
  def generate_file(source, dest, force = false)
    if File.exist?(dest) && !force
      puts("#{dest} exists")
    else
      FileUtils.cp(source, dest)
      puts("#{dest} created")
    end
  end

end