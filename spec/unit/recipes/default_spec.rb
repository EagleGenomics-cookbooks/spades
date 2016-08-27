#
# Cookbook Name:: spades
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'spades::default' do
  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04').converge(described_recipe) }

  # default: make sure the converge works
  it 'converges successfully' do
    expect { chef_run }.to_not raise_error
  end

  # make sure that kraken isntall is performed
  it 'install spades' do
    expect(chef_run).to run_execute('PREFIX=' + chef_run.node['spades']['install_dir'] + ' ./spades_compile.sh')
  end

  # make sure that the kraken directory is added to the path
  it 'adds spades path to PATH' do
    expect(chef_run).to add_magic_shell_environment('PATH')
  end
end
