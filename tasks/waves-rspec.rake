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
    chdir Waves::Configurations::Default.root do
      templates = File.dirname(__FILE__) / '..' / 'generators' / 'rspec' / 'templates'
      generate_dir("spec")
      generate_file(templates / 'spec.opts', 'spec' / 'spec.opts')
      generate_file(templates / 'spec_helper.rb', 'spec' / 'spec_helper.rb')
    end
  end

  desc 'Generate a new model'
  task :model do |task|
    
  end

  desc 'Generate a new controller'
  task :controller do |task|
    
  end

  def generate_dir(dir, force=false)
    if File.exist?(dir) && !force
      puts("#{dir} exists")
    else
      FileUtils.mkdir_p("spec")
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