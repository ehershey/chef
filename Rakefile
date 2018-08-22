#
# Author:: Adam Jacob (<adam@chef.io>)
# Author:: Daniel DeLeo (<dan@chef.io>)
# Copyright:: Copyright 2008-2018, Chef Software Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require_relative "tasks/rspec"
require_relative "tasks/maintainers"
require_relative "tasks/cbgb"
require_relative "tasks/dependencies"
require_relative "tasks/announce"

task :pedant, :chef_zero_spec

task :build_eventlog do
  Dir.chdir "ext/win32-eventlog/" do
    system "rake build"
  end
end

task :register_eventlog do
  Dir.chdir "ext/win32-eventlog/" do
    system "rake register"
  end
end

begin
  require "chefstyle"
  require "rubocop/rake_task"
  RuboCop::RakeTask.new(:style) do |task|
    task.options += ["--display-cop-names", "--no-color"]
  end
rescue LoadError
  puts "chefstyle/rubocop is not available.  gem install chefstyle to do style checking."
end

begin
  require "yard"
  DOC_FILES = [ "README.rdoc", "LICENSE", "spec/tiny_server.rb", "lib/**/*.rb" ].freeze
  namespace :yard do
    desc "Create YARD documentation"

    YARD::Rake::YardocTask.new(:html) do |t|
      t.files = DOC_FILES
      t.options = ["--format", "html"]
    end
  end

rescue LoadError
  puts "yard is not available. (sudo) gem install yard to generate yard documentation."
end
