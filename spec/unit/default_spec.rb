require 'spec_helper'

describe 'ffmpeg::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'include ffmpeg::source recipe by default' do
    chef_run.converge(described_recipe)
    expect(chef_run).to include_recipe('ffmpeg::source')
    expect(chef_run).not_to include_recipe('ffmpeg::package')
  end

  it 'include ffmpeg::package if attribute changed' do
    chef_run.node.set['ffmpeg']['install_method'] = :package
    chef_run.converge(described_recipe)
    expect(chef_run).to include_recipe('ffmpeg::package')
    expect(chef_run).not_to include_recipe('ffmpeg::source')
  end
end
