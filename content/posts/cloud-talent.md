---
title: "The High Cost of Cloud Talent"
date: 2021-10-18
---

Talented cloud engineers are expensive and it's getting worse during the Great Resignation[1]. As more and more enterprise workloads move to cloud hosting it's approaching a tipping point where this could become a serious problem.

Highly customized application infrastructure is pushing the engineer to application ratio closer and closer to 1:1 and at an average salary of $130k USD this rising labor cost is threatening to undercut the "lower total cost of ownership" promises from cloud vendors and consultancy services, which in turn could push decision makers towards cheaper, less secure options that are more expensive in the long run. Let's take at how we got here, the current challenges, and what some possible outcomes could be. 

> <sub>NOTE: While some of the information here is substantiated with references most of the contents are the author's opinion from working in the enterprise cloud space as an operations engineer, cloud devops engineer, operations manager, and architecture manager over the course of 5 years.</sub>
>  
> <sub>NOTE2: This is written from the perspective of a central'ish hosting organization performing cloud consulting and some high level operational support which is typical of many large organizations. What is _not_ discussed in detail is the great range of skills that would be required of a developer embedded on an application team who has to also figure out how to build a CI/CD pipeline for the team (a.k.a, 10x DevOps Guru Person) of which there are probably only 10,000 in existence which is not enough to cover the needs of all the applications in the cloud. This elusive DevOps person's natural habitat is a startup environment and would quickly grow frustrated in a larger organization anyway.</sub>

## How We Got Here
It used to be that if you were a developer and you had some code you wanted to run you had to contact some central IT team and get some form of physical or virtual compute in order to run your code. This is probably via some form that asks you for your billing codes, desired cpu/ram/storage, and mother's maiden name. Then someone would get back to you in some number of weeks or months with clarifying questions and then a few more weeks/months go by and you might have a server. You'd be given an IP and SSH keys or something so you could log in and deploy your code. Whenever there was a problem with the OS/Hardware you could call some number and somebody would support you. If things got really bad you'd hear data center noises in the background of the call. In this world you could happily blame IT for all of your slowness problems and bemoan the hassle of your server going down for patching/upgrades, etc. but at the end of the day you had your domain and they had theirs. People could happily grumble their way through their work as a house divided. Life was kind of crappy but at least you could blame someone else when something went wrong. 

Then came the cloud and out came the credit cards. Developers found out they could just spin up servers whenever they wanted and not be hassled by greybeards[2] for downtime and middle managers asking them for 2 year equipment lease commitments. This was a golden era of innovation where executives one-upped each other by comparing the number of production deployments per day at the company Christmas parties and problems could be solved instantly by "cross-functional teams" with on-prem rotations. Life was good for greenfield applications.

The cloud was also starting to look attractive for legacy workloads where there were significant benefits such as cost-savings, flexibility (auto shutdown schedules anyone?), accurate inventory and billing in areas that were traditionally black-boxes. As more workloads moved to cloud, the possibility of actually _closing data centers_ became realistic. This was the ultimate goal--no more lease agreements, no more contracts in far away places like Amsterdam, no more need for local talent and foreign labor laws, no more steak dinners and purchase order foreplay with Dell and NetApp. The on-prem exodus was in full motion. Talented data center personnel saw the writing on the wall and quietly found new jobs. Server teams and grumpy greybeards were told "there's absolutely nothing to worry about" while their budgets shrunk and their headcount froze. "Keep the lights on" posters were mailed out to every location. 

There was also a new lifeline for those forward thinking, talented infrastructure architects coming from the legacy space and devs with an interest in infrastructure because now they had Legos to play with and they could build literally anything they wanted via clicks/API's. When a product owner approaches them wringing their hands with an infrastructure problem looking for a solution it's now a _pleasure_ to solve and become an instant hero at the same time. Instead of an exercise in monotony and a bloated solution involving racks of hardware it's now a puzzle to find out how to solve their problem in the most clever way possible using the most non-standard solutions (as a bonus, now they can put "serverless" on their CV and get a new job with free snacks).  A bespoke solution at the lowest cost to solve exactly the right problem is a win-win for everyone, right?
 
However, some interesting things started happening in cloud land like S3 data breaches [3], entire teams leaving the company and leaving 900 EC2 instances running some unknown critical application, promises of massive savings through enterprise agreements and reserved instance purchases, and connections to the corporate network through DirectConnect/ExpressRoute. The borders were now threatened, entire towns were in need of federal aid, tax revenue was being lost and the Federal Marshals had to restore order to the Wild West. The great centralization effort began and it was time for Corporate to lay down the law. 

