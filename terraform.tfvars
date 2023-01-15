 vpc_cidr             = "10.10.0.0/16"
  name                 = "spotter-vpc"
  env                  = "dev"
  public_subnets_cidr  = ["10.10.0.0/24", "10.10.1.0/24", "10.10.2.0/24"]
  private_subnets_cidr = ["10.10.3.0/24", "10.10.4.0/24", "10.10.5.0/24"]
 



  #-----------------------------
  #----ECS

  ecr_repo_name= "spotter-frontend"
  task_definition_name= "spotter-frontend-td"
  containername= "spotter-frontend-container"
  container_port= 5173
  host_port=5173
  td_cpu= 256
  td_memory= 512
  container_memory=512
  container_cpu=256
  target_group_name="spotter-frontend-tg"
  load_balancer_name= "spotter-frontend-lb"
  ecs_cluster_name="spotter"
  ecs_service_name="spotter-frontend-service"