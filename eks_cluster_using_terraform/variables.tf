# Variables Configuration
variable "aws_access_key" {
  default = "AKIAJXWGAHPIG6QRHRSA"
}

variable "aws_secret_key" {
  default = "sWk1YHHRieHCTPFCEjThb9ta/hRj6Ivsufhf+bzV"
}


variable "cluster-name" {
  default     = "my-cluster"
  type        = "string"
  description = "The name of your EKS Cluster"
}

variable "aws-region" {
  default     = "us-east-2"
  type        = "string"
  description = "The AWS Region to deploy EKS"
}

variable "k8s-version" {
  default     = "1.12"
  type        = "string"
  description = "Required K8s version"
}

variable "vpc-subnet-cidr" {
  default     = "10.0.0.0/16"
  type        = "string"
  description = "The VPC Subnet CIDR"
}

variable "node-instance-type" {
  default     = "t2.micro"
  type        = "string"
  description = "Worker Node EC2 instance type"
}


variable "key_name" {
  default     = "my-server"
  type        = "string"
  description = "SSH key file name to log in to instances"
}

variable "desired-capacity" {
  default     = 2
  type        = "string"
  description = "Autoscaling Desired node capacity"
}

variable "max-size" {
  default     = 3
  type        = "string"
  description = "Autoscaling maximum node capacity"
}


variable "min-size" {
  default     = 2
  type        = "string"
  description = "Autoscaling Minimum node capacity"
}
