---
title: "The High Cost of Cloud Talent"
date: 2021-10-18
---

Talented cloud engineers are expensive and it's getting worse during the Great Resignation[1]. As more and more enterprise workloads move to cloud hosting it's approaching a tipping point where this could become a serious problem. This rising labor cost is threatening to undercut the "lower total cost of ownership" promises from cloud vendors and consultancy services which in turn could push decision makers towards cheaper, less secure options that are more expensive in the long run. Let's take a what the costs are, how we got here, the current challenges, and what some posible outcomes could be. 


---
** NOTE **
While some of the information here is substantiated with references most of the contents are the author's opinion from working in the enterprise cloud space as an operations engineer, cloud devops engineer, operations manager, and architecture manager over the course of 5 years. 

---

---
** NOTE2 **
This is written from the perspective of a central'ish hosting organization performing cloud consulting and some high level operational support which is typical of many organizations. What is _not_ discussed in detail is the great range of skills that would be required of a developer embedded on an application team who has to also figure out how to build a CI/CD pipeline for the team (a.k.a, 10x DevOps Guru Person) of which there are probably only 10,000 in existence which is not enough to cover the needs of all the applications in the cloud. This elusive DevOps person's natural habitat is a startup environment and would quickly grow frustrated in a larger organization anyway. 
---

## Costs
First, let's qualify what we mean by "expensive". A typical enterprise has a portfolio of at least a few hundred applications that require some sort of hosting infrastructure. Frequently, these workloads are being pushed to cloud for a litany of reasons that are outside the scope of this post. In order to design, build, secure, operate, and monitor each application it requires certain skillsets which are broken down by the following table based on their market rates and timeshare for how long their skills are required. Not every organization has their teams structured like this as sometimes all the roles are being performed by a more or less persons however, it is representative of a typical enterprise team for a small application with a few external integration requirements (e.g., connection to an on-prem database). 

|        Role         |    Task        | Salary     | Time Required | One Time Cost | Ongoing Cost (annually) |
|---------------------|----------------|------------|---------------|---------------|-------------------------|
| Solutions Architect | Design         |  $128k [2] | 3 weeks^      | $5k           |  $2.5k                  |
| Ops Engineer        | Build/Run      |  $100k     | 3 weeks^^     | $3.8k         |  $1.2k                  |
| Security            | Review/Monitor |  $120k     | 1 week^^^     | $1k           |  $1k                    |
|                     |                |            |               |               |                         |
|                     |                |            |  TOTAL        | $9.8k/app     |  $4.7k/app              |

<sub>^ - The architect gathers requirements from stakeholders, puts together drawings, prepares firewall requests, plans timelines, etc. Their time is usually spread across multiple projects which for a small application can equate to about two total weeks of focus time. You can also expect some feature enhancement, refactor, or other kind of follow up work in the near future which is covered by the Ongoing Cost estimate. <BR>
^^ - The Ops Engineer builds the environment per spec from the architect and invariably has to make tweaks along the way based on reality which take up time. Also, they can expect to have ongoing time commitments due to outages, patching, etc. Initial build/deploy time can easily take a week and a few outages or patch windows can consume the remaining two weeks.<BR>
^^^ - The security team can be expected to sign off on any designs, validating the use of new technologies, pushing back on requests, etc. which can take a few meetings per application. There are typically expected to build  monitoring infrastructure to validate security requirements on a continuous basis such as vulnerability scanning, liberal use of ports, key rotations, etc.<BR></sub>

While most of these numbers fairly represent small to medium sized applications they can vary greatly depending on the complexity of the application, how many integrations with other applications are required, the organization's maturity with the technologies requested in the architecture, etc. However, for the purposes of this demonstration let's just pretend this is an accurate average cost. So looking at this hyptothetical three person team you can work out some macro statistics.

* Maximum Throughput (new projects annually) = 17 apps
* Annual Cost (new projects) = $166k
* Annual Maintenance (for 17 apps) = $80k/yr

## Reference
* [1] - Great Resignation (https://en.wikipedia.org/wiki/Great_Resignation)
* [2] - Cloud Solutions Architect Salary - https://www.payscale.com/research/US/Job=Cloud_Solutions_Architect/Salary
