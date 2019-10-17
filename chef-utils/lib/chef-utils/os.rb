#
# Copyright:: Copyright 2018-2019, Chef Software Inc.
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

require "chef-utils/internal"

module ChefUtils
  module OS
    include Internal
    extend self

    #
    # NOTE CAREFULLY: Most node['os'] values should not appear in this file at all.
    #
    # For cases where node['os'] == node['platform_family'] == node['platform'] then
    # only the platform helper should be added.
    #

    # Determine if the current node is linux.
    #
    # @param [Chef::Node] node
    #
    # @return [Boolean]
    #
    def linux?(node = __getnode)
      node["os"] == "linux"
    end

    # Determine if the current node is darwin.
    #
    # @param [Chef::Node] node
    #
    # @return [Boolean]
    #
    def darwin?(node = __getnode)
      node["os"] == "darwin"
    end
  end
end
