#
# Cookbook Name:: ffmpeg
# Attributes:: default
#
# Copyright 2014, David Joos
#

default['ffmpeg']['install_method'] = :source
default['ffmpeg']['prefix'] = "/usr/local"
default['ffmpeg']['git_repository'] = "git://git.videolan.org/ffmpeg.git"
default['ffmpeg']['epel']['mirrolist'] = "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=$basearch"
default['ffmpeg']['epel']['gpgkey'] = "http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-6"
default['ffmpeg']['linuxtech']['baseurl'] = "http://pkgrepo.linuxtech.net/el6/release/" 
default['ffmpeg']['linuxtech']['gpgkey'] = "http://pkgrepo.linuxtech.net/el6/release/RPM-GPG-KEY-LinuxTECH.NET"
default['ffmpeg']['compile_flags'] = [
  "--disable-debug",
  "--enable-pthreads",
  "--enable-nonfree",
  "--enable-gpl",
  "--disable-indev=jack",
  "--enable-libx264",
  "--enable-libfaac",
  "--enable-libmp3lame",
  "--enable-libtheora",
  "--enable-libvorbis",
  "--enable-libvpx",
  "--enable-libxvid",
  "--enable-libfaad"
]

# JW 07-06-11: Hash of commit or a HEAD should be used - not a tag. Sync action of Git
# provider will always attempt to update the git clone if a tag is used.
default['ffmpeg']['git_revision'] = "ace432f62cdcedf812e7c4d77fc5b03322170fa8" # 0.6.3