No longer was it OK to have warrant less public S3 buckets, wide open security groups, marketplace OS images from "hackme.ru", and credit cards funding accounts. There was a need for master payer agreements, governance policies, and account creation departments. This was generally agreed to be a good thing and a lot of the best cloud talent from the Wild West was hired into the central teams. The free love of the 60's had ended and now it was Reagan's War on Drugs. The cloud was still pretty flexible but there are some pretty serious controls in place. "Cowboys"[4] were devalued and while some talent in the remote offices still saw the need to stick around and keep building infrastructure for their developers, a lot of them left to go someplace with more freedom--likely someplace earlier on in their cocaine infused cloud craze and cowboy salaries.

This leaves us with some pretty talented central teams and a lot of disenfranchised sub-departments.  The idea is now that these central teams have "control" can help the departments out with all of their cloud needs which _seems_ reasonable as everything can be done in a browser and there's full visibility into all departments. Flexibility, however, can be a cruel mistress. Now we enter the modern age. 

## The Current Challenges
> cloud person[ kloud pur-suhn ]
> 
> _noun_, plural **cloud people**
> 1. a human being who is incapable of hosting an application on EC2 and insists on using serverless because they're religious beliefs do not allow them to deploy a sub-optimal solution
> 
Now we find ourselves with full control over a few hundred AWS accounts with a few thousand variations of infrastructure patterns. How do we maintain control while also fostering a culture of innovation? There are multiple approaches that are outside the scope of this discussion but no matter how you solve it you end up in one of the following situations:

* A large central team of cloud people with full control with a minority of application-aware sub-department cloud people with no power.
* A small central team with full control and a large number of application-aware sub-department cloud people with some power.


In either case your cloud people are going to have to get good at managing applications. After all, that's the whole point of cloud is to host some code that adds some sort of business value, right? This wouldn't be too much of a problem if everything looked the same--if it was all just boring EC2 instances with a sprinkling of RDS. However, while the people came for EC2, they stayed for lambda and life is complicated now. 

Now there's a new predicament: you need smart people to manage the complexity of the platform _and_ the application. It's almost impossible to divorce a cloud-native application from the underlying infrastructure but since all the power has (justifiably) been taken away from the cowboys, your new cloud people (the ones wearing collared shirts) have to get to know the applications _intimately_. This means the cloud person to application ratio is anywhere between 3:1 and 30:1 depending on a salary between $80k/yr and $200k/yr. Without some form of standardization, this leaves your per-application infrastructure talent cost somewhere between $7k and $26k. For an organization with 200 applications that's between $1.4 million/yr and $5.2 million/yr outside of your expected cloud bill, developer salaries, and administrative salaries. That's a pretty sobering number to be looking at after someone told you Cloud could solve all your problems. 

Of course, these numbers can be reduced via standardization but have you ever tried telling an application team they can't use anything except EC2? What the hell is the point of cloud if I can't use Cognito and ML!? What is the real cost-savings if all you're letting people use are things from the compute portfolio? And let's say you do manage to set an "EC2 Only" policy. Who is going to go out to an application team and tell them they have to go back in time to 2010 during their next outage window? What cloud-person (aka smart person) would tolerate being hamstrung with no chance of fluffing up their CV?

Even if you wanted to make a massive central department of cloud rockstars you're now trying to pull that talent in from the free market where they've been getting cowboy salaries for the past five years. How do you even pull cowboy talent into a role where they have to manage the infrastructure for thirty different applications? How do you fund their roles?

In many ways cloud people have brought this problem on themselves. When people came to them looking for solutions they were so enamored by the possibility of building the best solution with their new shiny tools that they failed to play the tape forward and think to themselves "How am I going to manage 200 applications with 130 different architectures?".

One is reminded of the history of automobile where in the beginning, every car was a custom job commissioned through a carriage works. There were hundreds of firms claiming they could build the best automobile and it was a golden era of innovation and creativity. However, the costs were high and the first automobiles were only available to the wealthy. Repairs and modifications could only be done by the manufacturer in many cases. Henry Ford saw the inefficiencies in this model and is famously credited for bringing the automobile to the masses via standardization. The firt mass produced automobiles had almost no custom options from the factory which was advertised almost as a feature in the quote "Any customer can have a car painted any colour that he wants so long as it is black" [5]. This model was obviously wildly successful and over time, manufacturers became bigger and bigger via acquisition and mergers until hardly anybody could tell the difference between a Civic and a Corolla. Exciting vehicles became a fringe movement. 

To shelve the analogy, the corporate cloud is in a phase where everything is still a custom job and Henry Ford hasn't come along yet. Cloud infrastructure is still pretty expensive because despite the Lego pieces being standard they are often put together in completely unique configurations. There is very little standard work which leads to a management conundrum and soaring costs. But what are our options? 

