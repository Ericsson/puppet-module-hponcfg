# == Define: hponcfg::xmlfile
#
define hponcfg::xmlfile (
  $path    = $title,
  $owner   = 'root',
  $group   = 'root',
  $mode    = '0644',
  $content = undef,
  $source  = undef,
) {

  include hponcfg

  if $content {
    file { $path:
      ensure  => present,
      owner   => $owner,
      group   => $group,
      mode    => $mode,
      content => "${content}\n"
    }
  }
  elsif $source {
    file { $path:
      ensure  => present,
      owner   => $owner,
      group   => $group,
      mode    => $mode,
      source  => $source,
    }
  }
  else {
    fail('Invalid parameters. $content or $source must be set.')
  }

  exec { "hponcfg -f ${path}":
    path        => '/bin:/usr/bin:/sbin:/usr/sbin',
    refreshonly => true,
    subscribe   => File[$path],
    require     => [Package['hponcfg'],File[$path]],
  }
}
