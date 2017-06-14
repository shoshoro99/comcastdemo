

ec2_vpc_internet_gateway { 'comcast-igw':
  ensure => absent,
  region => 'us-east-2',
} ~>

ec2_vpc_subnet { 'comcast-subnet':
  ensure => absent,
  region => 'us-east-2',
} ~>

ec2_securitygroup { 'comcast-security-group':
  ensure   => absent,
  region => 'us-east-2',
} ~>

ec2_vpc_routetable { 'comcast-routes':
  ensure => absent,
  region => 'us-east-2',
} ~>

ec2_vpc { 'comcast-vpc':
  ensure => absent,
  region => 'us-east-2',
} ~>

ec2_instance { 'comcastdemo':
  ensure => absent,
  region => 'us-east-2',
}

