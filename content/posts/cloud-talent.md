---
title: "The High Cost of Cloud Talent"
date: 2021-10-18
---

Talented cloud engineers are expensive and it's getting worse during the Great Resignation[1]. As more and more enterprise workloads move to cloud hosting it's approaching a tipping point where this could become a serious problem. This rising labor cost is threatening to undercut the "lower total cost of ownership" promises from cloud vendors and consultancy services which in turn could push decision makers towards cheaper, less secure options that are more expensive in the long run. Let's take a look at how we got here, the current challenges, and what some posible outcomes could be.  

First, let's qualify what we mean by "expensive". A typical enterprise has a portfolio of at least a few hundred applications that require some sort of hosting infrastructure. In order to design, build, secure, operate, and monitor each application it requires certain skillsets which are broken down by the following table based on their market rates and timeshare for how long their skills are required. Not every organization has their teams structured like this as sometimes all the roles are being performed by a single person however, it is representative of a typical enterprise team. 

|        Role         |    Task        | Salary     | Time Required | One Time Cost | Ongoing Cost (annually) |
|---------------------|----------------|------------|---------------|---------------|-------------------------|
| Solutions Architect | Design         |  $128k [2] | 2 weeks^      | $5k           |                         |
| Ops Engineer        | Build/Run      |  $100k     | 3 weeks^^     | $3.8k         |  $1.2k                  |
| Security            | Review/Monitor |  $120k     | 1 week^^^     | $1k           |  $1k                    |
|                     |                |            |               |               |                         |
|                     |                |            |  TOTAL        | $9.8k/app     |  $2.2k/app              |

^ - The architect gathers requirements from stakeholders, puts together drawings, prepares firewall requests, plans timelines, etc. Their time is usually spread across multiple projects which for a small application can equate to about two total weeks of focus time. 
^^ - The Ops Engineer builds the environment per spec from the architect and invariably has to make tweaks along the way based on reality which take up time. Also, they can expect to have ongoing time commitments due to outages, patching, etc. Initial build/deploy time can easily take a week and a few outages or patch windows can consume the remaining two weeks. 
^^^ - The security team can be expected to sign off on any designs, validating the use of new technologies, pushing back on requests, etc. which can take a few meetings per application. There are typically expected to build  monitoring infrastructure to validate security requirements on a continuous basis such as vulnerability scanning, liberal use of ports, key rotations, etc.


[1] - Great Resignation (https://en.wikipedia.org/wiki/Great_Resignation)
[2] - Cloud Solutions Architect Salary - https://www.payscale.com/research/US/Job=Cloud_Solutions_Architect/Salary
