name 'docker-systemd'
license 'MIT Licence'
description 'Cookbook for managing systemd files for docker'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

maintainer 'Gavin Staniforth'

source_url 'https://github.com/gsdevme/docker-systemd-cookbook'

supports 'centos'

chef_version '>= 12.6' if respond_to?(:chef_version)

depends 'yum-docker'
depends 'compat_resource'
