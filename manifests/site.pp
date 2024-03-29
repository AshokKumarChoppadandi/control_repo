node puppetagent3 {
  file { '/root/README.md':
    ensure  => file,
    content => "Hello! This message is written by PUPPET.",
    owner   => 'bigdata',
    group   => 'bigdata',
    mode    => '0744',
  }

  include create_user
  # Other way
  # Syntax
  # class { '<classname>':
  #   ensure => 'present',
  # }
  # Example:
  # class { 'system_usre_class':
  #   ensure => 'present',
  # }

  docker::run { 'docker-db.puppet.vm':
    ensure => absent,
    image  => 'agent',
  }

  docker::run { 'docker-web.puppet.vm':
    ensure => absent,
    image  => 'agent',
  }

  file { '/root/Test.txt':
    ensure  => file,
    # Here '$' is used for variable substitution
    # Built in variables are defined by puppet itself and few from 'Facter'
    content => $fqdn,
  }

  file { '/root/Test2.txt':
    ensure  => file,
    # This is the String interpolation or String substitution.
    content => "This host name is ${fqdn}\n",
  }
}

node puppetmaster {
  include role::puppet_master_server
  ## include role::puppet_agent_server

  docker::run { 'db.puppet.vm':
    ensure => 'absent',
    image => 'agent',
  }

  docker::run { 'web.puppet.vm':
    ensure => 'absent',
    image => 'agent',
  }
}

# node /^web/ {
#   include role::app_server
# }

# node /^db/ {
#   include role::db_server
# }
