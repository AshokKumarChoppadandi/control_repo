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

  include role::puppet_agent_server
}

node puppetmaster {
  include role::puppet_master_server
}
