resource "aws_instance" "slave" {
  ami           = var.ami-slave
  instance_type = var.instance_type
  count = length(var.subnet) * var.instances_per_subnet
  iam_instance_profile = var.aws_iam_instance_profile
  subnet_id      = element(var.subnet, count.index)
  key_name = var.keyname
  security_groups =  [var.security_groups]
  user_data = file("${path.module}/jenkins.sh")
  user_data_replace_on_change = "true"  
  tags = merge(
    var.tags,
    {
      Name = "slave_instance_${var.enviroment}_${count.index+1}_${terraform.workspace}"
    },
  )
  volume_tags ={
      Name = "slave_instance_${var.enviroment}_${count.index+1}_${terraform.workspace}"
    }
}

resource "aws_instance" "master" {
  ami           = var.ami-master
  instance_type = var.instance_type
  count = 1
  iam_instance_profile = var.aws_iam_instance_profile
  subnet_id      = element(var.subnet, count.index)
  key_name = var.keyname
  user_data = file("${path.module}/jenkins2.sh")
  user_data_replace_on_change = "true"  
  security_groups =  [var.security_groups]
  tags = merge(
    var.tags,
    {
      Name = "master_instance_${var.enviroment}_${count.index+1}_${terraform.workspace}"
    },
  )
  volume_tags ={
      Name = "master_instance_${var.enviroment}_${count.index+1}_${terraform.workspace}"
    }
}

resource "aws_eip" "master_ip" {
  count = 1
  vpc = true
  instance = element(aws_instance.master.*.id,count.index)
  tags = merge(
    var.tags,
    {
      Name = "eip_master_${var.enviroment}_${count.index+1}"
    },
  )     
}

resource "aws_eip" "slave_ip" {
  count = length(var.subnet) * var.instances_per_subnet
  vpc = true
  instance = element(aws_instance.slave.*.id,count.index)
  tags = merge(
    var.tags,
    {
      Name = "eip_slave_${var.enviroment}_${count.index+1}"
    },
  )     
}

/* resource "null_resource" "jenkins_server1" {
  provisioner "local-exec" {
    interpreter = ["/bin/bash" ,"-c"]
    command = "scp -o StrictHostKeyChecking=no -i /home/liz/Downloads/lizasraf.pem modules/compute/jenkins2.sh ec2-user@${aws_eip.master_ip[0].public_ip}:jenkins.sh"
  }
  depends_on = [aws_eip.master_ip,aws_eip.slave_ip ]
}

resource "null_resource" "jenkins_server2" {
  provisioner "local-exec" {
    interpreter = ["/bin/bash" ,"-c"]
    command = "scp -o StrictHostKeyChecking=no -i /home/liz/Downloads/lizasraf.pem modules/compute/jenkins.sh ec2-user@${aws_eip.slave_ip[0].public_ip}:jenkins.sh"
  }
  depends_on = [aws_eip.master_ip,aws_eip.slave_ip ]
}

resource "null_resource" "jenkins_server3" {
  provisioner "local-exec" {
    interpreter = ["/bin/bash" ,"-c"]
    command = "ssh -o StrictHostKeyChecking=no -i /home/liz/Downloads/lizasraf.pem ec2-user@${aws_eip.master_ip[0].public_ip} ./jenkins.sh"
  }
  depends_on = [ aws_volume_attachment.ebs_att_master ]
}

resource "null_resource" "jenkins_server4" {
  provisioner "local-exec" {
    interpreter = ["/bin/bash" ,"-c"]
    command = "ssh -o StrictHostKeyChecking=no -i /home/liz/Downloads/lizasraf.pem ec2-user@${aws_eip.slave_ip[0].public_ip} ./jenkins.sh"
  }
  depends_on = [ aws_volume_attachment.ebs_att_slave ]
} */