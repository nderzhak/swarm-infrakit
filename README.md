# Deploy a Docker Swarm cluster with InfraKit

## Bootstrap

First, the cluster should be bootstrapped to get InfraKit running and ready to deploy the Swarm cluster.

Available bootstraps:

#### AWS

The Cloudformation template ```bootstrap.yml``` creates a VPC, subnet, internet gateway and the minimum required to build EC2 instances.
Select the instance type and the name of the EC2 Key pair name.
One EC2 instance will be created and will run InfraKit, it's public IP is revealed in the Cloudformation outputs.

#### DigitalOcean

Coming soon

#### Docker in Docker

bootstrap.sh -p docker

## Deploy

The InfraKit instance renders the ```config.tpl``` template, and watches the resulting file (config.json).
The result is the full Swarm cluster.

## Security

The Swarm cluster is by default secured with self managed certificates.
The manager node remote API is enabled to allow nodes to get the join token, certificates are signed by a CA hosted on the bootstrap instance to enable mutual authentication.
The certificate management is only for demonstration purpose, not for production.
