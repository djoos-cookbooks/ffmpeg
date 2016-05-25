require 'spec_helper'

describe 'ffmpeg::package' do
  before do
    allow_any_instance_of(Chef::Recipe).to receive(:ffmpeg_packages).and_return(%w(ffmpeg))
  end

  let(:chef_run) { ChefSpec::ServerRunner.new.converge(described_recipe) }

  it 'install ffmpeg package' do
    expect(chef_run).to upgrade_package('ffmpeg')
  end
end
