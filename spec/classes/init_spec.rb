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

  context 'with package_name and package_ensure set' do
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

  context 'with valid hash of xmlfiles set' do
    let :params do
      {
        :xmlfiles => {
          '/local/file1.xml' => {
            'content' => '<RIBCL VERSION="2.0"></RIBCL>',
          },
          '/local/file2.xml' => {
            'owner'  => 'user2',
            'source' => 'puppet:///files/file2.xml',
          }
        }
      }
    end

    it { should contain_class('hponcfg') }

    it {
      should contain_file('/local/file1.xml').with({
        'ensure'  => 'present',
        'path'    => '/local/file1.xml',
        'owner'   => 'root',
        'group'   => 'root',
      }).with_content(%{<RIBCL VERSION="2.0"></RIBCL>\n})
    }
    it {
      should contain_file('/local/file2.xml').with({
        'ensure' => 'present',
        'owner'  => 'user2',
        'group'  => 'root',
        'source' => 'puppet:///files/file2.xml',
      })
    }
  end

  context 'with invalid package_ensure' do
    let (:params) { { :package_ensure => 'stopped' } }

    it 'should fail' do
      expect {
        should contain_class('hponcfg')
      }.to raise_error()
    end
  end

  context 'with invalid xmlfiles hash' do
    let (:params) { { :xmlfiles => 'string' } }

    it 'should fail' do
      expect {
        should contain_class('hponcfg')
      }.to raise_error()
    end
  end
end