## Possible Outcomes
There are a few directions to go from here which all have their pros and cons: keep building custom solutions and just pay more people well or standardize the work and make IT boring again. But before we go through these two scenarios and flesh them out a bit let's define what we see as the primary responsibilities of a centralized cloud management team. 

* **EVM (aka, patching)** - vulnerabilities must be patched frequently and if the central teams think the application teams will do this then they're just wrong--nobody patches if things are working. This becomes tricky with serverless and especially with docker images. Can you imagine forcibly changing someone's Dockerfile from `FROM ubuntu:18.04` to `FROM ubuntu:20.04` and expect everything to work? These things are just hard and take smart people to solve. 
* **Audits** - if you're going to be hosting any workload for a large organization then likely you'll be hosting SOX/PCI/HIPAA applications in which case auditors are a fact of life--like termites and the common cold. Often times app teams are the primary target for these auditors but they'll very quickly commission the cloud team for assitance. They're just going to come and wreck you at the worst possible time. They'll come out of nowhere one day and say something like "You are hereby ordered to make sure every Security Group in these three accounts has the 'all outbound traffic' rule removed". This is a serious technical challenge that requires very smart people to solve at scale and a deep knowledge of the behavior of hundreds of applications. It's grueling work and it just flat out takes time--even for small applications. 
* **Cost Optimization**  - One of the beautiful things about cloud is an almost unlimited potential for cost savings. Take one person from your cloud team and task them with saving money at scale and they can come up with some mouth-watering numbers from doing seemingly simple things like shutdown schedules, instance right-sizing, RDS instance to Aurora migrations, EBS snapshot cleanup, etc. This sort of clutter piles up pretty quickly and a centralized team is well positioned to go after these targets. However, it's just flat out work and takes a lot of time to fix at scale. 
* **Asset Management** - This is like keeping a rolling census on metadata that isn't easily standardized from a developer's perspective. For example, "If my application stores sensitive data do I put a tag on it that says `Data Classification: High` or do I put `Data Classification: high`? Do I put `dev` or `development`?" For more on why this is important see my [ITSM and Cloud](../itsm-and-cloud) post. In any case, this can only really be done well by a central oversight team setting standards, writing governance automation, and regularly nagging people to put the right info down. 
* **Architecture** - The whole reason there's a central cloud team is because that's where the knowledge of the cloud platform lives. Sometimes developers have a rough idea of what the capabilities of the cloud are and can sketch something out on the back of a napkin but it's going to take someone who truly knows the hosting infrastructure to flesh out details such as routing tables, NACLs, Security Groups, available images, approved services, etc. Even if you have a great DevOps person on an app team they're not going to know all of the quirks of _your_ hosting environment. Therefore, architectural support could range from a simple design review with minor suggestions to a full blown design/feature gathering engagement. Either way the central team will have to have some way of handling these requests. 
* **Build** - It's very rare that central teams give every developer the permissions to build infrastructure. Even if they have `ec2:*` permissions that's often not enough to do full builds when things like instance profiles are required. Some of this can be handled with permission boundaries, etc. but someone still has to maintain the guardrails and coach teams through things like Cloudformation tooling, tips and tricks for navigating SCP/Policy restrictions, etc. Depending on the service levels provided by the central team and the capabilities of the app teams these engagements could range from simple documentation to hands on keyboard build sessions. Either way there will have to be some sort of build liason. 
* **Documentation** - The smaller the team the more need there is for documentation. The whole point of the central team is to set standards, enforce policy, and provide general oversight. At the very least this should be a documentation portal that actually defines what the standards are. For example:
  * Tagging Standards
  * Identity Restrictions (e.g., "no IAM users allowed, roles only")
  * How To's for common questions
  * Governance Restrictions on Services ([example](../raci.md))

The above responsibilities have almost unlimited variability in their broadness of scope dependent on company culture, team size, cyber security risk appetite, and application team skill levels. They could range from a simple documentation portal for a small central team to full service operations for a larger team. A lot of that has to do with whether or not the central team leans more towards custom work or standardized work. 

### Custom Work
Keep in mind that we've previously established that much of the power has been taken away from distributed application teams and the cloud is now governed by a centralized team. App teams are no longer able to do reckless things like peer VPC's with accounts outside the organization, create public IP's, have open S3 buckets, etc. If these are things that applications need in order to be successful then they are going to bump up against whatever controls are in place and will have to work closely with the central team. 

