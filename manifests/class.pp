define dhcp::class (
  $comment    = '',
  $parameters = 'match hardware',
) {

  include dhcp::params

  $dhcp_dir = $dhcp::params::dhcp_dir

  concat::fragment { "dhcp_class_${name}":
    target  => "${dhcp_dir}/dhcpd.hosts",
    content => template('dhcp/dhcpd.class.erb'),
    order   => '05',
  }

}

