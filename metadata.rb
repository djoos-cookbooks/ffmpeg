maintainer       "David Joos"
maintainer_email "development@davidjoos.com"
license          "MIT"
description      "Installs/Configures FFMPEG"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.3.1"

supports "ubuntu"

depends "x264"
depends "libvpx"
depends "build-essential"
depends "git"