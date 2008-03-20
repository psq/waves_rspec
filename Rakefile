# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/waves-rspec.rb'

Hoe.new('waves-rspec', WavesRspec::VERSION::STRING) do |p|
  p.rubyforge_name = 'waves-rspec'
  p.author = 'Pascal Belloncle (nano RAILS)'
  p.email = 'psq@nanorails.com'
  # p.description = p.paragraphs_of('README.txt', 2..5).join("\n\n")
  # p.url = p.paragraphs_of('README.txt', 0).first.split(/\n/)[1..-1]
  # p.changes = p.paragraphs_of('History.txt', 0..1).join("\n\n")
end

# vim: syntax=Ruby

desc "Install to gems dir of waves_app=/path/to/app"
task :install_local => :gem do
  require 'rubygems/installer'
  app_gems_path = File.join(ENV['waves_app'], 'gems')
  Dir['pkg/*.gem'].each do |gem|
    puts "Installing #{gem} to #{app_gems_path}"
    Gem::Installer.new(gem, :install_dir => app_gems_path).install
  end
end