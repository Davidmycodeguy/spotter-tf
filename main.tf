provider "aws" {
  region     =  var.region   
}


module "vpc" {
  source = "./module/vpc"
  vpc_cidr             = var.vpc_cidr
  name                 = var.name
  env                  = var.env
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  availability_zones   = data.aws_availability_zones.available.names
  name_of_security_group = "ssh-http"
}


module "ecs" {
source= "./module/ecs"
vpc_id= module.vpc.vpc_id
#---------------------ECR------------------- 
ecr_repo_name=var.ecr_repo_name  
#------------LOAD BALANCER AND TARGET GROUP---------
loadbalancer_sg=module.vpc.loadbalancer_sg
public_subnets= module.vpc.public_subnets
target_group_name=var.target_group_name
load_balancer_name=var.load_balancer_name
#-----------TASK DEFINITION-------------------
task_definition_name= var.task_definition_name
containername= var.containername
container_port= var.container_port
host_port=var.host_port
td_memory=var.td_memory
td_cpu= var.td_cpu
container_memory=var.container_memory
container_cpu=var.container_cpu
#---------------------ECS CLUSTER & SERVICE--------------
ecs_cluster_name=var.ecs_cluster_name
ecs_service_name=var.ecs_service_name
ECS_sg=module.vpc.ECS_sg
private_subnets= module.vpc.private_subnets
} 
  
module "backend-ecs" {
source= "./module/backend-ecs"
vpc_id= module.vpc.vpc_id
#---------------------ECR------------------- 
ecr_repo_name="spotter-backend"  
#------------LOAD BALANCER AND TARGET GROUP---------
loadbalancer_sg=module.vpc.loadbalancer_sg
public_subnets= module.vpc.public_subnets
target_group_name="spotter-backend-tg"
load_balancer_name="spotter-backend-lb"
#-----------TASK DEFINITION-------------------
task_definition_name= "spotter-backend-td"
containername= "spotter-backend-container"
container_port= 3005
host_port=3005
td_memory=512
td_cpu= 256
container_memory=512
container_cpu=256
#---------------------ECS CLUSTER & SERVICE--------------
ecs_cluster_name=module.ecs.ecs_cluster_id
ecs_service_name="spotter-backend-service"
ECS_sg=module.vpc.ECS_sg
private_subnets= module.vpc.private_subnets
} 
  