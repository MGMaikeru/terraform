# **Terraform and Ansible Workshop Report**

**Miguel Gonzalez - A00395687**

## **Modularizing the project**

The modularization was done from the terraform configuration of the `terraform-vm-deploy` folder, leaving the folder structure as shown below:

![alt text](images/image.png)

Exploring the definition of the different `main.tf`:

1. Global main.tf:

   - The `provider` is declared.
   - The `resource_group` is declared where the rest of the elements are to be deployed.
   - We declare the `network` and `vm` modules that contain the rest of the elements.

![alt text](images/image1.png)

2. Network main.tf:

   - The `virtualnetwork` is declared.
   - The `subnet` is declared.

![alt text](images/image2.png)

3. VM main.tf:

   - The `network interface` for the VM is declared.
   - `Linux Virtual Machine` is defined.
   - Defines the `network security group` (NSG) for the VM.
   - `Association` between the network interface with the network security group.
   - Defines the `public IP` address for the VM.

![alt text](images/image3.png)

Exploring the different `output.tf`:

1. VM output.tf:
   - Returns the `public id`

![alt text](images/image5.png)

2. Network output.tf:
   - Return `subnet_id` required in the configuration of the vm module for use on the network interface.

![alt text](images/image4.png)

## **Deploying with terraform**

- `terraform init`:

![alt text](images/image6.png)

- `terraform validate`:

![alt text](images/image7.png)

- `terraform plan`:

![alt text](images/image8.png)
![alt text](images/image9.png)

- `terraform apply`:

![alt text](images/image10.png)

- Checking in azure:

![alt text](images/image11.png)

## **Using Ansible**

This part use the code avaible in `https://github.com/ChristianFlor/training-ansible`. Ansible allow to execute playbooks to automate tasks on remote servers and is not compatible with windows, so this section will be done in a WSL console.

It's necessary have the sshpass library installed in the linux environment:

![alt text](images/image12.png)

First, we need execute `ansible-playbook -i inventory/hosts.ini playbooks/install_docker.yml` where:

- `ansible-playbook`: Runs an Ansible playbook.
- `-i inventory/hosts.ini`: Specifies the inventory file (hosts.ini) located in the inventory/ directory. This file lists the target servers where the playbook will run.
- `playbooks/install_docker.yml`: This is the playbook being executed, located in the playbooks/ directory. It likely contains tasks to install Docker on the specified remote hosts.

![alt text](images/image13.png)

Second, execute `ansible-playbook -i inventory/hosts.ini playbooks/run_container.yml`:

- `playbooks/run_container.yml`: This playbook likely contains tasks to run a Docker container on the remote hosts. It could be pulling an image, creating a container, or ensuring a service is running inside Docker.

![alt text](images/image14.png)

We can check the container with `docker ps`. Now, we access the public url shown in azure along with the job we defined in the vm rules:

![alt text](images/image15.png)
