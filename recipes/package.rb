#
# Cookbook Name:: ffmpeg
# Recipe:: package
#
# Copyright 2014, David Joos
#

ffmpeg_packages.each do |pkg|
    package pkg do
        action :upgrade
    end
end