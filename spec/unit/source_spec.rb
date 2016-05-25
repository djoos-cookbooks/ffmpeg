require 'spec_helper'

describe 'ffmpeg::source' do
  let(:prerequisite_packages) do
    %w(
      libfaac-dev
      libmp3lame-dev
      libtheora-dev
      libxvidcore-dev
      libfaad-dev
      libfaad-dev
    )
  end

  before do
    allow_any_instance_of(Chef::Recipe).to receive(:ffmpeg_packages).and_return(%w(ffmpeg))
    allow_any_instance_of(Chef::Recipe).to receive(:prerequisite_packages_by_flags).and_return(prerequisite_packages)
  end

  let(:chef_run) { ChefSpec::ServerRunner.new.converge(described_recipe) }
  let(:creates_ffmpeg) { "#{chef_run.node['ffmpeg']['prefix']}/bin/ffmpeg" }

  it 'include build-essential::default recipe' do
    expect(chef_run).to include_recipe('build-essential::default')
  end

  it 'include git::default recipe' do
    expect(chef_run).to include_recipe('git::default')
  end

  it 'include yasm::default recipe' do
    expect(chef_run).to include_recipe('yasm::default')
  end

  it 'purge ffmpeg packages' do
    expect(chef_run).to purge_package('ffmpeg')
  end

  it 'include x264::source recipe' do
    expect(chef_run).to include_recipe('x264::source')
  end

  it 'include libvpx::source recipe' do
    expect(chef_run).to include_recipe('libvpx::source')
  end

  it 'install prerequisite_packages_by_flags' do
    prerequisite_packages.each do |p|
      expect(chef_run).to upgrade_package p
    end
  end

  it 'sync ffmpeg git repo' do
    expect(chef_run).to sync_git("#{Chef::Config['file_cache_path']}/ffmpeg")
  end

  it 'git[../ffmpeg] should notify file[../bin/ffmpeg] to delete' do
    g = chef_run.git("#{Chef::Config['file_cache_path']}/ffmpeg")
    expect(g).to notify("file[#{creates_ffmpeg}]").to(:delete)
  end

  it 'create ffmpeg-compiled_with_flags template' do
    expect(chef_run).to create_template("#{Chef::Config['file_cache_path']}/ffmpeg-compiled_with_flags")
  end

  it 'template[../ffmpeg-compiled_with_flags] should notify file[../bin/ffmpeg] to delete' do
    t = chef_run.template("#{Chef::Config['file_cache_path']}/ffmpeg-compiled_with_flags")
    expect(t).to notify("file[#{creates_ffmpeg}]").to(:delete)
  end

  it 'compile ffmpeg' do
    expect(chef_run).to run_bash('compile_ffmpeg')
  end
end
