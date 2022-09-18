
 resource "aws_vpc" "Main" {                # Creating VPC here
   cidr_block       = "10.1.0.0/20"
   instance_tenancy = "default"

   enable_dns_hostnames = true
   enable_dns_support = true

  tags = {
    Name = "main"
  }
 }

 resource "aws_eip" "nateIP" {
   vpc   = true
 }


 resource "aws_internet_gateway" "IGW" {    # Creating Internet Gateway
    vpc_id =  aws_vpc.Main.id               # vpc_id will be generated after we create VPC
 }

 resource "aws_route_table" "PublicRT" {    # Creating RT for Public Subnet
    vpc_id =  aws_vpc.Main.id
         route {
    cidr_block = "0.0.0.0/0"               # Traffic from Public Subnet reaches Internet via Internet Gateway
    gateway_id = aws_internet_gateway.IGW.id
     }
 }

 

 resource "aws_nat_gateway" "NATgw" {
   allocation_id = aws_eip.nateIP.id
   subnet_id = aws_subnet.publicsubnets["spa"].id
 }


output spb {
  value       = aws_subnet.publicsubnets
}

 resource "aws_route_table" "PrivateRT" {    # Creating RT for Private Subnet
   vpc_id = aws_vpc.Main.id
   route {
   cidr_block = "0.0.0.0/0"             # Traffic from Private Subnet reaches Internet via NAT Gateway
   nat_gateway_id = aws_nat_gateway.NATgw.id
   }
 }



#--------------- private subnets -----------------#
        # Creating Private Subnets
resource "aws_subnet" "privatesubnets" {
  for_each = var.subnets_privadas
  vpc_id =  aws_vpc.Main.id
  cidr_block = "${each.value.rango}"  
  availability_zone = "${var.region}${each.value.az}"

  tags = {
    Name = "private-${each.value.rango}-${var.region}${each.value.az}"
  }
 }


 resource "aws_route_table_association" "PrivateRTassociation" {
    for_each = aws_subnet.privatesubnets
    subnet_id = each.value.id
    route_table_id = aws_route_table.PrivateRT.id
 }

#--------------- database private subnets -----------------#
          # Creating Private Subnets

 resource "aws_subnet" "privatesubnets_db" {
  for_each = var.subnets_privadas_db
  vpc_id =  aws_vpc.Main.id
  cidr_block = "${each.value.rango}"  
  availability_zone = "${var.region}${each.value.az}"


  tags = {
    Name = "private-db-${each.value.rango}-${var.region}${each.value.az}"
  }
 }


 resource "aws_route_table_association" "PrivateRTassociation_db" {
    for_each = aws_subnet.privatesubnets_db
    subnet_id = each.value.id
    route_table_id = aws_route_table.PrivateRT.id
 }

#--------------- public subnets -----------------#

resource "aws_subnet" "publicsubnets" {    
  for_each = var.subnets_publicas
  vpc_id =  aws_vpc.Main.id
  cidr_block = "${each.value.rango}"  
  availability_zone = "${var.region}${each.value.az}" 


  tags = {
    Name = "public-${each.value.rango}-${var.region}${each.value.az}"
  }
 }


 resource "aws_route_table_association" "PublicRTassociation" {
    for_each = aws_subnet.publicsubnets
    subnet_id = each.value.id
    route_table_id = aws_route_table.PublicRT.id
 }








/*
todo:
10.1.0.0/16

dev:
10.1.1.0/20

public:
10.1.1.0/24
10.1.2.0/24
10.1.3.0/24

private:
10.1.4.0/24
10.1.5.0/24
10.1.6.0/24

db private:
10.1.7.0/24
10.1.8.0/24
10.1.9.0/24

*/