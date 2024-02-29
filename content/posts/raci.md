---
title: "Sample AWS Services RACI"
date: 2022-01-21
---

This document is a sample policy of how a central cloud team (a.k.a, "CenTech") can govern the use of cloud services within a large organization (a.k.a "MegaCorp") under a product named "SoftBorders".

The SoftBorders product has a few different flavors and the below table can be used as a reference throughout the document:

| Product  | Description | Synonyms |
|----------|-------------|----------|
| SoftBorders Standard | Connected to corporate network via DirectConnect or Expressroute with pre-assigned routable address space | SB Standard |
| SoftBorders Limited | Disconnected account with no reachback to MegaCorp and therefore less risky | SB Limited |

---

All cloud accounts and subscriptions at MegaCorp are provisioned under an internal product offering called SoftBorders. The ownership of the SoftBorders account or subscription is then handed over to an internal customer within a specific MegaCorp business. SoftBorders provides some corporate level controls for cloud while trying to give the customer as much freedom as possible. This can cause some confusion over the scope of responsibility between CentTech and the owning business. This can get especially confusing when evaluating the use of specific cloud vendor provided services as there are many nuances between their controls at the corporate and business level. 

This document is intended to provide a list of AWS/~~Azure~~ platform services and an overview of the responsibilities between CentTech and the SoftBorders account owner. It only covers the most used services within each cloud provider at MegaCorp and covers some of the frequently asked questions when it comes to understanding the shared responsibility between CentTech and the Bussiness Account owner.  It is meant to be a high level overview. For detailed technical information on these topics you'll need to refer to various technical documentation resources provided by CentTech.

# Table of Contents
NOTE: This document only covers AWS services at the moment. An outline has been drawn up for Azure as well and will be completed in time.


