require 'spec_helper'
describe 'hponcfg' do

  it { should compile.with_all_deps }

  context 'with default options' do
    it { should contain_class('hponcfg') }

    it {
      should contain_package('hponcfg').with({
        'ensure' => 'present',
      })
    }
  end

  context 'with pacakge_name and package_ensure set' do
    let :params do
      {
        :package_name => ['hponcfg','hponcfg-custom'],
        :package_ensure => 'installed',
      }
    end
    ['hponcfg', 'hponcfg-custom'].each do |pkg|
      it {
        should contain_package(pkg).with({
          'ensure' => 'installed',
        })
      }
    end
  end
end
