require 'spec_helper'

describe 'ffmpeg::package' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'install ffmpeg package' do
    expect(chef_run).to upgrade_package('ffmpeg')
  end
end
