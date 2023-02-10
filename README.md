# GCP_IaC_DevOps_Demo

 ![gcp](https://user-images.githubusercontent.com/103090890/217839906-7df20dbc-73b1-46f1-88cf-b656036c9e80.png)
![3](https://user-images.githubusercontent.com/103090890/218168065-77f65452-a56d-49b4-bf2a-f4cc81cc4391.png)

## Project Specifications 
![Screenshot from 2023-02-09 16-36-49](https://user-images.githubusercontent.com/103090890/217843113-dfda4ec4-7907-4f64-9716-27296ea589fa.png)

#### This infrastructure deploys a counter app  
#### Note : All Secrets And authentication must be done by you for security reasons 

-----------------------------

## Tools Used
- Terraform
- GCP 
- Kubernetes
- Jenkins (Bonus)
- Docker

------------------------------------

## Getting Started

- Setup you GCP account
- Make sure to install required tools such as (Terraform, Docker)

---------------

## Prerequisites 

- Install Terraform
- GCP Account
- (Bonus) Master Jenkins Up and Running

---------------------

## Installation 

- Clone This Repo
- Configure your GCP credentials 
``` bash
gcloud auth login
```
- Build The Dockerfile and push it to GCR 
``` bash
gcloud auth configure-docker
docker login
docker build . -t gcr.io/<docker-username>/py-app
docker push gcr.io/<docker-username>/py-app 
```
- Run Terraform files
```bash
terraform init
terraform apply
```

- After Terraform Creation SSH into VM and install ***kubectl*** or any needed software like ***gcloud*** ( You can use Ansible to Automate this step )

- Connect to the GKE private cluster 
``` bash
gcloud container clusters get-credentials <cluster_name> --zone <zone> --project <project_id>
```
- Copy the provided k8s files and run them by:
```bash
kubectl apply -f <file-name>
```

- Run the following command to get the IP Adress of your Application
``` bash
kubectl get ingress 
```
- Copy the IP address and insert it in your browser to access the Application 

- Now Your Infrastructure & Application Is Up and Running !!


------------------------------------

## Bonus (Jenkins)

- Included Jenkins file to automate the procces 

- Configure Your Jenkins Master and install terraform plugins ( Jenkins running in a container or pod)
 
- Run your authentication commands inside Jenkins Container

- Create a new pipeline and make it run from Jenkinsfile provided in this Repo

- Note : You can add Ansible playbook to automate configuration and installation of packages and k8s deployment (out of project scope)

- Note : This pipeline destroys the infrastructure after success of build ( for cost reasons ) to prevent this behaviour delete the ***post*** block from the Jenkinsfile

---------------------------------


## Screenshots 

![Screenshot from 2023-02-06 22-14-48](https://user-images.githubusercontent.com/103090890/217849654-8b1659f8-b629-4eeb-8c38-5a26b222c417.png)

-----------------

![Screenshot from 2023-02-06 22-15-09](https://user-images.githubusercontent.com/103090890/217849691-c00ff265-bc9b-45ee-b021-2805b5309e40.png)

--------------


![Screenshot from 2023-02-06 22-11-52](https://user-images.githubusercontent.com/103090890/217849559-8c6531e9-f267-4d65-a881-475ebc9196aa.png)

------------


![Screenshot from 2023-02-06 22-14-04](https://user-images.githubusercontent.com/103090890/217849569-e6277823-6f05-4ad8-832f-ee7d06716019.png)


--------------




![Screenshot from 2023-02-06 22-14-14](https://user-images.githubusercontent.com/103090890/217849618-b39c3b17-934c-4aab-a0a1-3be9f006316c.png)


---------------


![Screenshot from 2023-02-06 22-15-26](https://user-images.githubusercontent.com/103090890/217849750-255ff5ac-95c5-45b0-a863-9f66de0f394e.png)

---------------

![Screenshot from 2023-02-06 22-14-26](https://user-images.githubusercontent.com/103090890/217849628-7ed0b2ee-2577-4f0e-bca1-640296b215c6.png)

------------------------

![Screenshot from 2023-02-06 22-16-09](https://user-images.githubusercontent.com/103090890/217849785-e9775e0e-5945-4cf5-8eb7-3f7063f81882.png)

------------------------

![Screenshot from 2023-02-06 22-08-48](https://user-images.githubusercontent.com/103090890/217849904-e50af9f7-5733-4d3d-9120-d070bc9c5eb1.png)





# Thank You !!





