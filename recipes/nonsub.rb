#
# Cookbook:: acrobat_pro
# Recipe:: nonsub
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

installer_options = '/sAll'
cache_path = Chef::Config[:file_cache_path]
archiver_path = Chef::Util::PathHelper.join(cache_path, 'Acrobat_2015_Web_WWMUI.exe')
installer_path = Chef::Util::PathHelper.join(cache_path, 'Adobe Acrobat', 'Setup.exe')

download_headers = {}
download_headers = node['acrobat_pro']['headers']

remote_file archiver_path do
  source node['acrobat_pro']['source']
  headers download_headers
end

execute 'extract installer' do
  command "#{archiver_path} /s /x /d #{Chef::Config[:file_cache_path]}"
  not_if { ::File.exist?(installer_path) }
end

windows_package 'Adobe Acrobat DC (2015)' do
  source installer_path
  checksum node['acrobat_pro']['checksum'] if node['acrobat_pro']['checksum']
  installer_type :custom
  options installer_options
  timeout node['acrobat_pro']['timeout'] if node['acrobat_pro']['timeout']
  action :install
end
