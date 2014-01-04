Description
===========

This cookbook provides an easy way to install FFMPEG.

More information?
* [FFMPEG](http://www.ffmpeg.org/)

Requirements
============

## Cookbooks:

This cookbook has dependencies on the following cookbooks:

* build-essential
* git
* x264
* libvpx

## Platforms:

* Ubuntu

Attributes
==========

* `node['ffmpeg']['install_method']` - Installation method, ':source' or ':package' - default ':source'
* `node['ffmpeg']['prefix']` - Location prefix of where the installation files will go if installing via ':source'
* `node['ffmpeg']['git_repository']` - Location of the source git repository if installing via ':source'
* `node['ffmpeg']['git_revision']` - Revision of the git repository to install if installing via ':source'
* `node['ffmpeg']['compile_flags']` - Array of flags to use in compilation process if installing via ':source'

References
==========

* a very big thanks to reset <jamie@vialstudios.com> for the original version of this cookbook

License and Authors
===================

Author: Jamie Winsor <jamie@vialstudios.com>
Copyright: 2011-2013, En Masse Entertainment, Inc

Author: David Joos <development@davidjoos.com>
Copyright: 2014, David Joos

Unless otherwise noted, all files are released under the MIT license,
possible exceptions will contain licensing information in them.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.