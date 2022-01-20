---
title: "ITSM and Cloud"
date: 2020-02-11
---

This document covers the basics of an IT service management (ITSM) solution for the purposes of incident management, change control, and inventory management. The objective is to prove that such a system is critical to a business and equally important for environments that traditionally shun these systems such as smaller organizations and organizations with cloud workloads. 


* [Introduction](#introduction)
* [Change Control Concepts](#change-control-concepts)
  * [Why Change Control is Necessary](#why-change-control-is-necessary)
  * [How to Implement a Basic Change Control System](#how-to-implement-a-basic-change-control-system)
* [Incident Management Concepts](#incident-management-concepts)
  * [Why Incident Management is Necessary](#why-incident-management-is-necessary)
  * [How to Implement a Basic Incident Management System](#how-to-implement-a-basic-incident-management-system)
* [Inventory - A Critical Requirement for Effective Change and Incident Management](#inventory---a-critical-requirement-for-effective-change-and-incident-management)
  * [Implementing a Basic Inventory System](#implementing-a-basic-inventory-system)
  * [Physical Inventory](#physical-inventory)
  * [Virtual and Cloud Inventory](#virtual-and-cloud-inventory)
  * [Asset Inventory For Cloud](#asset-inventory-for-cloud)
    * [Asset Inventory - Cloud Systems](#asset-inventory---cloud-systems)
      * [Tag Challenges](#tag-challenges)
      * [Regarding Modern Automated Systems Management](#regarding-modern-automated-systems-management)
        * [Infrastructre as Code Challenges](#infrastructre-as-code-challenges)
        * [CI/CD Challenges](#ci/cd-challenges)
        * [Conclusion](#conclusion)
  * [Asset Inventory - Logical Business Constructs](#asset-inventory---logical-business-constructs)
* [Conclusion](#conclusion)
* [References](#references)
  * [Other References](#other-references)

## Introduction
Any system of sufficient complexity requires humans to compartmentalize. When we can't afford a house due to the trillions of human interactions that shaped the economy at this very moment we don't list off the names of billions of people--instead we compartmentalize and blame the "stock market" and we wonder what "congress" is going to do about it. Humans operating in a business are no different.

All businesses operate to make money or achieve other collective goals through the organized efforts of many disparate systems and teams. When business get sufficiently complex they need a way of tracking the interaction between systems and teams to ensure they are all working in harmony. IT systems merely exist to optimize the efforts of the business systems. Therefore, there are probably at least one logical IT system construct for every logical business construct. Often times they blend together into monstrous logical systems like "Payroll" which could be hundreds of humans using dozens of IT systems working towards a common goal. When a business hears that a downstream dependency of "Payroll" (such as "the network") was broken and affected "Payroll" you can imagine the finger pointing involved in the post-mortem review and the dozens of "how can we make sure this doesn't happen again" meetings. Generally these conversations lead towards having the ability to track the changes and incidents to IT systems at a macro scale. 

There will also be macro level proactive audit inquiries to aid in business strategy discussions. For example, consider the following questions:
* How many applications do we have with personal identifiable information (PII)?
* How many applications do I have that are missing ownership information? How many owners are no longer working at the company?
* If I were to retire a certain system or authorize any other sort of change how many downstream systems would be impacted?
* Do I have systems that support HIPAA workloads? If so, can I tell if they share data or dependencies with any non-HIPAA compliant applications?
* What was happening to the system that caused us not to be able to close the books on time this month?

These and many more "macro" level questions are critical questions for any business to be able to answer in order to successfully manage their business. Without some sort of system of record that tracks these system and application attributes the answers to these questions require hundreds of analysts to fan out and interview thousands of application and system owners. Even if they were to go on a single campaign to answer one of these questions they would want to store the findings somewhere so that the next question wouldn't be so painful and by the time they got to the next question the information would almost surely be out of date. For these and dozens of other reasons it is critical for a business to track their IT services and applications at this macro level.

One way of keeping a system of record like this is to store your systems and applications as configuration items in an IT service management platform such as BCM or ServiceNow. There can be multiple types of records depending on whether the logical business construct is a service, application, environment, etc. Each type of record can have different property fields for things like business owner, data classification, creation date, retirement date, dependent downstream systems, etc. Keeping this data up to date is crucial for a business to maintain smooth and compliant operations.

However, the systems and application owners themselves are not necessarily going to have any personal motivation to keep this information up to date. This is a function that must be enforced by a central agency much like a state government requires all vehicles to have a registration and license plate. The drivers (application owners) are going to hate the process of getting their tag renewed but unfortunately it must be done. If this system is to be successful then there must be penalties for non-compliance. Like everything in life and business there are tradeoffs between freedom and control. Therefore, each business must decide how important data integrity in these systems will be to them and then determine the severity of the penalty for non-compliance. 

A hard fact for most IT professionals to sometimes swallow is that the business does not exist for the sake of the IT systems. IT professionals are paid to automate and streamline business operations. It is expected that once built, these solutions will be iterated on to provide further optimizations and the solutions will remain stable. Therefore, it should be the duty and the pride of every IT professional to provide functional and stable systems.

An ITSM can be a crucial tool in enabling a business to track compliance and answer the above questions as well as a tool that can enable even the smallest team of IT professionals to maintain stable operations and understand how their responsibilities impact the larger system. For the remainder of this document we will examine the fundamental capabilities that IT teams--both large and small--must have in order to support a business and how an ITSM can help. These fundamental requirements are change control, incident management, and inventory management. 

## Change Control Concepts
This section will cover the basic concepts behind IT Change Control as a general concept. 

### Why Change Control is Necessary
Changes to software and infrastructure are necessary but they break things and usually in unexpected ways that the changer did not intend. It's important to track changes to not only prevent unwanted changes but also to keep a log of changes to inform business managers or when a strange issue occurs and an IT professional wants to investigate a root cause. Rigorous change management is also generally a requirement for many business compliance frameworks such as SOX \[1\], GMP and FDA \[2\].

The spirit of all of these frameworks boils down to some very simple principles. Change control is implemented so that:
* Changes can be reviewed *before* they happen and can be controlled in a reasonable manner
   * Example: year end change freeze so people don't bring down the network on Christmas day
   * Example: preventing changes to critical systems when it's important for another critical process to run smoothly such as quarter end financial close
* Changes can be reviewed *after* they happen to determine when something caused an outage or regulatory failure
   * Example: your application broke without you changing anything so you want to go and see if some system that your application depends on was changed 
   * Example: a security defect was introduced to a system allowing an outside threat to access a system and you need to discover when and why that change was made

Let's look at some options for how we establish a change control system.

### How to Implement a Basic Change Control System
In it's very basic form a change control system _could_ be as simple as a spreadsheet that outlines the following:

| Change Start Date | Change End Date | Change Description                                        | Affects (systems)                | Approver(s)                         |
|-------------------|-----------------|-----------------------------------------------------------|----------------------------------|-------------------------------------|
| 2021-01-10        | 2021-01-11      | Reboot the network switch to install latest firmware      | finance, email, vpn...everything | Joe Doe (IT), Jane Foo (VP sales)   |
| 2021-01-21        | 2021-01-21      | decommission old server to save money                     | nothing, I think                 | Joe Doe (IT)                        |
| 2021-02-13        | 2021-02-14      | upgrade Exchange server over weekend to get a new feature | email                            | Joe Doe (IT), Alex Bar (VP finance) |

This would probably satisfy regulators and work for a smaller organization. However, problems would quickly arise such as:
* How do people see changes? Does someone email the spreadsheet to them or something?
* How do people see only the changes that are relevant to them? With hundreds or thousands of changes the change that affects you could get lost in the noise. 
* Who is authorized to add changes?
* Who is authorized to approve changes?
* How is a change linked to a physical asset or logical construct? Is there another spreadsheet that lists all the systems? How does that stay up to date?

A slight improvement would be to put all of this information in a database and write an application front-end to control these workflows. At that point you may find that you're writing a basic ITSM from scratch. While you're in the process of designing your new ITSM you may want to also think about incident management. 


## Incident Management Concepts
This section will cover the basic concepts behind Incident Management as a general concept. 

### Why Incident Management is Necessary
Incident Management is fairly straighforward and non controversial but we'll cover the basics here to remember our basic purpose:

* *For Users*: When something is broken it's important for a user to be able to find the right team that can solve the issue so that systems can continue to function with minimal delays. 
* *For Operators*: It's important that only relevant tickets can be routed to your team so that you spend your time fixing only the stuff that's within your control and the noise from irrelevant tickets is eliminated. 

### How to Implement a Basic Incident Management System
Even when more sophisticated systems are available users will often fall back on the most rudimentary of incident reporting mechanisms--an email. 

In a perfect world users would always know who can fix their issue and will just send an email to an individual. That individual will receive the email, fix the problem, and reply back promptly to the user indicating that it's fixed and explain what the issue was. However, as we all know this rarely works in practice at scale. 

What usually happens is that a user will send an email to someone one they think might be able to fix the issue or sometimes they just blast out emails to everyone hoping that someone in the universe will hear them and magically fix their issue.  Operators will receive hundreds of random emails for issues that are so far removed from their scope of responsibility that they quickly just filter all emails to trash. In this system both users and operators are annoyed and nothing gets fixed.

Even when simple systems like this work they provide no way of accurately tracking when an issue was fixed, who fixed it, or how it was fixed for the benefit of future users and operators. 

Therefore, most groups use some sort of incident tracking system that has the following basic features:
* Tickets can be opened easily by users and there are fields within the ticket that help operators find the correct group to solve the issue. 
* Tickets can be easily transferred between teams along with the context and troubleshooting steps that have already been taken. 
* Issues that are resolved via the ticket process can include references to the issue's resolution and root cause analysis so that the issue can be avoided in the future.
* Ticket routing systems are in place so that when teams' responsibilities change the issues can be routed to the new teams. 
* Incidents that were caused by changes can be linked to those changes so that everyone knows what caused an issue.

It would be hard to implement all of the above features in a system as simple as email. Therefore, you should probably go ahead and write this functionality into the same IT service management platform that's handling your change management. This would make it easy to do things like track changes that caused an incident. Since you're already thinking about "things" breaking and changing "things" we need a way to manage "things". Sounds like your IT service management platform needs to have support for managing "things". In the next section we'll talk about inventory for all your things.

## Inventory - A Critical Requirement for Effective Change and Incident Management
One of the commonalities factors that is critical for change and incident management is inventory--you have to know what you're changing and what's broken. 

In any organization of a certain size saying "the server is down" is going to be comically inadequate for an incident. You have to know which server it is so that you can route the ticket to the right team. In the same vein saying "we're rebooting the website" is inadequate for change management because other teams need to know which website you're rebooting so they can understand the impact it will have to the logical business systems.

Therefore it's important to track your infrastructure and applications in a way that you can link the two things together to understand how one affects the other. It's not enough to track only your IT systems (servers, network, databases, etc.) because it's critically important to know which business processes are supported by those systems. For that reason your inventory management system must also support a concept of non-physical abstract or logical "things" such as applications and services as well.


### Implementing a Basic Inventory System
An inventory system needs--at a minimum--to support the following features:
* System Asset information such as 
   * Unique Asset ID
   * Detailed information such as Manufacturer/Model, IP Address, etc.
   * Physical Location or logical location such as which datacenter or cloud account it lives in
   * Purpose (a record of what its purpose in life is)
      * This should also include the logical assets that this system supports
   * Human owner(s) or people who support it
* Logical Asset information such as
   * Application Name/ID
   * Purpose ( a record of what its purpose in life is)
   * Human owner(s) or people who support it

A basic inventory system could be implemented with something as simple as a spreadsheet with the following info:

*System Inventory*

| Asset Type      | Purpose          | ID       | Supports                | Owner        |
|-----------------|------------------|----------|-------------------------|--------------|
| Physical Server | finance database | findb1   | GetPaid Application     | Joe Doe (IT) |
| Virtual Server  | sales website    | web02    | WidgetSales Application | Joe Doe (IT) |
| Network Switch  | networking       | switch03 | everything              | Joe Doe (IT) |

*Logical Asset Inventory*

| Asset Type  | Purpose              | ID          | Supports                   | Owner                |
|-------------|----------------------|-------------|----------------------------|----------------------|
| Application | makes payroll happen | GetPaid     | finance system for payroll | Jim Bar (VP finance) |
| Application | sells widgets        | WidgetSales |                            | Jill Foo (VP sales)  |
| Service     | automates it stuff   | AutomateIT  | everything                 | Joe Doe (IT)         |

However this system would quickly fall over once it reached the hundreds or thousands of assets. Questions arise such as:
* Who can add assets?
* Who can see assets? Is there any sensitive data in the database?
* Who's responsibility is it to maintain the accuracy of the database?
* How can you be sure that Systems and Logical assets relationships are accurately maintained?

This would quickly require a more advanced system that's dedicated to asset management inventory that should integrate with the change and ticketing process. Once again, we could continue building this from scratch but we know that there are commercial solutions that support these requirements. 

Now that we're open to the possibility of using or building an ITSM platform we need to explore both the System and Logical asset concepts. 

### Physical Inventory
This is a no-brainer for most IT professionals to understand. It's critically important to keep records of server information such as: physical location, model number, serial number, number of CPUs, warranty end date, install date, owner, etc.

Even the smallest of IT shops keep at least a spreadsheet with this information. The challenges arise when it's necessary to link changes and incidents to this physical infrastructure so that you can answer questions such as:
* How many failures do I have on Dell vs. HP?
* When do I need to refresh my whole fleet and how much money do I need to ask for from finance to accomplish this?

Most ITSM systems were created to solve this very problem and you won't have many problems convincing your engineers and developers that this is a necessary function so we won't go into any more detail. Just know that the same system that tracks changes and incidents should obviously be linked to the system that handles physical inventory. 

### Virtual and Cloud Inventory
Most companies these days run on virtual infrastructure. This means there are physical servers somewhere that host many virtual servers such as VMWare or AWS/Azure. The concept that rigorous inventory is required even for these systems is tough for even IT professionals to agree on. Of course it's important to know what the IP of the server that hosts payroll is--the question is whether or not the primary source of truth for that information is in my ITSM or from the vendor. We're going to approach the concept from the perspective of cloud because cloud has the same challenges as traditional virtualization and them some.

### Asset Inventory For Cloud
Often in cloud based environments the system inventory problem appears to be taken care of for you with the cloud provider's console and myriad of API's that let you query, modify, and change the asset landscape and you never have to worry about your systems of record. Any new objects that are created are instantly reflected in the API's and show up in your bill immediately. If raw inventory were enough to run a business then this would be fine. However, cloud platforms rarely offer products that help you manage logical constructs such as business processes, applications, services, etc. You could "hack" something together using a cloud based database, a web server front end, etc but you could quickly repeat the spreadsheet blunders outlined in previous sections if you're not careful. 

At the end of the day the cloud assets merely exist to support the logical business processes that allow the business to operate effectively. If you cannot represent these logical  processes within the cloud environment then you must represent them _somewhere_. Therefore we're going to talk about the systems independently and then discuss the intersection between the business and the systems assets.

#### Asset Inventory - Cloud Systems
As we mentioned above, this problem appears to be solved by the platform itself. There can be some technical challenges in how to manage the data coming from these platforms but they're usually solved by middleware solutions that aggregate the data into a single database and then expose that data to parties on a "need to know" basis. 

```
NOTE: Usually the information coming from these cloud and virtual inventory systems is rapidly 
changing. It may seem pointless to duplicate a record in both the inventory aggregation system 
and the ITSM. Each organization will have to evalute whether or not they can achieve the goals 
of change, incident, and inventory management without data duplication. However, even if 
you're not duplicating server records you should absolutely be linking server records to 
logical records like applications and systems in your ITSM inventory
```

For example, let's say you have 300 servers in cloud account A and 1000 servers in cloud account B. You can dump them all into a single database using an account number or server ID as a primary key and then only expose data for each account to members of the business that are listed as owners. The data that comes from the platform itself can be taken whole as it usually contains the information required for systems engineers to perform basic operations. For example, a server record almost always contains information such as:
* IP address
* Operating System
* Subnet
* ID
* Resources (CPU, memory, disk, etc)

However, the real limitation with depending on these API's for running your business is that you often lack the context that ties together a cloud resource with a logical business process. Sometimes you can garner this information by the "Name" of the system or by adding tags to the object which are freeform key value pairs that give you some flexible ways in which to categorize systems.

Two common systems for these managing metadata relationships that are usually handled by an IT service management system are to use tags and/or Infrastructure as Code. We'll cover some challenges with those processes in the next two sections. 


##### Tag Challenges
Most cloud platforms offer the concept of "tags" which are key value pairs that let you add metadata to system infrastructure assets. These can be things as simple as a key "Name" with a value of "webserver02". You can usually have between 20-50 of these tags that theoretically allow you to manage a wide range of complex information. Some more common tags are as follows:

| Key           | Value Example        | Purpose                                                                                                     |
|---------------|----------------------|-------------------------------------------------------------------------------------------------------------|
| Name          | database2            | indicates the server name or role that the server provides                                                  |
| env           | dev                  | indicates that the server is a development server and that maybe it's OK to stop/reboot, etc                |
| uai           | uai1234567           | unique application id -- a record of what application this server supports                                  |
| owner_email   | Bob.Null@company.com | server owner that can be contacted if the server needs to be decomissioned or there are cost questions, etc |
| support_group | it@company.com       | a group that can be contacted if the server needs to be supported                                           |
| cost_center   | finance01            | some organizations use tags to manage billing data                                                          |

Many of the cloud services are "tag aware" and let you do all sorts of nifty things with respect to tags. This includes things such as:
* Allow certain users to only be able to perform actions on resources with a specific tag
* Run reporting that supports tag based filters
* Generate invoices that only include objects with certain tags
* Run scripts that target resources with certain tags
* etc.

In theory you could manage any level of complexity with a sufficiently robust tag system. You could build ruidmentary change control systems by assigning a tag such as:
```
Key: NextChange
Value: Will reboot this server on 1/2/21 to patch. This will impact the application with UAI1234567

Key: PreviousChanges
Value: Server was rebooted on 11/8/2020 due to disk being full, 11/7/2020 this server was rebooted to install a new kernel 
```

Or you could even make a basic incident management system using tags such as:
```
Key: CurrentIncident
Value: 11/8/2020: This server is currently impacted because the disk is full. Reach out to it@company for status

Key: PreviousIncidents
Value: on 11/8/2019 this server was down due to full disk space, on 11/8/2018 this server was down due to full disk space
```

This would suffice for small amounts of information but eventually you would run out of space in the tags. Also, you would probably want to look up historical changes and incidents and have affected other affiliated resources such as database servers, networks, and storage. At that point you need a secondary database to store historical data and you need to privide incident/change ID's to correlate that metadata.

Additionally, in any system based on interaction with tag data you would need to grant users access to the cloud console so that they could interact with these tags (e.g., read, create, modify tags) which would break any sort of tag based access controls you have in place. It wouldn't be a very user friendly interface for non technical users either. 

Therefore, it's practical to separate the metadata from the platform so that users that interact with the metadata can't directly influence the platform. You want to create a gating mechanism between platform modification and the change/incident process. After all, users who could self-service repair their own platforms wouldn't have much of a need for a incident/change middleware. 

Once you've eliminated tags as a possibility it appears logical to keep the system inventory and logical asset inventory "separate but equal"--keep intentions as metadata and truth as data. At this point you're pushed towards building an application and database to run your metadata system. Once again, you're either going to need to build this functionality into your custom ITSM solution or make sure a commercial option supports this feature.


##### Regarding Modern Automated Systems Management
There are a few alternative ways to manage infrastructure that directly clash with ITIL based systems management--notably CI/CD and Infrastructure as Code. The following two sections will cover some ways that these two methodologies can remain effective while still participating in the overall IT Systems Management construct.

_*Infrastructre as Code Challenges*_

Another temptation for cloud engineers to manage system inventory is to use "Infrastructure as Code" (IAC) paradigms to manage metadata and systems as a "one size fits all" solution. IAC is a concept where all of your infrastructure is defined as plaintext documents in code repositories. When changes to the code repositories are made via standard software development gating processes such as pull requests, code reviews, and commit history, those changes are automatically applied to the system infrastructure. On the surface this sounds like it ticks a lot of the boxes of an IT service management system. 

This paradigm undoubtedly solves a lot of problems:
* Change history is documented using the commit history of the code repository system
* Proposed changes can be reviewed by peers who understand the code and it's relationships to the infrastructure. Changes can be allowed or denied by these peers. 
* Changes that didn't go well can be rolled back easily simply by reverting a commit.
* Metadata about the purpose of individual components can be stored as code comments providing virtually unlimited amounts of metadata.
* Direct access permissions to the cloud platform becomes less important as permissions to change system infrastructure can be granted via the code repository
* The sytem infrastructure itself almost becomes less senstive to destruction because its configuration can be redeployed so easily. 
* Virtually unlimited Dev/Test/Stage environments can be built on a whim to test changes simply by editing some lines of code.
* The "black box" complexity of system configuration can be exposed because everything is there in the repository as black and white plain text.
*  and much more....

This is a fantastic way for engineers to manage infrastructure. It's been a very popular trend in the IT engineering space for at least a decade. However, it does come with its own challenges. Some of the limitations include:
* Only people who understand the "code" can request changes
* Understanding the relationships between dependent systems across multiple disparate code repositories can be daunting.
* Aggregating inventory/change data across systems would require collecting information from code repositories in multiple different IAC paradigms.
* IAC doesn't really address the problem of incident tracking on it's own and makes it difficult for a separate incident tracking system to link incidents to changes.

Therefore, if you want all three features (incident, change, and inventory) in your organization you'll need a way to link them together somehow. The best solution is probably a hybrid of IAC doing the technical "heavy lifting" combined with an IT service management platform that can track the macro changes between systems. For example, you can work out the nitty gritty details of a system upgrade through the traditional IAC development process which culminates in a hefty pull request. The team can then submit a change request in the IT service management system to the tune of:
 
| Change Description                                              | Change Details                                 | Affects Physical Systems                                                               | Affects Logical Systems | Change Start Date    | Change End Date     |
|-----------------------------------------------------------------|------------------------------------------------|----------------------------------------------------------------------------------------|-------------------------|----------------------|---------------------|
| Upgrade GetPaid to latest version to support paying contractors | See pull request for details HERE (link to PR) | DatabaseServer1,DatabaseServer2,Subnet3,Subnet4,CloudAccountA (see more details in PR) | GetPaid                 | 2021-03-19 03:00:000 | 2021-03-19 04:00:00 |

This sort of change can be submitted via automation or by the IAC team's product/team manager as an olive branch and a means of participating in the context of the larger organization. Often times it's a regulatory requirement or an audit finding that causes teams to have to submit this kind of paperwork/busywork. 

Most people who are familiar with IAC will immediately complain that the "physical" systems that would be affected are usually ephemeral and cannot be tracked in a system like this. This is often true, but it's important to link these changes to the next closest piece of infrastructure that can remotely be thought of as "permanent" such as a cloud account, load balancer, DNS name, etc. The intent is to get as detailed as possible while remaining "in the ballpark". You'd be surprised how helpful something as vague as "the stuff behind website.com changed on Friday" or "some changes were made to CloudAccountB on Thursday" in the context of the larger organization. The details are often not important when external groups are simply trying to find some team that changed website.com or has been messing around in CloudAccountB recently. The term "don't let the perfect be the enemy of the good" comes to mind. 


_*CI/CD Challenges*_

While this topic is slightly more relevant in the context of change management it's often so interlinked with IAC that it felt appropriate to mention it here. 

Many teams have adopted a software development methodology known as CI/CD which stands for Continuous Integration/Continuous Deployment. In a nutshell this means that as soon as you commit code to a repository the code is automatically tested, built, and deployed to production. Done correctly this enables rapid safe changes and can be a massive competitive advantage for a software company and speed to market. There are hundreds of books written about this topic so we won't go into too much detail. Rather, we will focus on the impact CI/CD can have to our IT Systems Management goals and how we might strike a balance. 

In CI/CD systems many things that are traditionally thought of as impossible to automate are automated--an interface to the chanage management system should be no different. Most modern change management systems have API's. The CD portion of the CI/CD system can send an automated change notification into the system so that anyone who needs to know about recent changes to an environment can have that information available when they are researching an incident or gathering info for an audit. Even if your team has reached the DevOps Valhalla and are "deploying to production 30 times a day" it is likely that the ITSM can handle the volume. A problem such as "too many successful production changes are causing noise in the system" would be a beautiful problem to have one day and more than likely most companies who need an ITSM aren't going to have this problem.

This is all great for teams who can deploy on a "notify only" basis but many teams still require a human to approve major changes to production systems. Even in CI/CD teams there are plenty of opportunities to use the ITSM's change management functionality to act as a gating mechanism. 

In the IAC section we talked about the pull request workflows and how there are opportunities for automation and/or human intervention in these workflows. Even in highly automated teams such as those that utilize IAC and CI/CD there are points in time where humans must decide whether to allow a change into an environment. Pull requests are a prime example of this. During pull requests a human is given the opportunity to make a decision on whether changes may have negative consequences to a system. No sane manager or team lead would ever approve a risky change without at least letting their stakeholders know that there is a risk. All that is asked is that at this decision point and along with any other stakeholder communications a change record is submitted through the ITSM system. Teams may choose to either wait for the change to be approved in the ITSM or they could use automated integrations in a pull request workflow to auto-merge pull requests after detecting that a linked change in the ITSM has been approved. 

_*Conclusion*_

ITSM inventory management integration for IAC and change management with CI/CD teams is challengin but not impossible. A sufficiently mature organization would not have much tolerance for teams operating critical systems without ITSM integration anyway. 

The two strategies covered above provide a decent balance between managing the nitty gritty details of managing software/infrastructure and providing context to the business. Of course, all this effort is ultimately aimed at having a good way of linking technical system intent to logical business systems. In the next section we're going to discuss the concept of logical inventory. 


### Asset Inventory - Logical Business Constructs
As mentioned in the introduction to this document it is critical for business to track logical systems. Here we will explore in more details the features that a logical system inventory should have. If you were to attempt to build a very basic logical inventory it may look something like the below example.

| Asset Type  | Purpose                    | ID          | Supports                   | Owner                | Data Classification | Criticality |
|-------------|----------------------------|-------------|----------------------------|----------------------|---------------------|-------------|
| Application | makes payroll happen       | GetPaid     | finance system for payroll | Jim Bar (VP finance) | PII, SOX            | High        |
| Application | sells widgets              | WidgetSales |                            | Jill Foo (VP sales)  | Public Information  | Medium      |
| Service     | automates it stuff         | AutomateIT  | everything                 | Joe Doe (IT)         | Company Private     | Low         |
| Service     | enables communication      | Email       | everything                 | Joe Doe (IT)         | PII, HIPAA, SOX     | High        |
| Service     | resolve IP addresses       | iDNS        | everything                 | Jeff Baf (IT)        | Company Private     | High        |
| Application | shares news with the world | CompanyBlog |                            | Bill Bam (Marketing) | Public Information  | Low         |

There could be many thousands of servers that support the above logical functions. Those could even be broken down into their own logical systems as well 

| Asset Type | Purpose                        | ID          | Supports              | Owner                     | Data Classification | Criticality |
|------------|--------------------------------|-------------|-----------------------|---------------------------|---------------------|-------------|
| Service    | Feeds data to GetPaid          | GetPaidETL  | GetPaid               | Jess Charlie (Finance IT) | PII, SOX            | High        |
| Service    | generates reports from GetPaid | GetPaidView | auditors, HR          | Jess Charlie (Finance IT) | PII, Sox            | Medium      |
| Service    | provides DNS for east coast US | iDNS-east   | east coast operations | Pam Bates (IT)            | Company Private     | Medium      |

Combined with a "Physical" inventory we can link invidual servers to logical constructs

| Asset Type   | Purpose                      | ID                    | Owner                      | Criticality | Supports
|--------------|------------------------------|-----------------------|----------------------------|-------------|-------------|
| Server       | failover node for GetPaidETL | gpe001.company.com    | Dave Doodle (IT associate) | Low         | GetPaidETL  |
| Server       | primary dns endpoint         | idns-e001.company.com | Dave Doodle (IT associate) | High        | iDNS-east   |
| Cloud Server | node of blog website         | cblog005.company.com  | Edgar Foo (Marketing IT)   | Low         | CompanyBlog |
| Cloud Server | node of blog website         | cblog006.company.com  | Edgar Foo (Marketing IT)   | Low         | CompanyBlog |
| Cloud Server | node of blog website         | cblog007.company.com  | Edgar Foo (Marketing IT)   | Low         | CompanyBlog |
| Cloud Server | node of blog website         | cblog008.company.com  | Edgar Foo (Marketing IT)   | Low         | CompanyBlog |

With a system of record like this we can start to see how we could use the information to make intelligent decisions on the impact of changes to systems and servers. For example, if someone proposes a change that indicates they need to reboot a blog server they can use the criticality field to decide that it's a low impact change and that no review is necessary. However, if someone wants to upgrade the only DNS server that supports the US East coast then they might want to make sure that it's not during a critical time such as year end financial close. 

Also, this information can be used to generate reporting about how data is classified and the data interactions between logical systems. 

Of course, it's also important to be able to link an incident that may be happening on a particular server to a business process so that stakeholders for that business process are aware that the process may be impacted. 

## Conclusion
IT infrastructure and the impact of incidents, changes, and inventory hold a crucial role in the impact to a business. If you're not already using an ITSM to manage your IT Systems then please consider implementing a commercial solution such as ServiceNow or BMC. At the very least you should try to build your own system that implements the basic functions covered in this document. A successful ITSM is not just the concern of systems administrators and software engineers--it requires participation from all facets of the business.

* Business function owners should query their IT organizations to understand how ITSM is handled at their organization and ask them what they can do to help keep systems of record up to date. Ask questions such as "How can I tell when someone is making a change to something I depend on?"
* IT managers and corporate governance organizations should expect these questions from the business and be prepared to evaluate the quality of their current ITSM. If these questions are hard to answer then they should consider the resources they have allocated into maintaining data integrity and enforcing business processes through these systems. 
* Software and Infrastructure engineers should understand why someone from a corporate governance organization cares about this information and spend some time making sure their daily operational tasks are ITSM aware. It may be challenging but at the end of the day it is your duty to protect the interests of the business and your efforts here will ultimately lead to more transparency and stability for the organization as a whole and thus may provide welcome clarity in an otherwise confusing and complex world. 

Even if you don't think this is relevant to you and your job, hopefully this document helped you to understand why it's important to many people within a business. 

## References
* \[1\] ["Guide to SOX IT Risk Controls" Protiviti](https://www.protiviti.com/sites/default/files/united_states/insights/guide-to-sox-it-risks-controls-protiviti.pdf)
* \[2\] ["Change Control" WikiPedia](https://en.wikipedia.org/wiki/Change_control#Regulatory_environment)

### Other References
"Are Change Management, Continuous Improvement, and Innovation the Same?" [](https://www.nist.gov/comment/16661)
