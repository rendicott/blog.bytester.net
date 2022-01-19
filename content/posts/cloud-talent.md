---
title: "The High Cost of Cloud Talent"
date: 2021-10-18
---

Talented cloud engineers are expensive and it's getting worse during the Great Resignation[1]. As more and more enterprise workloads move to cloud hosting it's approaching a tipping point where this could become a serious problem. This rising labor cost is threatening to undercut the "lower total cost of ownership" promises from cloud vendors and consultancy services which in turn could push decision makers towards cheaper, less secure options that are more expensive in the long run. Let's take at how we got here, the current challenges, and what some possible outcomes could be. 

> NOTE: While some of the information here is substantiated with references most of the contents are the author's opinion from working in the enterprise cloud space as an operations engineer, cloud devops engineer, operations manager, and architecture manager over the course of 5 years.
>  
> NOTE2: This is written from the perspective of a central'ish hosting organization performing cloud consulting and some high level operational support which is typical of many organizations. What is _not_ discussed in detail is the great range of skills that would be required of a developer embedded on an application team who has to also figure out how to build a CI/CD pipeline for the team (a.k.a, 10x DevOps Guru Person) of which there are probably only 10,000 in existence which is not enough to cover the needs of all the applications in the cloud. This elusive DevOps person's natural habitat is a startup environment and would quickly grow frustrated in a larger organization anyway.

## How We Got Here
It used to be that if you were a developer and you had some code you wanted to run you had to contact some central IT team and get some form of physical or virtual compute in order to run your code. This is probably via some form that asks you for your billing codes, desired cpu/ram/storage, and mother's maiden name. Then someone would get back to you in some number of weeks or months with clarifying questions and then a few more weeks/months go by and you might have a server. You'd be given an IP and SSH keys or something so you could log in and deploy your code. Whenever there was a problem with the OS/Hardware you could call some number and somebody would support you. If things got really bad you'd hear data center noises in the background of the call. In this world you could happily blame IT for all of your slowness problems and bemoan the hassle of your server going down for patching/upgrades, etc. but at the end of the day you had your domain and they had theirs and people could happily grumble their way through life as a house divided. Life was kind of crappy but at least you could blame someone else when something went wrong. 

Then came the cloud and out came the credit cards. Developers found out they could just spin up servers whenever they wanted and not be hassled by greybeards[2] for downtime and middle managers asking them for 2 year equipment lease commitments. This was a golden era of innovation where executives one-upped each other by comparing the number of production deployments per day at the company Christmas parties and problems could be solved instantly by "cross-functional teams" with on-prem rotations. Life was good for greenfield applications. The cloud was also starting to look attractive for legacy workloads where there were significant benefits such as cost-savings, flexibility (auto shutdown schedules anyone?), accurate inventory and billing in areas that were traditionally black-boxes. As more workloads moved to cloud the possibility of actually _closing data centers_ became realistic. This was the ultimate goal--no more lease agreements, no more contracts in far away places like Amsterdaam, no more need for local talent and foreign labor laws, no more steak dinners and purchase order foreplay with Dell and NetApp. The on-prem exodus was in full motion. Talented data center personnel saw the writing on the wall and quietly found new jobs. Server teams and grumpy greybeards were told "there's absolutely nothing to worry about" while their budgets shrunk and their headcount froze. "Keep the lights on" posters were mailed out to every location. 

This was also a lifeline for those forward thinking, talented infrastructure architects coming from the legacy space and devs with an interest in infrastructure because now they had Legos to play with and they could build literally anything they wanted via clicks/API's. When a product owner approaches them wringing their hands with an infrastructure problem looking for a solution it's now a _pleasure_ to solve and become an instant hero at the same time. Instead of an exercise in monotany and a bloated solution involving racks of hardware it's now a puzzle to find out how to solve their problem in the most clever way possible using the most non-standard solutions (as a bonus, now they can put "serverless" on their CV and get a new job with free snacks).  A bespoke solution at the lowest cost to solve exactly the right problem is a win-win for everyone, right?
 
However, some interesting things started happening in cloud land like S3 data breaches [3], entire teams leaving the company and leaving 900 EC2 instances running some unknown critical application, promises of massive savings through enterprise agreements and reserved instance purchases, and connections to the corporate network through DirectConnect/ExpressRoute. The borders were now threatened, entire towns were in need of federal aid, tax revenue was being lost and the Federal Marshals had to restore order to the Wild West. The great centralization effort began and it was time for Corporate to lay down the law. 

No longer was it OK to have warrantless public S3 buckets, wide open security groups, marketplace OS images from "hackme.ru", and credit cards funding accounts. There was a need for master payer agreements, governance policies, and account creation departments. This was generally agreed to be a good thing and a lot of the best cloud talent from the Wild West was hired into the central teams. The free love of the 60's had ended and now it was Reagan's War on Drugs--cloud was still pretty flexible but there are some pretty serious controls in place. Cowboys were devalued and some talent in the remote offices still saw the need to stick around and keep building infrastructure for their developers but a lot of them left to go someplace with more freedom--likely someplace earlier on in their cocaine infused cloud craze and cowboy[4] salaries.

This leaves us with some pretty talented central teams and a lot of disenfranchised sub-departments.  The idea is now that these central teams have "control" can help the departments out with all of their cloud needs which _seems_ reasonable as everything can be done in a browser and there's full visibility into all departments. Flexibility, however, can be a cruel mistress. Now we enter the modern age. 

