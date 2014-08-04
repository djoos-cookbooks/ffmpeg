#
# Cookbook Name:: ffmpeg
# Recipe:: package
#
# Copyright 2014, Escape Studios
#

ffmpeg_packages.each do |pkg|
  package pkg do
    action :upgrade
  end
end
