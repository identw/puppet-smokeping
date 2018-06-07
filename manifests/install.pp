class smokeping::install {

  if $smokeping::params::install_options {
    package { 'smokeping':
      ensure          => $smokeping::version,
      install_options => $smokeping::params::install_options,
    }
  } else {
    package { 'smokeping':
      ensure          => $smokeping::version,
    }
  }

  if ! defined (Package['fping']) {
    ensure_packages(['fping'])
  }
  if ! defined (Package[$smokeping::package_perldoc]) {
    ensure_packages([$smokeping::package_perldoc])
  }

  # correct permissions
  file { $smokeping::path_datadir:
    ensure  => directory,
    owner   => $smokeping::daemon_user,
    group   => $smokeping::daemon_group,
    require => Package['smokeping'],
    recurse => true,
  }
  file { $smokeping::path_piddir:
    ensure  => directory,
    owner   => $smokeping::daemon_user,
    group   => $smokeping::daemon_group,
    require => Package['smokeping'],
    recurse => true,
  }
  file { $smokeping::path_imgcache:
    ensure  => directory,
    owner   => $smokeping::webserver_user,
    group   => $smokeping::webserver_group,
    require => Package['smokeping'],
    recurse => true,
  }

}