# The Current Challenges
> cloud person[ kloud pur-suhn ]
> 
> _noun_, plural **cloud people**
> 1. a human being who is incapable of hosting an application on EC2 and insists on using serverless because they're religious beliefs do not allow them to deploy a sub-optimal solution
> 
Now we find ourselves with full control over a few hundred AWS accounts with a few thousand variations of infrastructure patterns. How do we maintain control while also fostering a culture of innovation? There are multiple approaches that are outside the scope of this discussion but no matter how you solve it you end up in one of the following situations:

* A large central team of cloud people with full control with a minority of application-aware sub-department cloud people with no power.
* A small central team with full control and a large number of application-aware sub-department cloud people with some power.


In either case your cloud people are going to have to get good at managing applications. After all, that's the whole point of cloud is to host some code that adds some sort of business value, right? This wouldn't be too much of a problem if everything looked the same--if it was all just boring EC2 instances with a sprinkling of RDS. However, while the people came for EC2, they stayed for lambda and life is complicated now. Now there's a predicament: you need smart people to manage the complexity of the platform _and_ the application. It's almost impossible to divorce a cloud-native application from the underlying infrastructure but since all the power has (justifiably) been taken away from the cowboys your new cloud people (the ones wearing collared shirts) have to get to know the applications _intimately_. This means the cloud person to application ratio is anywhere between 3:1 and 30:1 depending on a salary between $80k/yr and $200k/yr. Without some form of standardization, this leaves your per-application infrastructure talent cost somewhere between $7k and $26k. For an organization with 200 applications that's between $1.4 million/yr and $5.2 million/yr outside of your expected cloud bill, developer salaries, and administrative salaries. That's a pretty sobering number to be looking at after someone told you Cloud could solve all your problems. 

Of course, these numbers can be reduced via standardization but have you ever tried telling an application team they can't use anything except EC2? What the hell is the point of cloud if I can't use Cognito and ML!? What is the real cost-savings if all you're letting people use are things from the compute portfolio? And let's say you do manage to set an "EC2 Only" policy. Who is going to go out to an application team and tell them they have to go back in time to 2010 during their next outage window? What cloud-person (aka smart person) would tolerate being hamstrung with no chance of fluffing up their CV?

Even if you wanted to make a massive central department of cloud rockstars you're now trying to pull that talent in from the free market where they've been getting cowboy salaries for the past five years. How do you even pull cowboy talent into a role where they have to manage the infrastructure for thirty different applications? How do you fund their roles?

In many ways cloud people have brought this problem on themselves. When people came to them looking for solutions they were so enamoured by the possibility of building the best solution with their new shiny tools that they failed to play the tape forward and think to themselves "How am I going to manage 200 applications with 130 different architectures?". It's remeniscent of the history of automobile where in the beginning, every car was a custom job comissioned through a carriageworks. There were thousands of people claiming they could build the best automobile and it was a golden era of innovation and creativity. However, the costs were high and automobile was only available to the wealthy. Repairs and modifications could only be done by the manufacturer in many cases. Henry Ford is famously credited for bringing the automobile to the masses via standardization and automobiles had few options from the factory ("Any customer can have a car painted any colour that he wants so long as it is black" [5]). Manufacturers became bigger and bigger via acquisition and mergers until hardly anybody could tell the difference between a Civic and a Corolla. Exciting vehicles became a fringe movement. 

To shelve the analogy, the corporate cloud is in a phase where everything is still a custom job and Henry Ford hasn't come along yet. Cloud infrastructure is still pretty expensive because despite the Lego pieces being standard they are often put together in completely unique configurations. There is very little standard work which leads to a management conundrum and soaring costs. But what are our options? 

# Possible Outcomes
There are a few directions to go from here which all have their pros and cons.

* Keep building custom solutions and just pay more people well. 
  * Companies will have to figure out a comprehensive funding model to maintain central control. This would simply be a per-application fee to manage custom cloud configurations which would have to be around $10k/yr.  
* Standardize the work and make IT boring again. 
  * This will keep the per-application cost much lower but also stifle innovation. The hardest part will be finding cloud people who either aren't real cloud people or are cloud people who have been through hell and have the "thousand lambda stare".

I believe we're in an era where we all need to be driving our applications to work in Honda Civics and Ferrari's should be expensive to drive. 


## Reference
* [1] - Great Resignation (https://en.wikipedia.org/wiki/Great_Resignation)
* [2] - Greybeard Definition (https://gist.github.com/lenards/3739917#:~:text=greybeard-,Greybeard,use%20a%20remotely%20contemporary%20computer.)
* [3] - S3 Data Breaches - (https://businessinsights.bitdefender.com/worst-amazon-breaches)
* [4] - Cowboy Definition (https://en.wikipedia.org/wiki/Cowboy_coding)
* [5] - "Any Colour So Long as it's Black" - (http://oplaunch.com/blog/2015/04/30/the-truth-about-any-color-so-long-as-it-is-black/)
* [6] - Cloud Solutions Architect Salary - (https://www.payscale.com/research/US/Job=Cloud_Solutions_Architect/Salary)

### Costs Appendix
What we mean by "expensive" may need some qualification. A typical enterprise has a portfolio of at least a few hundred applications that require some sort of hosting infrastructure. Frequently, these workloads are being pushed to cloud for a litany of reasons that are outside the scope of this post. In order to design, build, secure, operate, and monitor each application it requires certain skill sets which are broken down by the following table based on their market rates and timeshare for how long their skills are required. Not every organization has their teams structured like this as sometimes all the roles are being performed by a more or less persons however, it is representative of a typical enterprise team for a small application with a few external integration requirements (e.g., connection to an on-prem database). 

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

* Maximum Throughput (new projects annually) = 17 apps
* Annual Cost (new projects) = $166k
* Annual Maintenance (for 17 apps) = $80k/yr
