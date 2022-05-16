node puppetagent3 {
  file { '/root/README.md':
    ensure  => file,
    content => "Hello! This message is written by PUPPET.",
    owner   => 'bigdata',
    group   => 'bigdata',
    mode    => '0744',
  }
}
