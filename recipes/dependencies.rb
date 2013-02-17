#
# Cookbook Name:: ffmpeg
# Recipe:: dependencies
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

include_recipe "build-essential"
include_recipe "git"

case node[:platform]
when "debian","ubuntu"
  include_recipe "yasm::package"
else
  include_recipe "yasm::source"
end

Chef::Log.debug("ffmpeg compile flags #{node[:ffmpeg][:compile_flags].join(', ')}")

# Filter the packages that we just built from source via their compile flag
node[:ffmpeg][:compile_flags].each do |flag|
  case flag
  when "--enable-libx264"
    include_recipe "x264::source"
  when "--enable-libvpx"
    include_recipe "libvpx::source"
  when "--enable-libmp3lame"
    ffmpeg_module "libmp3lame" do
      source "http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz"
      compile_flags [
        "--disable-shared",
        "--enable-nasm"
      ]
      creates "/usr/local/lib/libmp3lame.a"
    end
  when "--enable-libvorbis"
    # Libvorbis needs two modules to be installed
    ffmpeg_module "libogg" do
      source "http://downloads.xiph.org/releases/ogg/libogg-1.3.0.tar.gz"
      compile_flags ["--disable-shared"]
      creates "/usr/local/lib/libogg.a"
    end
    ffmpeg_module "libvorbis" do
      source "http://downloads.xiph.org/releases/vorbis/libvorbis-1.3.3.tar.gz"
      compile_flags ["--disable-shared"]
      creates "/usr/local/lib/libvorbis.a"
    end
  else
    packages_for_flag(flag).each do |pkg|
      package pkg do
        action :upgrade
      end
    end
  end
end
