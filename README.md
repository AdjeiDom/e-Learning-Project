E-LEARNING PROJECT

This demo shows an orchestration of an e-learning portal using Amazon ECS

index.html with pure js and css styles
nodejs backend with express module
mongodb for data storage

All components are docker-based


Final Project
Amazon ECS.

This is a production project. 

Amazon’s Elastic Container Service (ECS) is a fully managed container orchestration platform that's used to manage and run containerized applications on clusters of EC2 instances.
If you're new to ECS, it's recommended to experiment with it in the web console first. Rather than configuring all the underlying network resources, IAM roles and policies, and logs manually, let ECS create these for you. You'll just need to set up ECS, a Load Balancer, Listener, Target Group, and RDS. Once you feel comfortable then move on to Terraform.

Create a platform for an e-learning company
The platform is for e-learning company, they want to take advantage of Government programme to retrain graduates into IT. Currently they don’t have a robust platform that can take care of all the needs of their students. They want to build a more robust platform that can orchestrate their docker applications and also that can scale. 

Use Terraform to build this environment. Remember they have containerised all their applications. All their images are stored in ECR. 

Make sure you build a code for DEV environment, TEST environment, STAGING environment and PROD Environment. The Port for PROD should be 443. All other environment is port 80. 

Push all your finished codes to a git repo.

Create a personal jira account to help you manage this project. Make sure to update the jira ticket daily. You can get a free standard jira account. 

Provision a Jenkins server using a Jenkinsfile to deploy your code to AWS platform.  



##
## REFER TO THIS LINK FOR THE ARCHITECTING DIAGRAM:
<img src=**'elearn architecting.jpg'** alt="elearning-diagram"> C:\Users\Ethel Adjei\Desktop\DEVOPS - AWS Training\CloudRock Academy\DevOps\projects\E-Learning Project\modules\elearn architecing.jpg
##  




The Application the ECS will orchestrate is Nginx server. 

Create an image and send to ECR, use Nginx. Make sure to create your Dockerfile. 

Create VPC, Security groups, Key pairs, Internet Gateway, Routing tables, Load Balancers, Listeners, and Target Groups, IAM Role and Policies, RDS, Health Checks and logs and ECR, launch config, auto scaling group


Create ECS: task definition, cluster, service, Fargate, 

Create both port 80 and port 443 for ingress. 

Domain and SSL Certificate (you can buy a domain name in Amazon for £12)


I wish you all the best. 
