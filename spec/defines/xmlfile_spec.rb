require 'spec_helper'
describe 'hponcfg::xmlfile' do

  context 'create file from source when source is specified' do
    let (:title) { '/local/f1.xml' }
    let (:params) {
      {
        :source => 'puppet:///files/f1.xml',
        :owner  => 'user2',
        :group  => 'group2',
        :mode   => '0600',
      }
    }

    it { should contain_class('hponcfg') }

    it {
      should contain_file('/local/f1.xml').with({
        'ensure' => 'present',
        'owner'  => 'user2',
        'group'  => 'group2',
        'mode'   => '0600',
        'source' => 'puppet:///files/f1.xml',
      })
    }

    it {
      should contain_exec('hponcfg -f /local/f1.xml').with({
        'refreshonly' => 'true',
        'subscribe'   => 'File[/local/f1.xml]',
      })
    }
  end

  context 'create file when content is specified' do
    let (:title) { '/local/f2.xml' }
    let (:params) {
      {
        :content => '<RIBCL VERSION="2.0"></RIBCL>',
        :owner   => 'root2',
        :group   => 'root',
        :mode    => '0660',
      }
    }

    it { should contain_class('hponcfg') }

    it {
      should contain_file('/local/f2.xml').with({
        'ensure'  => 'present',
        'path'    => '/local/f2.xml',
        'owner'   => 'root2',
        'group'   => 'root',
        'mode'    => '0660',
      }).with_content(%{<RIBCL VERSION="2.0"></RIBCL>\n})
    }

    it {
      should contain_exec('hponcfg -f /local/f2.xml').with({
        'refreshonly' => 'true',
        'subscribe'   => 'File[/local/f2.xml]',
      })
    }
  end

  context 'if neither content or source is specified' do
    let (:title) { '/local/f1.xml' }

    it 'should fail' do
      expect {
        should contain_class('hponcfg')
      }.to raise_error(Puppet::Error,/Invalid parameters. \$content or \$source must be set/)
    end
  end
end
