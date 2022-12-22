
data "aws_availability_zones" "vpc_azs" {
  state = "available"
}

data "aws_ebs_snapshot" "slave" {
  count = var.public_subnets_per_vpc
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "tag:Name"
    values = ["slave_volume_${var.enviroment}_${terraform.workspace}_${count.index+1}"]
  }
}

data "aws_ebs_snapshot" "master" {
  count = 1
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "tag:Name"
    values = ["master_volume_${var.enviroment}_${terraform.workspace}_${count.index+1}"]
  }
}

resource "aws_ebs_volume" "slave" {
  count = var.public_subnets_per_vpc
  availability_zone = data.aws_availability_zones.vpc_azs.names[count.index]
  final_snapshot = true
  snapshot_id = data.aws_ebs_snapshot.slave[count.index].id
  size = 3
  tags = merge(
    var.tags,
    {
      Name = "slave_volume_${var.enviroment}_${terraform.workspace}_${count.index+1}"
    },
  )
}
resource "aws_ebs_volume" "master" {
  count = 1
  availability_zone = data.aws_availability_zones.vpc_azs.names[count.index]
  snapshot_id = data.aws_ebs_snapshot.master[count.index].id
  final_snapshot = true
  size = 3
  tags = merge(
    var.tags,
    {
      Name = "master_volume_${var.enviroment}_${terraform.workspace}_${count.index+1}"
    },
  )
}
resource "aws_ebs_snapshot" "slave" {
  count = var.public_subnets_per_vpc
  volume_id = element(aws_ebs_volume.slave.*.id,count.index)

  tags = merge(
    var.tags,
    {
      Name = "slave_snap_${var.enviroment}_${terraform.workspace}_${count.index+1}"
    },
  )
}


resource "aws_volume_attachment" "ebs_att_slave" {
  count = var.public_subnets_per_vpc
  device_name = "/dev/sdh"
  volume_id   = element(aws_ebs_volume.slave.*.id,count.index)
  instance_id = element(aws_instance.slave.*.id,count.index)
  skip_destroy = true
}

resource "aws_volume_attachment" "ebs_att_master" {
  count = 1
  device_name = "/dev/sdh"
  volume_id   = element(aws_ebs_volume.master.*.id,count.index)
  instance_id = element(aws_instance.master.*.id,count.index)
  skip_destroy = true
}