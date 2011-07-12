maintainer       "En Masse Entertainment"
maintainer_email "jamie@enmasse.com"
license          "Apache 2.0"
description      "Installs and configures FFMPEG from source or package"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.2"

supports "ubuntu", "10.04"

depends "x264", "~> 0.1.1"
depends "libvpx", "~> 0.1.1"
depends "build-essential"
depends "git"
