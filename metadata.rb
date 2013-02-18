maintainer       "En Masse Entertainment"
maintainer_email "jamie@vialstudios.com"
license          "Apache 2.0"
name             "ffmpeg"
description      "Installs and configures FFMPEG from source or package"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.2.1"

supports "ubuntu", "10.04"
supports "amazon", "2012.09"

depends "x264", "~> 0.3.0"
depends "libvpx", "~> 0.2.0"
depends "build-essential"
depends "git"
depends "yasm"
