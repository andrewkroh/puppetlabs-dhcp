define dhcp::host (
  $mac,
  $ip       = undef,
  $comment  = undef,
  $subclass = undef,
) {
  
  validate_re($mac, '^([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})$')

  include dhcp::params

  $dhcp_dir = $dhcp::params::dhcp_dir

  concat::fragment { "dhcp_host_${name}":
    target  => "${dhcp_dir}/dhcpd.hosts",
    content => template('dhcp/dhcpd.host.erb'),
    order   => '10',
  }

  # Add a dependency on the DHCP class.
  if $subclass {
    Concat::Fragment["dhcp_host_${name}"] {
      require => Dhcp::Class[$subclass],
    }
  }

}

