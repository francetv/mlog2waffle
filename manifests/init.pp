class mlog2waffle (
 $fle_address           = undef,
 $fle_sensor            = undef,
 $fle_password          = undef,
 $lib1              = 'libwww-perl',
 $lib2              = 'libfile-pid-perl',
 $lib3              = 'libfile-tail-perl',
 $config_file        = '/etc/mlog2waffle.conf',
 $bin_file           = '/usr/local/mlog2waffle/mlog2waffle',
 $init_file         = '/etc/init.d/mlog2waffle',

){
 
 package { $lib3:
    ensure => present,
    before   => File[$config_file],
 }
 package { $lib2:
    ensure => present,
    before   => File[$config_file],
 }
 package { $lib1:
    ensure => present,
    before   => File[$config_file],
 }

  file { "/usr/local/mlog2waffle":
    ensure          => directory,
    owner           => 'root',
    group           => 'root',
    mode            => '0775',
    before          => File[$bin_file],
  }
  file { $bin_file:
    content => template('mlog2waffle/mlog2waffle.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    notify  => Service['mlog2waffle'],
  }
  file { $init_file:
    content => template('mlog2waffle/mlog2waffle.service.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    notify  => Service['mlog2waffle'],
  }
  file { $config_file:
    content => template('mlog2waffle/mlog2waffle.conf.erb'),
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    notify  => Service['mlog2waffle'],
  }
  file { '/etc/init.d/mlog2waffle':
    source  => $init_script,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    notify  => Service['mlog2waffle'],
  }
  service { 'mlog2waffle':
    ensure    => running,
    enable    => true,
    hasstatus => true,
  }
}

