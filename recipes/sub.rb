#
# Cookbook:: acrobat_pro
# Recipe:: sub
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

Chef::Resource.send(:include, Windows::Helper)

package_name = 'Adobe Acrobat DC'

remote_file Chef::Util::PathHelper.join(Chef::Config[:file_cache_path], "acrobatproDC.exe") do
  source node['acrobat_pro']['sub']['source']
end

powershell_script 'install Acrobat DC Pro' do
  code <<-INSTALL
    $startTime = (Get-Date).date
    If (-Not (Test-Path "#{Chef::Config[:file_cache_path]}/acrobatproDC.exe")) {
      Write-Host "acrobatproDC.exe was not downloaded."
      exit 10
    }
    Start-Process "#{Chef::Util::PathHelper.join(Chef::Config[:file_cache_path], 'acrobatproDC.exe')}"
    While ($true) {
      If ((Get-WinEvent -MaxEvents 1 -FilterHashtable @{logname='application'; id=1042; StartTime=$startTime} | Select Message) -match 'Ending(.+)AcroPro\.msi(.+)')  {
        Stop-Process -Name 'acrobatproDC'
        Break
      }
      Start-Sleep -s 15
    }
  INSTALL
  not_if { is_package_installed?(package_name) }
end
