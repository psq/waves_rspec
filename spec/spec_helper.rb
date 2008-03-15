require 'rubygems'
require 'waves'
require 'spec'

# Code from Coda Hale
def describe_rake_task(task_name, filename, &block)
  require "rake"

  describe "Rake task #{task_name}" do
    attr_reader :task

    before(:all) do
      @rake = Rake::Application.new
      Rake.application = @rake
      load filename
      @task = Rake::Task[task_name]
    end

    after(:all) do
      Rake.application = nil
    end

    def invoke!
      for action in task.instance_eval { @actions }
        instance_eval(&action)
      end
    end

    def tmppath(*paths)
      parts = [File.dirname(__FILE__), "tmp"]
      parts << (@root_time ||= Time.now.to_i.to_s)
      parts += paths
      # parts << rand().to_s.split(".").last
      parts.collect! {|path| path.to_s}
      path = File.join(*parts)
      attempts = 10
      while File.exists?(path)
        path.succ!
        attempts -= 1
        raise "Unable to find a good temp pathname: #{path.inspect}" if attempts.zero?
      end

      File.expand_path(path)
    end

    def cleanup
      path = File.expand_path(File.join(File.dirname(__FILE__), "tmp"))
      FileUtils.rm_rf(path)
    end

    instance_eval(&block)
  end
end
