#
# Cookbook Name:: spades
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe 'apt' if node['platform_family'] == 'debian'

include_recipe 'build-essential'

package 'cmake'
package 'zlib1g-dev'
package 'libbz2-dev'

spades_file = "SPAdes-#{node['spades']['version']}"
download_file = "#{spades_file}.tar.gz"
download_url = "http://spades.bioinf.spbau.ru/release#{node['spades']['version']}/"

remote_file "#{Chef::Config[:file_cache_path]}/#{download_file}" do
  source download_url + download_file
end

directory node['spades']['src_dir'] do
  recursive true
end

execute 'untar_spades' do
  command "tar -zxvf #{Chef::Config[:file_cache_path]}/#{download_file} -C #{node['spades']['src_dir']}"
end

execute 'compile_spades' do
  cwd "#{node['spades']['src_dir']}/#{spades_file}"
  command "PREFIX=#{node['spades']['install_dir']} ./spades_compile.sh"
end

# NOTE: the 'filename' feature is only available in a pull request version of magic_shell,
#       NOT the Chef Supermarket version. Hence a custom Berksfile entry is required.
magic_shell_environment 'PATH' do
  filename 'SPADES_PATH.sh'
  value "$PATH:#{node['spades']['install_dir']}/bin"
end
