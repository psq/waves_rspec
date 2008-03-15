= waves-rspec

* http://blog.nanorails.com/waves-rspec
* http://rubyforge.org/projects/waves-rspec/

== DESCRIPTION:

RSpec support for the Waves Framework

== FEATURES/PROBLEMS:

* creates a spec skeleton wit
rake generate:rspec

* Adds Spec generation to waves generators
rake generate:model name=...
rake generate:controller name=...

* Adds tasks to run specs
rake spec

== SYNOPSIS:
* requires a "test" configuration.  Add ./configurations/test.rb (modeled on configurations/development.rb)

Example:

$ waves test5
** Creating new Waves application ...
** Application created!
$ cd test5
## Add require 'waves-spec' in rakefile
$ mkdir db
## Create test configuration with (for example) [database :adapter => 'sqlite', :database => 'db/test5_test']
$ rake generate:rspec
$ rake generate:model name=task
(in /Users/psq/src/waves/test5)
** spec/models created
** spec/models/task_spec.rb created
$ rake schema:migration name=task
## Fill migration
$ rake schema:migrate mode=test --trace
(in /Users/psq/src/waves/test5)
** Invoke schema:migrate (first_time)
** Execute schema:migrate
$ rake spec
(in /Users/psq/src/waves/test5)
Ruby/Extensions: String#starts_with? is already defined; not overwriting
.

Finished in 0.190411 seconds

1 example, 0 failures


== REQUIREMENTS:

* waves

== INSTALL:

* sudo gem install waves-rspec

* add "require 'waves-rspec" to your Rakefile

== DEVELOPING WITH WAVES LOCALLY
easiest it to install as a local gem inside waves with

rake package
gem install --local pkg/*.gem -i [WAVE_APP]/gems/
