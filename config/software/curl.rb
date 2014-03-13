#
# Copyright:: Copyright (c) 2012-2014 Chef Software, Inc.
# License:: Apache License, Version 2.0
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

name "curl"
default_version "7.35.0"

dependency "zlib"
dependency "openssl"

source :url => "http://curl.haxx.se/download/curl-7.35.0.tar.gz",
       :md5 => "f5ae45ed6e86debb721b68392b5ce13c"

relative_path 'curl-7.35.0'

build do
  command ["./configure",
           "--prefix=#{install_dir}/embedded",
           "--disable-debug",
           "--enable-optimize",
           "--disable-ldap",
           "--disable-ldaps",
           "--disable-rtsp",
           "--enable-proxy",
           "--disable-dependency-tracking",
           "--enable-ipv6",
           "--without-libidn",
           "--with-ssl=#{install_dir}/embedded",
           "--with-zlib=#{install_dir}/embedded"].join(" ")

  command "make -j #{max_build_jobs}", :env => {"LD_RUN_PATH" => "#{install_dir}/embedded/lib"}
  command "make install"
end
