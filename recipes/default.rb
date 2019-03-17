#
# Cookbook:: acrobat_pro
# Recipe:: default
#
# Copyright:: 2019, Nghiem Ba Hieu
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

unless %w[sub nonsub trial].include?(node['acrobat_pro']['version'].downcase)
  raise 'Does not support this version'
end

include_recipe "acrobat_pro::#{node['acrobat_pro']['version']}"