1. [AWS Services](#aws-services)
1. [Azure Services](#azure-services)

## AWS Services

### Table of Contents - AWS


1. [EC2](#ec2)
1. [S3](#s3)
1. [VPC](#vpc)
   * NAT Gateway
   * Route Tables
   * NACL
   * Peering
1. [IAM](#iam)
1. [Organizations](#organizations)
1. [CloudTrail](#cloudtrail)
1. [Lambda](#lambda)
1. [CloudWatch](#cloudwatch)
1. [Config](#config)
1. [SSM](#ssm)
1. [DirectConnect](#directconnect)
1. [CloudFormation](#cloudformation)
1. [API Gateway](#api-gateway)
1. [CodeBuild (CodeDeploy/CodeCommit)](#codebuild)
1. [WAF & Shield](#waf)
1. [GuardDuty](#guardduty)
1. [AWS Cost Explorer](#aws-cost-explorer)
1. [Elastic Container Services](#elastic-container-services)
1. EKS
1. Route53
   * Domains
   * Resolver
1. Control Tower
1. RDS
1. Outposts
1. EFS
1. Secrets Manager

### EC2
AWS Elastic Compute Cloud (EC2) is the backbone of AWS and provides access to scalable compute capacity on-demand. In a nutshell this means you can allocate virtual machines, storage, and load balancers on a cost per minute basis to host your applications. EC2 was one of the first services AWS offered and almost all other AWS services that Amazon offers are built on top of it as abstractions (e.g., Lambda, Fargate, EKS, API Gateway, etc.) so that you don't have to build those capabilities from scratch by managing EC2 yourself. With EC2 as the building blocks you can build almost anything you want with cost and management complexity being the only limiting factor. 

CentTech imposes no restrictions at the AWS Organizations or IAM level on the use of EC2 specifically. However, some of the other dependencies of EC2 such as VPC _do_ have some CentTech restrictions. CentTech does offers many _suggestions_ on how you should manage your compute environment as a whole which we'll briefly touch on here. 

AWS Responsibility Matrix

| AWS Service | Category                          | CentTech - SoftBorders                                            | Business - SoftBorders           |
|-------------|-----------------------------------|------------------------------------------------------------------|---------------------------------|
| EC2         | Data Storage (EBS, AMI)           | Monitor sharing of EBS and AMI to non-MegaCorp accounts                | Full control and responsibility |
| EC2         | Usage                             | N/A                                                              | Full control and responsibility |
| EC2         | Savings Plan / Reserved Instances | Negotiate bulk discounts on behalf of all businesses             | Full control and responsibility |
| EC2         | Load Balancing                    | Monitor usage of internet facing load balancers for WAF coverage | Full control and responsibility |
| EC2         | Security Groups                   | N/A                                                              | Full control and responsibility |

CentTech Compute Responsibility Matrix

| Category                               | CentTech - SoftBorders                                                               | CentTech - Managed Nexus                   | Business - SoftBorders                   | Business - Managed Nexus           |
|----------------------------------------|-------------------------------------------------------------------------------------|--------------------------------------------|-----------------------------------------|------------------------------------|
| Enterprise Vulnerability Management    | Provide Qualys Licensing and Reporting                                              | CentTech ensures agent coverage            | Partial control and full responsibility | No responsibility                  |
| Threat Management                      | Provide Crowdstrike Licensing and Reporting                                         | CentTech ensures agent coverage            | Partial control and full responsibility | No responsibility                  |
| Log Reporting                          | Provide Splunk Licensing and Reporting                                              | CentTech ensures agent coverage            | Partial control and full responsibility | No responsibility                  |
| Authentication Connectivity            | Ensure access is available to Active Directory, LDAP/RADIUS from Cloud environments | CentTech fully manages                     | Partial control and responsibility      | No responsibility                  |
| Access Control (Group membership, etc) | No responsibility                                                                   | Partial control and partial responsibility | Full control and responsibility         | Partial Control and responsibility |
| Provisioning / Builds                  | Provide access to secure base operating system (MegaCorpSOS)                              | Partial control and responsibility         | Full control and responsibility         | Partial Control and responsibility |

### S3
S3 is a massively scalable blob storage service provided by Amazon. Objects are stored in buckets and each bucket can have a permissions policy that restricts how the objects can be accessed. It is possible to make S3 buckets public on the internet anonymously or only by certain AWS roles within the account or other accounts. While there are no restrictions against using public anonymous internet buckets they must be used with caution. There is a team within the Cyber organization that monitors NAAPI for public S3 buckets and reaches out to the bucket owner to verify that a public bucket was intended and justified. However, each account owner should also be monitoring their own account for unnecessary use of any public internet facing services in the account to avoid unwanted data exposure. 

Responsibility Matrix

| AWS Service | Category | CentTech - SB Standard                   | CentTech - SB Limited                    | Business - SB Standard                      | Business - SB Limited                       |
|-------------|----------|------------------------------------------|------------------------------------------|---------------------------------------------|---------------------------------------------|
| S3 | Data Storage | Monitor use of public buckets | Monitor use of public buckets | Full control and responsibility | Full control and responsibility |


### VPC
The Virtual Private Cloud AWS service provides virtual networking constructs within an AWS account. Any service within an account that wants to communicate with network packets without going over the internet must interact with the VPC service. A VPC is an allocated CIDR range which can be then carved further into smaller subnets. When the account is provisioned by AWS it comes with default VPCs that are completely isolated from any other networks. In the case of SoftBorders Limited the account is handed over to the customer with only the default VPCs. By default, each subnet within a VPC is routeable to every other subnet within the VPC. It is up to the account owner to manage the functionality and security of the intra-account VPC communications via route tables, network access control lists (NACLs), security groups, and VPC endpoints.

In the case of SoftBorders Standard a VPC is created that has a CIDR range that is unique within the MegaCorp network. The Direct Connect service is enabled in the account and tied to a Virtual Gateway (VGW) which can be added to route tables within the VPC to enable connectivity back to the MegaCorp network. At the other end of the Direct Connect the connection is terminated in the MegaCorp CloudHub where there is a mixing router. Traffic destined for the on-prem MegaCorp network or cloud accounts owned by other MegaCorp businesses must pass through a firewall context. By default a few destinations and ports are already opened at this firewall. Traffic destined fo other cloud accounts within the same business does not go through this firewall context and is only controlled by NACLs/SGs/routes within both accounts. 

Internet access to and from the account can easily be configured through the use of many AWS native services and there are several ways to achieve this. Each SoftBorders Standard account is delivered with a mechanism that provides secure egress to the internet via an EC2 instance named ISS-SB-NAT which provides traffic logging and the ability to operate in allowlist or denylist mode to filter access to specific domains. It is possible to bypass the NAT when necessary for specific workloads or to work around technical issues that the NAT can introduce but it should be cleared with the security team of the owning business.

Native egress can be achieved using a few different methods--namely public IP's and NAT Gateway. An AWS NAT Gateway can be created in the account and added as a target within route tables. This allows VPC aware objects with only private IP's to egress to the internet in a relatively safe manner but with no logging or filtering. Another method for egress is using public IP addresses in combination with an Internet Gateway (IGW). Each account has an IGW by default but can only be used when it's the destination within a route table. IGW's are useless for any network interface without a public IP address. In order for a network interface to use the IGW to egress/ingress to/from the internet it needs to also have a public IP address which can either be assigned by AWS or can be allocated to specific network interfaces through the ElasticIP AWS service. While public IP's and IGWs provide a hassle-free method for internet access they are strongly discouraged as it introduces a significant risk without proper controls. None of the aforementioned internet access methods are explicitly blocked by CentTech in SoftBorders accounts but they should be used with caution and only after appropriate sign-off from the security teams within the business. 

VPCs can be used to isolate network traffic within an AWS account or provide a way of increasing the number of available IP addresses within an account. By default, CentTech will only provision a single connected VPC within an account. The account owner is free to create additional VPCs but they will not have any connectivity back to the MegaCorp network. However, AWS offers a service called VPC Peering that enables connectivity between VPCs. This can be used to allow network interfaces in one VPC to route to the interfaces in another VPC. Unfortunately AWS offers no transitive routing capability via Peering which means that a disconnected VPC peered with a connected VPC cannot easily reach the MegaCorp network without building and configuring your own EC2 based routing solution (e.g., Cisco Cloud Service Router [CSR]). There are routing solutions availble from AWS in the form of Transit Gateway (TGW) which we'll cover in another section. VPC's can be peered together even if they are not in the same AWS account which means it's possible to peer to an account that isn't owned by MegaCorp. Therefore, VPC Peering is blocked by CentTech via Organizations Service Control Policies (SCPs) and can only be accomplished via an engagement process with the SoftBorders team. 

Responsibility Matrix

| AWS Service | Category               | CentTech - SB Standard                                                                                                      | CentTech - SB Limited | Business - SB Standard                  | Business - SB Limited           |
|-------------|------------------------|-----------------------------------------------------------------------------------------------------------------------------|-----------------------|-----------------------------------------|---------------------------------|
| VPC         | Intra-VPC Connectivity | Provision the VPC                                                                                                           | N/A                   | Full control and responsibility         | Full control and responsibility |
| VPC         | Inter-VPC Connectivity | Restrict peering, CloudHub firewalls                                                                                        | N/A                   | Limited control, Partial responsibility | Full control and responsibility |
| VPC         | Reachback to MegaCorp        | CloudHub firewalls, DirectConnect availability                                                                              | N/A                   | Limited control, partial responsibility | N/A                             |
| Route Table | Internet Egress        | Provision the initial route tables to support egress, Provision/maintain the egress filter/logging service, monitor changes | N/A                   | Full control and partial responsibility | Full control and responsibility |
| Route Table | Intra-VPC Routing      | Provision the initial route table to support internal routing                                                               | N/A                   | Full control and responsibility         | Full control and responsibility |
| Route Table | Reachback              | Provision the initial route table to support reachback routing, monitor changes                                             | N/A                   | Full control and responsibility         | Full control and responsibility |
| NAT Gateway | Internet Egress        | N/A                                                                                                                         | N/A                   | Full control and responsibility         | Full control and responsibility |
| NACL        | Internet Egress        | Provision the initial NACLs                                                                                                 | N/A                   | Full control and responsibility         | Full control and responsibility |
| NACL        | Intra-VPC Filtering    | Provision the initial NACLs                                                                                                 | N/A                   | Full control and responsibility         | Full control and responsibility |

### IAM
AWS Identity and Access Management (IAM) is what controls authentication and access controls to all service calls within AWS. Everything you do in the AWS cloud is sent through an IAM filter before the action is allowed to proceed. IAM is so flexible and powerful that it can be somewhat terrifying to manage at scale. IAM is founded on the concept of principals (e.g., users, groups, roles, services) and policies (a.k.a, permissions). IAM controls access to the principal and then ensures that when a service call is made that the policies assigned to the principal allow that action.

IAM Principals are users, groups, roles, and services. IAM can authenticate access to each of these using many different methods such as Console login with password and MFA, permanent plaintext access keys, trusting another provider via SAML assertions, and pre-assigning authentication to services such as EC2 instances and Lambda functions. Generally authentication is temporary and must be refreshed periodically. The details of how all of this works is outside the scope of this document but many resources can be found in AWS's documentation and the MegaCorp specific implementations can be found in the technical documentation this site. Once a principal has been authenticated the authorization component is handled by the IAM policies.

Policies are JSON formatted documents that describe the permissions that an IAM principal has or doesn't have. By default, principals have no permissions at all and all services are _implicitly_ denied. Permissions must be _explicitly_ added. Services can be _explicitly_ denied as well. Allows trump the default _implicit_ deny but _explicit_ denies always take precendent over _any_ allows. For example, you can write a policy that lets a user perform any action within the `vpc` family of services _except_ call the `CreateVpc` action and only allow them to reboot a specific EC2 instance. 

Policies are made up of blocks of structured JSON statements that have the following fundamental properties:
* the `Action` that is being allowed or denied
   * such as an entire suite of service calls like `ec2:*` or just one service call like `ec2:CreateVpc`
* what the `Effect` of this block is
   * such as `Allow` or `Deny`
* the `Resource` scope of this block as a list of ARNs
   * this can refer to things like specific, unique objects such as an instance with a particular ID, all instances in a particular region, or just simply all resources
* the `Condition` that needs to be in place for this block to take effect. 
   * this can be conditions such as whether the call is coming from a particular IP address, the object in question has certain tags, or even the time of day. 

In fact, the `iam` service itself is indeed controlled by IAM policies! Therfore, it's easy to get into chicken and egg problems when crafting complex policies. 

IAM is the hardest thing for most new AWS users to understand but by mastering these building blocks it is possible to create access control schemas that meet the needs of even the most discerning security controls while still allowing the business to operate freely. People who understand IAM are worth their weight in gold in the AWS world. If you're thinking about moving workloads to cloud you will need to have an IAM manager on staff.

_How CentTech Is Involved in IAM_

The SoftBorders product attempts to provide the owning customer account with as much IAM freedom as is possible while still protecting the company as a whole. The SoftBorders team needs to maintain some level of access to the cloud accounts so that it may provide operational support, oversight, and security incident response services to the account. To accomplish that the team has delivered every account at MegaCorp with certain IAM principals and policies to support these efforts. In order to make sure these principals are always available and access cannot be removed certain IAM controls have been implemented at the Organizations level. This ensures that customers or attackers cannot intentionally or inadvertently remove such access. In a nutshell--all SoftBorders principals and policies are configured under the IAM path of `/cs/` and there are deny policies that prevent any thing from creating, modifying, or deleting principals and policies under this path. 

In addition to the `/cs/` principals that the entire SoftBorders team has access to there are two highly priviledged principals that only a handful of persons at MegaCorp can access--the `super-admin-to-gecc` role and the `root` user for each account. CentTech obviously blocks access to these principals as well.  

CentTech also blocks the ability for customers to add additional identity providers (IdP) that could allow unwanted federated authentication control. CentTech provides a corporate level IdP with every SoftBorders account so that only the MegaCorp identity system is trusted as a federated IdP. Additional IdP's can be added to the account but must be done through a ticket to the SoftBorders team with justification provided. 

While the above SoftBorders controls are specifically for actions related to `iam` it's necessary to note that AWS Organizations Service Control Policies (SCPs) are really just IAM policies themselves and can not only control access to actions and resources under the `iam` service but also many other services such as `ec2` and `cloudtrail`. How SCP controls those other non-IAM services will be covered in their respective sections of this guide. 

Responsibility Matrix

| AWS Service | Category       | CentTech - SoftBorders              | Business - SoftBorders              |
|-------------|----------------|------------------------------------|------------------------------------|
| IAM         | Authentication - SoftBorders roles | Full control and responsibility | No responsibility |
| IAM         | Access Control - SoftBorders roles | Full control and responsibility | No responsibility |
| IAM         | Authentication - Customer roles | Partial control and responsibility | Full control and responsibility |
| IAM         | Access Control - Customer roles | No responsibility | Full control and responsibility |

### Organizations
The AWS Organizations service allows an AWS account to set an Organizations "master" account to delegate control to for various purposes. One of the primary purposes is to allow a single AWS account to set policies and provision certain types of resources accross all child accounts. Another feature of Organizations is the ability to create new AWS accounts that are automatically a part of the parent Organization. 

CentTech reserves all rights to AWS Organizations and provides no control or access to Organizations for the customer accounts. CentTech imposes AWS Organizations Service Control Policies (SCPs) on all child accounts depending on which Organizational Unit the child account resides in. Controls vary by OU based on the specific needs of various SoftBorders sub-products and Business Unit requirements. If a customer desires to implement custom controls at the Organizations level this can be done via engagements with the SoftBorders team. Since CentTech provides no access to the Organizations master account for customers a read-only service has been provided that allows members of the bu-iam-admin DL for the account to view the current SCP's applied to their accounts for the purposes of troubleshooting and compliance design. 

The SoftBorders team also uses the account creation functionality of AWS Organizations in order to provision new SoftBorders accounts. This conflicts with some services such as Control Tower which will be covered in another section of this document.

Responsibility Matrix

| AWS Service   | Category | CentTech - SoftBorders           | Business - SoftBorders                            |
|---------------|----------|---------------------------------|--------------------------------------------------|
| Organizations | --       | Full control and responsibility | No control or responsibility, partial visibility |

### CloudTrail
CloudTrail is an AWS service that monitors actions taken in an AWS account such as API calls to create users, instances, etc. It logs who made the changes and some details about what was requested in the API call. By default it stores 90 days worth of data within the account. CentTech puts a CloudTrail recorder into every account provisioned at MegaCorp and ships the logs to the CIRT team where they can monitor activity with Splunk. This initial trail that's installed is non-negotiable and is protected from deletion via Organizations SCP policies. Customers are free to create more trails for their own purposes (incurs additional AWS bill costs) but they cannot modify the initial trail.

Responsibility Matrix

| AWS Service | Category | CentTech - SB Standard                   | CentTech - SB Limited                    | Business - SB Standard                      | Business - SB Limited                       |
|-------------|----------|------------------------------------------|------------------------------------------|---------------------------------------------|---------------------------------------------|
| CloudTrail  | Audit    | Full control of initial CloudTrail trail | Full control of initial CloudTrail trail | Can view existing trail or create their own | Can view existing trail or create their own |

### Lambda
Lamda is an AWS service that allows you to rent time on AWS infrastructure to run the code that you upload to the service. Time spent running your code is billed to you by the millisecond. Lambdas can be run in the "standard" mode where it runs outside of your VPC with public access to internet or they can be assigned to run in your VPC and therefore be able to interact with your private network or even the MegaCorp network. CenTech imposes no restrictions on Lambda but does ask that users be responsible with VPC based Lambdas as they do have a network presence. Any code that would be considered malicious or irresponsible running on an EC2 instance would also be considered as such running as a Lambda. 

Responsibility Matrix

| AWS Service | Category | CentTech - SB Standard                   | CentTech - SB Limited                    | Business - SB Standard                      | Business - SB Limited                       |
|-------------|----------|------------------------------------------|------------------------------------------|---------------------------------------------|---------------------------------------------|
| Lambda | N/A | N/A | N/A | Full control and responsibility | Full control and responsibility |

### CloudWatch
CloudWatch is an AWS service that lets you monitor resources and applications. Its primary functions include hosting and tooling around time series data, text based log aggregation and searching, events similar to cron jobs, and other various monitoring solutions for things like containers and "services". CentTech imposes no restrictions on CloudWatch but does use some of its features in your account in conjunction with the EC2 based NAT instance for egress filtering. Creating things such as VPC endpoints for CloudWatch metrics can interrupt the metrics that CentTech sends from the ISS-SB-NAT instance and can cause a loss of central monitoring capability for the CloudPod team. However, this is not a requirement for functional egress filtering in your account.  Also, CentTech may utilize CloudWatch logs if you wish to see visibility into the log files from the ISS-SB-NAT instance. 

Responsibility Matrix

| AWS Service | Category | CentTech - SB Standard                   | CentTech - SB Limited                    | Business - SB Standard                      | Business - SB Limited                       |
|-------------|----------|------------------------------------------|------------------------------------------|---------------------------------------------|---------------------------------------------|
| CloudWatch | N/A | N/A | N/A | Full control and responsibility | Full control and responsibility |

### Config
AWS Config is a service that tracks inventory and configuration changes for all of the components of an AWS account. It has two major components: snapshots and rules. Snapshots are a snapshot of the inventory of objects in the account that Config supports (e.g., EC2 instances, subnets, IAM users, etc). If you wish you can set up Config Rules to track changes to these objects and when certain changes are detected certain events can be triggered (e.g., lambda to send an email). CentTech deploys a Config snapshot recorder in every account at MegaCorp so that it can collect inventory from every account and feed it into the NAAPI inventory system. Many teams at MegaCorp use NAAPI to track all of their cloud based inventory spanning many accounts, business units, sub-business units, etc. It is your right as an account owner to have access to the NAAPI inventory for your account. Depending on your job scope you may also be entitled to see NAAPI inventory for all of the accounts that your business owns.

Since AWS currently only supports one Config Recorder per account per region it is not possible for you as the account owner to create or modify the Config Recorder that exists in your account. CentTech has automation that assumes a role into your account at least once every 30 minutes to create a snapshot which is then sent to a central S3 bucket in an account owned by CentTech. Therefore, if you wish to have a copy of this snapshot delivered to you for some reason then you should reach out to the SoftBorders team with an engagement request. 

Config Rules, however, are not controlled by CentTech and you are free to define your own rules. Config Rules do not require you to create a new Recorder or have a different snapshot sent to another location within your account.


Responsibility Matrix

| AWS Service | Category | CentTech - SB Standard                   | CentTech - SB Limited                    | Business - SB Standard                      | Business - SB Limited                       |
|-------------|----------|------------------------------------------|------------------------------------------|---------------------------------------------|---------------------------------------------|
| Config | Snapshot | Full control and responsibility | Full control and responsibility | No control or responsibility | No control or responsibility |
| Config | Rules | N/A | N/A | Full control and responsibility | Full control and responsibility |


### SSM
AWS Systems Manager (SSM) is a service that enables you to set up automation scripts that can be run against your EC2 infrastucture or even against on-prem servers that have the agent installed. It works on the concept of an SSM Inventory to which SSM Documents (i.e., scripts) can be run against that inventory on an ad-hoc basis or triggered by other event such as Lambdas or CloudWatch events. The service in has a feature called Session Manager which lets you get browser based command line access to your EC2 instances without requiring any inbound connectivity to the VM either from the internet or your on-prem network! SSM works by having each SSM agent on each server poll the SSM service for jobs in queue. The service only requires that the subnet the EC2 instance lives in have either internet access or access to the SSM service via VPC endpoint.

Each agent must have authentication credentials so it knows which AWS account to authenticate with. The most common method of providing an instance with credentials is to use an IAM instance-profile but you can also configure access key based authentication. If the agent is installed, the instance has an instance profile that gives it SSM permissions, and the instance can reach the internet then you can probably get an active CLI session on the instance with root access. This is obviously slightly concerning from a security perspective but there are many ways to restrict access to the service using IAM policies and network controls. 

NOTE: Currently CentTech places no restrictions on the use of SSM but there have been requests from the Cyber organization in the past to use Organizations SCP to restrict acccess to the service unless you're coming from known-MegaCorp public IP addresses so that users are unable to get root on servers without at least being on the MegaCorp network.

Responsibility Matrix

| AWS Service | Category | CentTech - SB Standard                   | CentTech - SB Limited                    | Business - SB Standard                      | Business - SB Limited                       |
|-------------|----------|------------------------------------------|------------------------------------------|---------------------------------------------|---------------------------------------------|
| CloudTrail  | Audit    | Full control of initial CloudTrail trail | Full control of initial CloudTrail trail | Can view existing trail or create their own | Can view existing trail or create their own |

### Lambda
Lamda is an AWS service that allows you to rent time on AWS infrastructure to run the code that you upload to the service. Time spent running your code is billed to you by the millisecond. Lambdas can be run in the "standard" mode where it runs outside of your VPC with public access to internet or they can be assigned to run in your VPC and therefore be able to interact with your private network or even the MegaCorp network. CenTech imposes no restrictions on Lambda but does ask that users be responsible with VPC based Lambdas as they do have a network presence. Any code that would be considered malicious or irresponsible running on an EC2 instance would also be considered as such running as a Lambda. 

Responsibility Matrix

| AWS Service | Category | CentTech - SB Standard                   | CentTech - SB Limited                    | Business - SB Standard                      | Business - SB Limited                       |
|-------------|----------|------------------------------------------|------------------------------------------|---------------------------------------------|---------------------------------------------|
| Lambda | N/A | N/A | N/A | Full control and responsibility | Full control and responsibility |

### CloudWatch
CloudWatch is an AWS service that lets you monitor resources and applications. Its primary functions include hosting and tooling around time series data, text based log aggregation and searching, events similar to cron jobs, and other various monitoring solutions for things like containers and "services". CentTech imposes no restrictions on CloudWatch but does use some of its features in your account in conjunction with the EC2 based NAT instance for egress filtering. Creating things such as VPC endpoints for CloudWatch metrics can interrupt the metrics that CentTech sends from the ISS-SB-NAT instance and can cause a loss of central monitoring capability for the CloudPod team. However, this is not a requirement for functional egress filtering in your account.  Also, CentTech may utilize CloudWatch logs if you wish to see visibility into the log files from the ISS-SB-NAT instance. 

Responsibility Matrix

| AWS Service | Category | CentTech - SB Standard                   | CentTech - SB Limited                    | Business - SB Standard                      | Business - SB Limited                       |
|-------------|----------|------------------------------------------|------------------------------------------|---------------------------------------------|---------------------------------------------|
| CloudWatch | N/A | N/A | N/A | Full control and responsibility | Full control and responsibility |

### Config
AWS Config is a service that tracks inventory and configuration changes for all of the components of an AWS account. It has two major components: snapshots and rules. Snapshots are a snapshot of the inventory of objects in the account that Config supports (e.g., EC2 instances, subnets, IAM users, etc). If you wish you can set up Config Rules to track changes to these objects and when certain changes are detected certain events can be triggered (e.g., lambda to send an email). CentTech deploys a Config snapshot recorder in every account at MegaCorp so that it can collect inventory from every account and feed it into the NAAPI inventory system. Many teams at MegaCorp use NAAPI to track all of their cloud based inventory spanning many accounts, business units, sub-business units, etc. It is your right as an account owner to have access to the NAAPI inventory for your account. Depending on your job scope you may also be entitled to see NAAPI inventory for all of the accounts that your business owns.

Since AWS currently only supports one Config Recorder per account per region it is not possible for you as the account owner to create or modify the Config Recorder that exists in your account. CentTech has automation that assumes a role into your account at least once every 30 minutes to create a snapshot which is then sent to a central S3 bucket in an account owned by CentTech. Therefore, if you wish to have a copy of this snapshot delivered to you for some reason then you should reach out to the SoftBorders team with an engagement request. 

Config Rules, however, are not controlled by CentTech and you are free to define your own rules. Config Rules do not require you to create a new Recorder or have a different snapshot sent to another location within your account.


Responsibility Matrix

| AWS Service | Category | CentTech - SB Standard                   | CentTech - SB Limited                    | Business - SB Standard                      | Business - SB Limited                       |
|-------------|----------|------------------------------------------|------------------------------------------|---------------------------------------------|---------------------------------------------|
| Config | Snapshot | Full control and responsibility | Full control and responsibility | No control or responsibility | No control or responsibility |
| Config | Rules | N/A | N/A | Full control and responsibility | Full control and responsibility |


### SSM
AWS Systems Manager (SSM) is a service that enables you to set up automation scripts that can be run against your EC2 infrastucture or even against on-prem servers that have the agent installed. It works on the concept of an SSM Inventory to which SSM Documents (i.e., scripts) can be run against that inventory on an ad-hoc basis or triggered by other event such as Lambdas or CloudWatch events. The service in has a feature called Session Manager which lets you get browser based command line access to your EC2 instances without requiring any inbound connectivity to the VM either from the internet or your on-prem network! SSM works by having each SSM agent on each server poll the SSM service for jobs in queue. The service only requires that the subnet the EC2 instance lives in have either internet access or access to the SSM service via VPC endpoint.

Each agent must have authentication credentials so it knows which AWS account to authenticate with. The most common method of providing an instance with credentials is to use an IAM instance-profile but you can also configure access key based authentication. If the agent is installed, the instance has an instance profile that gives it SSM permissions, and the instance can reach the internet then you can probably get an active CLI session on the instance with root access. This is obviously slightly concerning from a security perspective but there are many ways to restrict access to the service using IAM policies and network controls. 

NOTE: Currently CentTech places no restrictions on the use of SSM but there have been requests from the Cyber organization in the past to use Organizations SCP to restrict acccess to the service unless you're coming from known-MegaCorp public IP addresses so that users are unable to get root on servers without at least being on the MegaCorp network.
12:31

Responsibility Matrix

| AWS Service | Category | CentTech - SB Standard                   | CentTech - SB Limited                    | Business - SB Standard                      | Business - SB Limited                       |
|-------------|----------|------------------------------------------|------------------------------------------|---------------------------------------------|---------------------------------------------|
| SSM | -- | N/A | N/A | Full control and responsibility | Full control and responsibility |

### DirectConnect
AWS DirectConnect is a service that provides network connectivity between your enterprise network and the AWS network so that you can securely access workloads running inside your VPC. CentTech configures and maintains the DirectConnect connection on your behalf and provides shares a portion of the connection to your VPC so that you can access uniquely routable address space within your VPC to and from the MegaCorp network. The DirectConnect service is built out in the AWS master payer account `gecc` (737859062117) and from that account a virtual interface is shared to your account. You can see evidence of this connection if you go to DirectConnect > Virtual Interfaces. From there you can also see how the Virtual Interface is associated with a Virtual Gateway (VGW) within your account. 

MegaCorp maintains physical connectivity to the AWS network in four regions: us-east-1 (Ashburn), eu-central-1 (Frankfurt), ap-southeast-1 (Singapore), and eu-west-1 (Deprecated). Soon there should be additional connectivity in San Jose, California. Although the DirectConnect console is "Global"--your connection will show up under one of the aforementioned regions. This doesn't mean you have to have your VPC's resources live in one of those regions--you can choose any region you wish to have your VPC set up in however, for a region that isn't directly connected your traffic will traverse the AWS backbone over the DXGateway service to get to wherever you have your VPC.  

All charges for DirectConnect are assumed by CentTech and the overall cost is spread out over all AWS accounts at MegaCorp as a small portion of the SoftBorders upcharge. SoftBorders account owners have almost no control over the DirectConnect service and all questions related to MegaCorp network connectivity must go through the SoftBorders team in the form of engagement requests. 
 
Responsibility Matrix

| AWS Service | Category | CentTech - SB Standard                   | CentTech - SB Limited                    | Business - SB Standard                      | Business - SB Limited                       |
|-------------|----------|------------------------------------------|------------------------------------------|---------------------------------------------|---------------------------------------------|
| DirectConnect | -- | N/A | N/A | Full control and responsibility | Full control and responsibility | N/A | N/A |

### Cloudformation
AWS Cloudformation is a service that takes AWS infrastructure templates in text format and builds that infrastructure in the correct order on the AWS platform. From there it keeps a tag on the resources it creates so that it knows that all of that infrastructre is part of the same Cloudformation stack. It can accept parameters so you can customize various aspects of your infrastructure. It's a great way to not only deploy infrastructure in a standard fashion but also a great way to update infrastructre as you can merely update the template and Cloudformation will determine which components need to be updated. Underneath the hood all it's doing is determining the order of operations by which various other AWS service calls need to be executed.

CenTech does not interfere with any aspects of Cloudformation itself but some of the objects that are requested via Cloudformation may be under certain SoftBorders controls (e.g., a template that requests a new Route53 Domain name will be blocked by company policy--see Route53 section of this document for more info)

Responsibility Matrix

| AWS Service | Category | CentTech - SB Standard                   | CentTech - SB Limited                    | Business - SB Standard                      | Business - SB Limited                       |
|-------------|----------|------------------------------------------|------------------------------------------|---------------------------------------------|---------------------------------------------|
| Cloudformation | -- | N/A | N/A | Full control and responsibility | Full control and responsibility | N/A | N/A |

### API Gateway
The API Gateway service offered by AWS is a means of building a RESTful API in front of other AWS components. For example, if you have a lambda function that retrieves a requested record from a DynamoDB table you can configure API Gateway to call that lambda when someone hits the API Gateway's endpoint URL plus some path you configure For example, you could configure API Gateway in such a way that your clients could call `curl -XMegaCorpT https://mysite.apps.ge.com/records?id=12` and it will pass the input parameter `id=12` to the `GetRecords` lambda function. You can also configure it to do things like requiring an API key and limit the number of requests per API key. By default all API gateways are accessible from the internet but there are ways to make them so that they are only accessible via the VPC. 

CenTech places no limitations on API Gateway but asks that you be careful in securing them due to their "internet accessible by default" nature. 

Responsibility Matrix

| AWS Service | Category | CentTech - SB Standard                   | CentTech - SB Limited                    | Business - SB Standard                      | Business - SB Limited                       |
|-------------|----------|------------------------------------------|------------------------------------------|---------------------------------------------|---------------------------------------------|
| API Gateway | -- | N/A | N/A | Full control and responsibility | Full control and responsibility | N/A | N/A |

### Codebuild
( and CodeCommit/CodeDeploy)
AWS Codebuild is a service that provides a code build pipeline language and infrastructure automation tools for building code from "source". This is an alternative to tools such as CircleCI, Jenkins, Octopus, and TravisCI. You define builds as YAML files which are an instruction set to do things like "spin up a build container", "check out dev branch of code", "run the go build command", "upload artifacts to S3", etc.

Codebuild can pull source code from many sources such as github.com or the AWS CodeCommit service. CodeCommit provides a git repo in your AWS account that is controlled via AWS IAM principles. However, it is not recommended by CenTech to store proprietary source code outside of unregulated source repos such as MegaCorp Github so this may limit how much you can use the full AWS Code\* stack at MegaCorp depending on the security controls within your business. 

CodeDeploy can take the artifacts of a Codebuild job and use the AWS CodeDeploy agent on an EC2 instance to pull down the files and run scripts in a specific order. It can handle things for you like taking the instances out of service behind a load balancer, etc. 

CenTech places no limitations on and of the Code\* services mentioned above but does caution against using CodeCommit as a primary source repository for your code. 

Responsibility Matrix

| AWS Service | Category | CentTech - SB Standard                   | CentTech - SB Limited                    | Business - SB Standard                      | Business - SB Limited                       |
|-------------|----------|------------------------------------------|------------------------------------------|---------------------------------------------|---------------------------------------------|
| API Gateway | -- | N/A | N/A | Full control and responsibility | Full control and responsibility |

### WAF
(and Shield)

The AWS Web Application Firewall (WAF) service is a security feature that can be applied to AWS internet facing services such as Application Load Balancers (ALBs), CloudFront distributions, and API Gateways. When an asset is protected by WAF you can apply Web ACLs that contain Rule Groups that protect web endpoints against things such as SQL injection, `/admin` pages, and IP addresses known to AWS to be malicious. You can select Rule Groups from a "catalog" of sorts or you can write your own from scratch. Once these Rule Groups are associated with a Web ACL the Web ACL can be applied to your internet facing services. 

AWS Shield is a service provided by AWS that protects against Distributed Denial of Service (DDoS) attacks. Basic Shield is free and is always on by default in your account. Shield Advanced lets you add additional protection to your internet facing services and adds a flat $3k/month to your AWS bill. 

*How CenTech Assists with WAF & Shield*

CentTech does two things with WAF & Shield to help out the account owners at MegaCorp. First of all, it provides a shared Web ACL via the AWS Firewall Manager service from a central account that will automatically apply a baseline WebACL to any object with a certain tag. You can choose to use this base Web ACL or you can simply build your own--it's up to you. Secondly, any account provisioned by MegaCorp that enables AWS Shield Advanced will have that $3k/month charge removed from their bill as it's included in our master agreement with Amazon so don't be afraid to click the "enable shield advanced" button. 

Responsibility Matrix

| AWS Service | Category | CentTech - SB Standard                   | CentTech - SB Limited                    | Business - SB Standard                      | Business - SB Limited                       |
|-------------|----------|------------------------------------------|------------------------------------------|---------------------------------------------|---------------------------------------------|
| WAF | Rule Groups | Partial control and responsibility | Partial control and responsibility | Full control and responsibility | Full control and responsibility |
| WAF | Web ACL | Partial control and responsibility | Partial control and responsibility | Full control and responsibility | Full control and responsibility |
| WAF | Assigning Web ACLs to Endpoints | N/A | N/A | Full control and responsibility | Full control and responsibility |
| Shield | Advanced | Partial control and responsibility | Partial control and responsibility | Full control and responsibility | Full control and responsibility |
| Shield | Assigning Shield to Endpoints | N/A | N/A | Full control and responsibility | Full control and responsibility |


### Guardduty
AWS GuardDuty is a service that monitors an AWS account for suspicious activity such as DNS requests to known bitcoin mining sites, SSH password brute force attempts, etc.  and creates alerts in a queue known as "findings" so that security teams can monitor a single location to know when there is an incident that needs to be responded to. GuardDuty can be configured to trust and send all of it's findings from your accounts to a GuardDuty master account so that all events show up in one place.

CentTech has already configured every account at MegaCorp to send all findings to a single master account `digital-vesg-secops (264560008398)` that is managed by the Cloud CIRT (cirt.cloud@ge.com). However, you can see a list of the current findings for just your account by going to the GuardDuty console and viewing the findings. CentTech does not offer shared access to the GuardDuty master account and AWS does not support multi-master for GuardDuty at this time. 


Responsibility Matrix

| AWS Service | Category | CentTech - SB Standard                   | CentTech - SB Limited                    | Business - SB Standard                      | Business - SB Limited                       |
|-------------|----------|------------------------------------------|------------------------------------------|---------------------------------------------|---------------------------------------------|
| GuardDuty | -- | Full control and responsibility | Full control and responsibility | Read Only | Read Only |

### AWS Cost Explorer
AWS Cost Explorer provides a toolset that lets you analyze the spend in your AWS account. It provides visual tools and reporting to help you answer questions like "What's my most expensive service?" and to monitor any spikes in upcoming costs so you can proactively manage spend before you get your monthly invoice. However, due to MegaCorp's billing structure and corporate AWS discount these tools must be used with caution as the dollar amounts that they report are likely incorrect. For example, if you have a SoftBorders Standard account and you see that the Cost Explorer tells you that you're on track to spend $10k this month on EC2 you would have to then do some math to determine what you're actually going to see on your bill.

For a SB Standard account you're probably paying 15% on top of MegaCorp's negotiated discount. Therefore, the numbers you see in Cost Explorer will be 17% higher that what you'll see on your actual bill from CentTech. This doesn't mean that the tools Cost Explorer provides have no value--on the contrary it's extremely useful to see trends and ratios of spend even if the dollar amounts are incorrect. 

In order for Cost Explorer to be used the account must have billing tools enabled. This is enabled in _most_ accounts but there are some exceptions for legacy accounts or accounts where it was turned off for some reason or another. If your account can't access billing tools even when your IAM principal has the permissions then you need to cut a ticket to the SoftBorders Ops team to get it fixed. 


Responsibility Matrix

| AWS Service | Category | CentTech - SB Standard                   | CentTech - SB Limited                    | Business - SB Standard                      | Business - SB Limited                       |
|-------------|----------|------------------------------------------|------------------------------------------|---------------------------------------------|---------------------------------------------|
| Cost Explorer | Enablement | Full control and responsibility | Full control and responsibility | Partial control and responsibility | Partial control and responsibility |
| Cost Explorer | Usage | N/A | N/A | Full control and responsibility | Full control and responsibility |

### Elastic Container Services
(ECS/ECR etc.)
The Elastic Container Services (ECS) offered by AWS provide many different ways to run Docker containers at scale to host batch jobs and services. It lets you orchestrate the running of these containers with tight integration to other AWS services such as load balancers and IAM. You can host your container images in the Elastic Container Registry (ECR) so that you can pull them 


### EKS
(TBD)

## Azure Services
(TBD)


1. Virtual Machines
1. Subscriptions
1. Policy
1. Management Groups
1. Virtual Networks (VNET)
1. ExpressRoute
1. Azure Active Directory
   * Managed identities
   * Azure AD Domain Services
1. Microsoft Defender for Cloud (formerly known as 'Azure Security Center')
1. Log Analytics workspaces
1. Application Gateways
1. Azure Firewall
1. Public IP addresses
1. Storage Accounts
1. Kubernetes (AKS)
1. SQL Managed Instances
1. Functions
1. Key Vaults
1. DevOps
1. Activity Log
1. Images
