#
# Cookbook Name:: ffmpeg
# Recipe:: default
#
# Copyright 2014, David Joos
#

case node['ffmpeg']['install_method']
    when :source
        include_recipe "ffmpeg::source"
    when :package
        include_recipe "ffmpeg::package"
end