
ec2_instance { 'Puppet-Client':
  ensure => present,
  region => 'eu-central-1',
  availability_zone => 'eu-central-1a',
  subnet => 'subnet-24dcf34d',
  image_id => 'ami-1e339e71',
  instance_type => 't2.micro',
  monitoring => false,
  key_name => 'crossover',
  iam_instance_profile_name     => 's3iam',
  security_groups => ['General Firewall'],
  user_data => template('/home/ubuntu/setup.sh'),
  tags => {
    tag_name => 'crossover',
  },
}
