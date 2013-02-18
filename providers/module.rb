#
# Cookbook Name:: ffmpeg
# Provider:: module
#
# Author:: iuri aranda (<iuri.aranda@uwhisp.com>)
#
# Copyright 2011, En Masse Entertainment, Inc.
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

action :install do
  case new_resource.install_method
  when 'package'
    package new_resource.name do
      action :install
      notifies :create, "ruby_block[notify_updated_#{new_resource.name}]", :immediately
    end
  else

    # File resource needed to delete the "creates" file to trigger the build when something changes
    # Create it only when the "creates" attribute is not nil, as it is optional
    file new_resource.creates do
      action :nothing
      only_if { !new_resource.creates.nil? }
    end

    file = new_resource.source.split('/').last
    remote_file "#{Chef::Config[:file_cache_path]}/#{file}" do
      mode 00644
      source new_resource.source
      # Delete the "creates" file to trigger the build
      notifies :delete, "file[#{new_resource.creates}]", :immediately unless new_resource.creates.nil?
    end

    # Write the flags used to compile the application to Disk. If the flags
    # do not match those that are in the compiled_flags attribute - we recompile
    template "#{Chef::Config[:file_cache_path]}/#{new_resource.name}-compiled_with_flags" do
      source "compiled_with_flags.erb"
      owner "root"
      group "root"
      mode 0600
      variables(
        :compile_flags => new_resource.compile_flags
      )
      # Delete the "creates" file to trigger the build
      notifies :delete, "file[#{new_resource.creates}]", :immediately unless new_resource.creates.nil?
    end

    bash "install_#{new_resource.name}" do
      user "root"
      cwd Chef::Config[:file_cache_path]
      code <<-EOH
        tar -zxf #{file}
        cd #{file.strip.gsub(/\.tar\.gz/, "").gsub(/\.tgz/, "")}
        ./configure #{new_resource.compile_flags.join(' ')}
        make
        make install
      EOH
      not_if {!new_resource.creates.nil? && ::File.exist?(new_resource.creates)}
      notifies :create, "ruby_block[notify_updated_#{new_resource.name}]", :immediately
    end
  end

  ruby_block "notify_updated_#{new_resource.name}" do
    block do
      new_resource.updated_by_last_action(true)
    end
    action :nothing
  end
end
