# == Class: hponcfg
#
class hponcfg (
  $package_name   = 'hponcfg',
  $package_ensure = 'present',
  $xmlfiles       = undef,
) {

  validate_re($package_ensure, ['^present','^installed','^absent'])

  package { $package_name:
    ensure => $package_ensure,
  }

  if $xmlfiles {
    validate_array($xmlfiles)
    create_resources('hponcfg::xmlfile', $xmlfiles)
  }
}
