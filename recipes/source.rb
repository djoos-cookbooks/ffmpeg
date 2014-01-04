#
# Cookbook Name:: ffmpeg
# Recipe:: source
#
# Copyright 2014, David Joos
#

include_recipe "build-essential"
include_recipe "git"

ffmpeg_packages.each do |pkg|
    package pkg do
        action :purge
    end
end

include_recipe "x264::source"
include_recipe "libvpx::source"

yasm_package = value_for_platform(
    [ "ubuntu" ] => { "default" => "yasm" },
    "default" => "yasm"
)

package yasm_package do
    action :upgrade
end

# Filter the packages that we just built from source via their compile flag
flags_for_upgrade = node[:ffmpeg][:compile_flags].reject do |flag| 
    ["--enable-libx264", "--enable-libvpx"].include?(flag)
end

find_prerequisite_packages_by_flags(flags_for_upgrade).each do |pkg|
    package pkg do
        action :upgrade
    end
end

creates_ffmpeg = "#{node[:ffmpeg][:prefix]}/bin/ffmpeg"

file "#{creates_ffmpeg}" do
    action :nothing
end

git "#{Chef::Config[:file_cache_path]}/ffmpeg" do
    repository node[:ffmpeg][:git_repository]
    reference node[:ffmpeg][:git_revision]
    action :sync
    notifies :delete, "file[#{creates_ffmpeg}]", :immediately
end

# Write the flags used to compile the application to Disk. If the flags
# do not match those that are in the compiled_flags attribute - we recompile
template "#{Chef::Config[:file_cache_path]}/ffmpeg-compiled_with_flags" do
    source "compiled_with_flags.erb"
    owner "root"
    group "root"
    mode 0600
    variables(
        :compile_flags => node[:ffmpeg][:compile_flags]
    )
    notifies :delete, "file[#{creates_ffmpeg}]", :immediately
end

bash "compile_ffmpeg" do
    cwd "#{Chef::Config[:file_cache_path]}/ffmpeg"
    code <<-EOH
        ./configure --prefix=#{node[:ffmpeg][:prefix]} #{node[:ffmpeg][:compile_flags].join(' ')}
        make clean && make && make install
    EOH
    creates "#{creates_ffmpeg}"
end