With a "custom work" culture the projects will be complicated, time consuming, and engineers will be expensive. In order to maintain enough staff to cover the central team's responsibilities leadership will have to figure out a comprehensive funding model as their first order of business. This could simply be a per-application fee to manage custom cloud configurations which depending on how you [do the math](#costs) could be $10k/yr.  It's undoubtedly a difficult conversation to go to an application team looking to host some Javascript and a lightweight PostgreSQL DB and tell them it will cost them $800/month for support for something that will likely never go down. But people often forget about all of the work that goes into even minor applications which are documented in the previous responsibilies section. 

While most of this is standard regardless of the application size there are more challenges in managing larger applications which often have complex, multi technology architectures that require dedicated personnel when upgrades, patches, modifications need to be performed.  Large applications are often important and draw a lot of attention during outages and will pull multiple engineers into bridges and post-mortems. However, these behemoths are also well funded meaning they can sustain higher maintenance fees. 

For this reason it's likely that a "T-Shirt Size" approach can be used for maintenance fees from the central team when managing their application portfolio and could use a pricing and staffing model such as

| App Size | Monthly Fee | Number of Engineers |
|----------|-------------|---------------------|
| Small    |   $5k       |       0.5           |
| Medium   |   $10k      |        1            |
| Large    |   $20k      |        2            |

These are pretty significant costs that would have to be passed back down to the app owners and likely down to their customers. This would ensure stable staffing and excellent service levels it's doubtful that many organizations can sustain a price structure like this. The costs could be shuffled a bit by requiring higher initial fees for roll out and smaller fees for maintenance but at the end of the day the engineer to application ratio still has to be maintained and funded in the custom architecture model. 

What if we simply did not allow custom configurations at all? What if we were able to steer app teams towards standardized architecture? Would that allow us to still be effective? Would it make a difference in our cost structure?

### Standardized Work
Let's assume the custom architecture model is too expensive and unsustainable and take a look at the second "standardization" approach. This would keep the per-application cost much lower and the range of technologies in use would shrink which presumably would make it easier to staff. Architectures would only be available in a few different flavors and therefore would be much easier to manage at scale which can push your required T-shirt funding model closer to something like: 

| App Size | Monthly Fee | Number of Engineers |
|----------|-------------|---------------------|
| Small    |   $1k       |       0.1           |
| Medium   |   $5k      |        0.5            |
| Large    |   $10k      |        1            |

But what would the trade-offs be?

#### Pros
* **Cheaper** labor. 
* **Self Service Architecture** - Since the infrastructure is standard you could just put together a "Service Catalog" approach for compute and application teams could just pick everything from a drop down form. This would eliminate most of the need for a large architecture team. Everything that's available in this catalog could have patching agents, security hardening, monitoring baked into the images and bootstrap scripts. This approach is nothing new and was pretty common even back in the early days of VMWare. The drawbacks of course are that people will have over allocated infrastructure and will likely leave unused capacity laying around everywhere but if you have your billing system optimized it could mostly self-police.
* **Ease of Maintenance** - Standardized work would be far easier to maintain in the long run. Patching and upgrades become routine and scalable. Monitoring and log collection can be standardized.
* **Economies of Scale** - Vendor licensing can be purchased in bulk. Reserved Instances/Spending Plans can be created with relative ease. Cheaper instance types can be pushed out in massive waves.
* **Simplicity** of operations. People often underestimate the amount of work that goes into handling edge cases when new technologies are allowed. For the people doing the work it means a lot more work and for the managers it means more sleepless nights. 

#### Cons
* **Inflexible architecture** will cause large inefficiencies from app to app.
* **Innovation will suffer** and people looking to do interesting things will get lost in the bureaucracy.
* **Abuse** would increase as people would start getting very creative within their walled gardens and start doing things like overloading servers with multiple apps.
* **Higher cloud vendor bill** due to inefficiencies even though labor costs go down.
* **Attracting and retaining talent** would be difficult because "cloud people" don't like boring work.

While there are many benefits to a rigid standardized model is likely not sufficient for many organizations due to its inelasticity. There will always be some special app that comes along that will end up having high visibility from leadership and get shoved through the team. These will just end up being asterisks and exceptions that will be cause stress for everyone. For that reason we want to have a "happy path" for more complex work as well. 

What if we were to take the two approaches and blend them together?

## Hybrid Approach
We want to have a fast track for standard applications and also be able to support more complex applications. The way we would do this in any free market system is to make the standard path really cheap and make the custom path expensive. If we had a mix of capabilities on our price sheet then in a perfect world it might look like this:

