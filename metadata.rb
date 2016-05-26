name 'ffmpeg'
maintainer 'Escape Studios'
maintainer_email 'dev@escapestudios.com'
license 'MIT'
description 'Installs/Configures FFMPEG'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
issues_url 'https://github.com/djoos-cookbooks/ffmpeg/issues'
source_url 'https://github.com/djoos-cookbooks/ffmpeg'
version '0.4.4'

supports 'ubuntu'

depends 'x264'
depends 'libvpx'
depends 'git'
depends 'build-essential'
depends 'yasm'
