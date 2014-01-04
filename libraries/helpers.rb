#
# Cookbook Name:: ffmpeg
# Library:: helpers
#
# Copyright 2014, David Joos
#

module FFMPEG
    module Helpers
        # Returns an array of strings representing the names of packages that are the 
        # prerequisites of the given array of compilation flags for FFMPEG. Package 
        # names returned are determined by the platform running this recipe.
        def find_prerequisite_packages_by_flags(compile_flags)      
            packages = []
            compile_flags.each do |flag|
                packages = packages | packages_for_flag(flag)
            end

            packages
        end
    
        # Returns an array of package names that will install FFMPEG on a node.
        # Package names returned are determined by the platform running this recipe.
        def ffmpeg_packages
            value_for_platform(
                [ "ubuntu" ] => { "default" => [ "ffmpeg" ] },
                "default" => [ "ffmpeg" ]
            )
        end
    
        private
    
        def packages_for_flag(flag)
            case flag
                when "--enable-libfaac"
                  value_for_platform(
                    [ "ubuntu" ] => { "default" => [ "libfaac-dev" ] },
                    "default" => [ "libfaac-dev" ]
                  )
                when "--enable-libmp3lame"
                  value_for_platform(
                    [ "ubuntu" ] => { "default" => [ "libmp3lame-dev" ] },
                    "default" => [ "libmp3lame-dev" ]
                  )
                when "--enable-libtheora"
                  value_for_platform(
                    [ "ubuntu" ] => { "default" => [ "libtheora-dev" ] },
                    "default" => [ "libtheora-dev" ]
                  )
                when "--enable-libvorbis"
                  value_for_platform(
                    [ "ubuntu" ] => { "default" => [ "libvorbis-dev" ] },
                    "default" => [ "libvorbis-dev" ]
                  )
                when "--enable-libxvid"
                  value_for_platform(
                    [ "ubuntu" ] => { "default" => [ "libxvidcore-dev" ] },
                    "default" => [ "libxvidcore-dev" ]
                  )
                when "--enable-libfaad"
                  value_for_platform(
                    [ "ubuntu" ] => { "default" => [ "libfaad-dev" ] },
                    "default" => [ "libfaad-dev" ]
                  )
                when "--enable-libvpx"
                  value_for_platform(
                    [ "ubuntu" ] => { "default" => [ "libvpx-dev" ] },
                    "default" => [ "libvpx-dev" ]
                  )
                when "--enable-libx264"
                  value_for_platform(
                    [ "ubuntu" ] => { "default" => [ "libx264-dev" ] },
                    "default" => [ "libx264-dev" ]
                  )
                else
                  []
                end
            end
        end
end

class Chef::Recipe
    include FFMPEG::Helpers
end