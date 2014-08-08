#
# Cookbook Name:: ffmpeg
# Recipe:: source
#
# Copyright 2014, Escape Studios
#

include_recipe "build-essential"
include_recipe "git"
include_recipe "yasm::source"

ffmpeg_packages.each do |pkg|
    package pkg do
        action :purge
    end
end

include_recipe "x264::source"
include_recipe "libvpx::source"

# Filter the packages that we just built from source via their compile flag
flags_for_upgrade = node['ffmpeg']['compile_flags'].reject do |flag| 
    ["--enable-libx264", "--enable-libvpx"].include?(flag)
end

find_prerequisite_packages_by_flags(flags_for_upgrade).each do |pkg|
    package pkg do
        action :upgrade
    end
end

creates_ffmpeg = "#{node['ffmpeg']['prefix']}/bin/ffmpeg"

file "#{creates_ffmpeg}" do
    action :nothing
    subscribes :delete, "bash[compile_yasm]", :immediately
    subscribes :delete, "bash[compile_x264]", :immediately
    subscribes :delete, "bash[compile_libvpx]", :immediately
end

git "#{node['ffmpeg']['build_dir']}/ffmpeg" do
    repository node['ffmpeg']['git_repository']
    reference node['ffmpeg']['git_revision']
    action :sync
    notifies :delete, "file[#{creates_ffmpeg}]", :immediately
end

# Write the flags used to compile the application to Disk. If the flags
# do not match those that are in the compiled_flags attribute - we recompile
template "#{node['ffmpeg']['build_dir']}/ffmpeg-compiled_with_flags" do
    source "compiled_with_flags.erb"
    owner "root"
    group "root"
    mode 0600
    variables(
        :compile_flags => node['ffmpeg']['compile_flags']
    )
    notifies :delete, "file[#{creates_ffmpeg}]", :immediately
end

bash "compile_ffmpeg" do
    cwd "#{node['ffmpeg']['build_dir']}/ffmpeg"
    code <<-EOH
        ./configure --prefix=#{node['ffmpeg']['prefix']} #{node['ffmpeg']['compile_flags'].join(' ')}
        make clean && make && make install
    EOH
    not_if {  ::File.exists?(creates_ffmpeg) }
end
