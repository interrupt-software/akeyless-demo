resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnets_cidr
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true
  tags = {
    name = "${var.prefix}-public-subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnets_cidr
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = false
  tags = {
    name = "${var.prefix}-private-subnet"
  }
}

resource "aws_security_group" "trendy-tabby" {
  name = "${var.prefix}-security-group"

  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name = "${var.prefix}-security-group"
  }
}

resource "aws_internet_gateway" "trendy-tabby" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.prefix}-internet-gateway"
  }
}

resource "aws_route_table" "trendy-tabby" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.trendy-tabby.id
  }
}

resource "aws_route_table_association" "trendy-tabby" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.trendy-tabby.id
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_eip" "trendy-tabby" {
  instance = aws_instance.trendy-tabby.id
  domain      = "standard"
}

resource "aws_eip_association" "trendy-tabby" {
  instance_id   = aws_instance.trendy-tabby.id
  allocation_id = aws_eip.trendy-tabby.id
}

resource "aws_instance" "trendy-tabby" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.trendy-tabby.key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.trendy-tabby.id]

  # root disk
  root_block_device {
    volume_size           = "20"
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }
  # data disk
  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = "50"
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }

  tags = {
    Name = "${var.prefix}-trendy-tabby-instance"
  }
}

resource "aws_db_subnet_group" "database" {
  name       = "trendy-tabby-db-sng"
  subnet_ids = [aws_subnet.public.id, aws_subnet.private.id]

  tags = {
    Name = "RDS DB subnet group"
  }
}

resource "aws_security_group" "database" {
  name        = "database"
  description = "Allow inbound traffic to database"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description     = "Allow inbound from products API"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.trendy-tabby.id]
  }

  ingress {
    description = "Allow inbound from public subnets"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# resource "aws_db_instance" "postgres" {
#   allocated_storage      = 10
#   engine                 = "postgres"
#   engine_version         = "14.3"
#   instance_class         = "db.t3.micro"
#   db_name                = "tfefdo"
#   identifier             = "tfefdo"
#   username               = var.database_username
#   password               = var.database_password
#   db_subnet_group_name   = aws_db_subnet_group.database.name
#   vpc_security_group_ids = [aws_security_group.database.id]
#   publicly_accessible    = false
#   skip_final_snapshot    = true
#   availability_zone      = "${var.region}a"
#   tags = {
#     Component = "trendy-tabby fdo"
#   }
# }

resource "tls_private_key" "trendy-tabby" {
  algorithm = "ED25519"
}

locals {
  private_key_filename = "key.pem"
  public_key_filename = "pub_key.pem"
}

resource "aws_key_pair" "trendy-tabby" {
  key_name   = local.private_key_filename
  public_key = tls_private_key.trendy-tabby.public_key_openssh
}

resource "null_resource" "tls_private_key" {
  provisioner "local-exec" {
    command = "echo \"${tls_private_key.trendy-tabby.private_key_openssh}\" > ${local.private_key_filename}"
  }

  provisioner "local-exec" {
    command = "echo \"${tls_private_key.trendy-tabby.public_key_pem}\" > ${local.public_key_filename}"
  }

  provisioner "local-exec" {
    command = "chmod 600 ${local.private_key_filename}"
  }
}