|   App Category  | Monthly Fee | Number of Engineers |
|-----------------|-------------|---------------------|
| Standard Small  |   $1k       |       0.1           |
| Standard Medium |   $5k       |        0.5          |
| Standard Large  |   $10k      |        1            |
| Custom Small    |   $12k      |       1.2           |
| Custom Medium   |   $20k      |        2            |
| Custom Large    |   $30k      |        3            |

However, let's look at a real world organization that's struggling and break down the numbers.

![Org](/img/org.png)

## Conclusion
The bottom line is that cloud infrastructure is just damned complicated these days. It's very difficult to divorce the application from the infrastructure and thus the engineer to application ratio has gotten higher and higher as the list of cloud features has grown. 

We have entered an era in enterprise cloud where most of us need to be driving our applications to work in Honda Civics and Ferrari's should be expensive to drive. In other words, standardized work should be the easy way to get applications hosted with few barriers. Custom architecture should be available albeit expensive. Either way, the most important aspect is having a rock solid funding model for both approaches which is likely higher than most people expect. 






---

## Reference
* [1] - Great Resignation (https://en.wikipedia.org/wiki/Great_Resignation)
* [2] - Greybeard  (https://gist.github.com/lenards/3739917#:~:text=greybeard-,Greybeard,use%20a%20remotely%20contemporary%20computer.)
* [3] - S3 Data Breaches - (https://businessinsights.bitdefender.com/worst-amazon-breaches)
* [4] - Cowboy Coder (https://en.wikipedia.org/wiki/Cowboy_coding)
* [5] - "Any Colour So Long as it's Black" - (http://oplaunch.com/blog/2015/04/30/the-truth-about-any-color-so-long-as-it-is-black/)
* [6] - Cloud Solutions Architect Salary - (https://www.payscale.com/research/US/Job=Cloud_Solutions_Architect/Salary)

<a name="costs"></a>
### Costs Appendix
What we mean by "expensive" may need some qualification. A typical enterprise has a portfolio of at least a few hundred applications that require some sort of hosting infrastructure. Frequently, these workloads are being pushed to cloud for a litany of reasons that are outside the scope of this post. In order to design, build, secure, operate, and monitor each application it requires certain skill sets which are broken down by the following table based on their market rates and timeshare for how long their skills are required. Not every organization has their teams structured like this as sometimes all the roles are being performed by a more or less persons however, it is representative of a typical enterprise team leaning more towards the "Custom Work" model for a small application with a few external integration requirements (e.g., connection to an on-prem database). 

<sup>Costs are in USD for mid-level U.S. based engineers.</sup>

|        Role         |    Task        | Salary     | Time Required | One Time Cost | Ongoing Cost (annually) |
|---------------------|----------------|------------|---------------|---------------|-------------------------|
| Solutions Architect | Design         |  $128k [6] | 3 weeks^      | $5k           |  $2.5k                  |
| Ops Engineer        | Build/Run      |  $100k     | 3 weeks^^     | $3.8k         |  $1.2k                  |
| Security            | Review/Monitor |  $120k     | 1 week^^^     | $1k           |  $1k                    |
|                     |                |            |               |               |                         |
|                     |                |            |  TOTAL        | $9.8k/app     |  $4.7k/app              |

> <sub>^ The architect gathers requirements from stakeholders, puts together drawings, prepares firewall requests, plans timelines, etc. Their time is usually spread across multiple projects which for a small application can equate to about two total weeks of focus time. You can also expect some feature enhancement, refactor, or other kind of follow up work in the near future which is covered by the Ongoing Cost estimate.</sub>
> 
> <sub>^^ The Ops Engineer builds the environment per spec from the architect and invariably has to make tweaks along the way based on reality which take up time. Also, they can expect to have ongoing time commitments due to outages, patching, etc. Initial build/deploy time can easily take a week and a few outages or patch windows can consume the remaining two weeks.</sub>
> 
> <sub>^^^ The security team can be expected to sign off on any designs, validating the use of new technologies, pushing back on requests, etc. which can take a few meetings per application. There are typically expected to build  monitoring infrastructure to validate security requirements on a continuous basis such as vulnerability scanning, liberal use of ports, key rotations, etc.)</sub>

While most of these numbers fairly represent small to medium sized applications they can vary greatly depending on the complexity of the application, how many integrations with other applications are required, the organization's maturity with the technologies requested in the architecture, etc. However, for the purposes of this demonstration let's just pretend this is an accurate average cost. So looking at this hypothetical three person team you can work out some macro statistics.

* Cost and Throughput of a 3-Engineer Cloud Team
  * Maximum Throughput (new projects annually) = 17 apps
  * Annual Cost (new projects) = $166k
  * Annual Maintenance (for 17 apps) = $80k/yr
