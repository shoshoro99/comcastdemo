

ec2_vpc { 'comcast-vpc':
  ensure     => present,
  region     => 'us-east-2',
  cidr_block => '10.0.0.0/16',
  tags       => {
    tag_name => 'comcastdemo',
  },
}
ec2_vpc_subnet { 'comcast-subnet':
  ensure                  => present,
  region                  => 'us-east-2',
  cidr_block              => '10.0.0.0/24',
  availability_zone       => 'us-east-2a',
  map_public_ip_on_launch => true,
  vpc                     => 'comcast-vpc',
  route_table             => 'comcast-routes',
  tags                    => {
    tag_name              => 'comcastdemo',
  },
}

ec2_vpc_internet_gateway { 'comcast-igw':
  ensure => present,
  region => 'us-east-2',
  vpc    => 'comcast-vpc',
}

ec2_vpc_routetable { 'comcast-routes':
  ensure => present,
  region => 'us-east-2',
  vpc    => 'comcast-vpc',
  routes => [
    {
      destination_cidr_block => '10.0.0.0/16',
      gateway                => 'local'
    },{
      destination_cidr_block => '0.0.0.0/0',
      gateway                => 'comcast-igw'
    },
  ],
}

ec2_securitygroup { 'comcast-security-group':
  ensure      => present,
  region      => 'us-east-2',
  vpc         => 'comcast-vpc',
  description => 'comcast demo security-group description',
  ingress     => [{
    protocol  => 'tcp',
    port      => 22,
    cidr      => '0.0.0.0/0',
       },
        {
    protocol  => 'tcp',
    port      => 80,
    cidr      => '0.0.0.0/0',
    },{
    protocol  => 'tcp',
    port      => 8140,
    cidr      => '0.0.0.0/0',
    },
    ],
  tags        => {
    tag_name  => 'comcastdemo',
  },
}


ec2_instance { 'comcastdemo2':
  ensure            => running,
  region            => 'us-east-2',
  availability_zone => 'us-east-2a',
  image_id          => 'ami-4191b524', 
  instance_type     => 't2.micro',
  key_name          => 'comcast_project',
  subnet            => 'comcast-subnet',
  security_groups   => ['comcast-security-group'],
  tags              => {
    tag_name => 'comcastdemo',
  },
}

