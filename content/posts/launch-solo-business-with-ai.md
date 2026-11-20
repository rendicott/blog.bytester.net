---
title: "Can you launch a solo business with AI?"
date: 2026-11-20
---

In November 2025, two things happened: Opus 4.5 and OpenClaw. The former was the first model that shook my skepticism of the whole AI thing, and the second was giving the model shell and cron jobs.

Ever since, people have been saying you could run a business with just an agent—and I can definitely see how people could make that jump, but I figured it was more complicated than that. This is my journey in finding out.

I personally focused the first half of 2026 on AI stuff at work so I could secure my job for at least another 3-6 months, but I was dabbling in my personal life with OpenClaw and model API tokens. Let me first say that I could never get OpenClaw to work, but I was hooked on the potential. I wrote a harness from scratch at work and then when tokens got cheap enough, I [wrote](https://marble.bytester.net/) one at home too.

One thing that really bugged me was the lack of transparency in knowing what all my agents were doing. I had Claude TUI on a personal MacBook, Claude TUI on an old laptop, Grok TUI on a VPS, my own harness hitting various models and running cron, etc. I couldn't remember exactly where I kicked off some long refactor job or whether it was done or not. Also, I have three kids under 6 and work five days in the office. I can't sit at a laptop, so I do most personal tinkering from my phone over Tailscale. So I'm staring at this little tiny screen with Termius into a tmux session reading Claude output, which is awful.

I started wanting to build a mobile app—not to interact with agents directly, but to just collate end turns from all these other surface areas. It occurred to me that maybe I could run this as a service and then try out that "can you run a business with AI?" theory. There have to be at least a dozen other people in this world that are tinkerers with the same problem and might spend a buck or two a month to get control over agent communications. That's when I started building Orb.

## The LLC
So after I had some POC server-side code and a few client surfaces, I started getting worried about mixing too much personal machine access, code access, and finances. Mainly I kept reading that publishing apps to Android Play Store and iOS App Store would publish my home address if people looked up the developer and that would be annoying. It was time to start trying to separate things out. I went to my state's Secretary of State web portal and submitted for an LLC with myself as the sole owner and my home address for the business address.

> Note: Later, this would cause the agents to fret endlessly. But it turns out that the initial request for an LLC was not technically an "Annual Registration," so fixing it later did not require form CD 920, and it was simply fixed by filing the first official Annual Registration with the correct address.

After a couple of weeks, I got the email saying my LLC was created. I got a fancy watermarked PDF and then junk mail from workers' comp providers started arriving at my house.

Then I started asking my agents what it would actually take to ship apps and accept payments—Stripe, the Apple App Store, Google Play. Every answer came back with the same three prerequisites: an EIN, a D-U-N-S number, and an address that wasn't my house. I started with the EIN because it sounded like the one I could knock out in an afternoon.

## The EIN
It was absurdly simple to get an EIN. One web portal form that asked me to submit the Secretary of State letter. The hardest part was realizing that while every LLC on the planet has a comma in the name, the IRS will not accept commas. Apparently this is a known thing and everyone just drops the commas. It was so easy that I didn't even think to not put my home address. This comes back to cause distractions later.

## The Office
My agents tell me there are these businesses that all they do is provide addresses for LLCs just like mine. I needed one because the address that winds up in Dun & Bradstreet's database is the address Apple and Google believe, and a home address on that record reads as one guy with a laptop trying to scam the world—a fly-by-night operation.

I shopped around and they're all roughly the same price in my area at around $60/month, more if you add on extra services like phone answering. I picked one based on how close it was to my house instead of some fancy-sounding address, which turned out to be a good decision since I had to take more trips there than I expected.

The agents are worried sick about how I'm going to fill out the address on PS Form 1583 (to allow the office to receive LLC mail) and how that will have to line up with D-U-N-S. I fretted too, but in spite of all our worrying and our best efforts, the format of the suite number is different everywhere, but it turns out that nobody seems to care.

## Dun & Bradstreet
A D-U-N-S number was a thing I had no idea existed. Basically, there's this company called Dun & Bradstreet that tech companies use so they don't have to deal with every state's Secretary of State. They vet companies to make sure everything is copacetic and then give Apple and Google a single database of normalized information: business address, phone number, number of employees, etc.

We were worried about this one. The agents spoke of it with reverence and grew some more gray hairs fretting over `Suite 541` vs `#541`, but it was smooth sailing. Turns out D&B is eager to get your registration so they can try to sell you insurance, financing, and toilet paper for your business. D&B provided the requisite D-U-N-S number in a few days. In the end, D&B doesn't even list the suite number; they just dropped address line 2 entirely, gave us the D-U-N-S, and sent another spam email trying to sell us a credit card.

## The Bank
All of these incidental charges going to my personal credit card are going to be a PITA come tax time. Probably time to talk to the bank. I got a credit card via an online portal pretty easily, but when I tried to open a checking account via an online portal with Chase, it said there was some problem and I'd have to go to a branch. Sure. I stopped by one Friday afternoon and sat down and opened a Chase Business account. They were eager to help; if I recall, I was there for almost 2 hours while they were checking over everything and sorting out the linkage between the credit card and the new checking account. It was very awkward trying to explain the business and my expected revenue of $5/quarter from my buddy. For some reason, they gave me a checking account with a $2000 minimum balance requirement. Well, I guess that's better than putting it under a mattress...

So now the business can pay its own credit card, and the only thing I have to figure out is how to get money into the checking account.

## Stripe
It would be responsible to make this side project at least cover its own expenses, right? For that, we need to have a way to ~take~ accept people's money. There's a 99% chance that nobody will give us any money, but this business experiment would not be complete without it. The agents are in full panic mode that Stripe will demand an IRS letter 147C that proves the EIN is mapped to the business address. They make me fill out a form IRS 8822-B and send it by snail mail and set a 6-week cron timer to follow up before letting Stripe know we exist. I said "screw it" and opened the Stripe account after about 2 weeks of waiting. Turns out there are plenty of other verification methods that don't require a 147C. I still have no idea if the IRS ever updated the EIN address. I imagine my 8822-B to still be sitting in a mountain of mail in Kansas City somewhere.

## The Billing Model
This one took a lot of my brainpower, and no agent could help. I know as a human nerd that the chances of someone even trying the service, even if it's free, are slim to none. I don't want to pollute the world with another monthly subscription. I quite like the LLM token APIs—how you fund a balance and it's up to you how you spend it. I settled on a model like that where it's mostly free for personal and light business use, but if you want to get super organized or push excessive volume through the system,  $5-10 will cover you for a few months. So even at the extreme end, it's not going to hurt anyone. If by some miracle, 100 people fund a topic or pay for some extra Reach packs, it should cover the monthly business expenses.

Once I knew my model, I directed my agents to implement across all the code surfaces and then we finished setting up Stripe.

## The Apple Developer Account
This required D-U-N-S. That part was easy. The hard part was giving them the money for the $99 registration fee. Apparently my credit card with The Bank was too new and was declining the request from Apple. I guess that's a common fraud source (steal card and go buy an iPad). I had to physically go to the bank to finalize some Know Your Customer (KYC) forms, and while I was there, we got the fraud blocks removed. My banker was great. He made me pay Apple right there in front of him while Fraud Man was on the line, so we could be sure it worked.

Of course, once you have the Developer Account, it's certificate, notarization, GitHub Actions Secrets PEM upload hell, but the agents were able to figure all that out no problem.

## The App Stores
This was the most surprising force in the journey. Actually, almost everything done so far was setting up for app store stuff. Google Play and iOS App Store required D-U-N-S. The minefield of in-app payment rules and regulations drove the "Stripe via Web Inbox Only" model. The /terms endpoint on the site is a direct requirement by the app stores. The "Delete my account and data" features are all direct requirements from the app stores; the "Sign in with Apple" is a direct requirement from Apple for the App Store, etc. For this product where "notifications" is kind of the core value proposition, the app stores are unavoidable. Nothing to do but take your time and get the submissions right. Both were months of preparation, but were accepted on the first submission. One surprising difficulty was how you give a test account for the app reviewers to try your product. Since my product has no passwords, I had to create a dummy Gmail account and literally type the password in their forms. This is a tricky thing as I get push notifications on my phone where it says "Someone in Cupertino hacked your account!" and I don't know how sustainable this is because Google is already starting to throw up challenge codes when I tap "Yes, this was me, you made me get hacked!"

## Desktop Clients
macOS is actually the easiest of all the clients. As long as you notarize, you're golden. Windows was the most surprising in difficulty. When someone downloads your .exe, the browser screams malware. If the user clicks "don't care, download anyway," you can't even run the .exe without clicking the "yes, install this malware." Turns out this is all powered by SmartScreen and getting past it requires something called an OV or EV certificate. These are signing certificates provided by companies that vet your business and allow you to sign files as the LLC, and they are absurdly expensive. Many quote like $800/yr. Microsoft Azure has a really cheap version, but my agents warned that they only work for businesses with 3 years of history. Seeing as my LLC was formed 2 months ago, that's not going to work. I ended up going with SSL.com with a "Bring your own HSM" (basically YubiKey in the GCP cloud). You have to constantly decline their enhanced services and insist on "Bring your own HSM," which is a lot of email back and forth with "Chad from Sales," but in the end I got two years of signing for like $300. Of course, they actually vet the business. I had to go by The Office one afternoon so the SSL.com robocaller-vetter-bot could call with a verification code. Tracy from The Office kindly took the call and read me off the code. Thanks, Tracy. Windows users, you're welcome.

## Conclusion
The business is launched. This blog post may be the only value created from the entire journey, but if you were curious, the product is https://orbnet.app. I really like it; nobody else has to like it, and that's OK. It only took 3 months of my life and about $3500 to launch. The expenses are tolerable (about $200/month all in), so I can float it even if I have no customers. It's as battle-hardened as I can make it before there are real users, and my agents and I are committed to supporting our customers should they come.

I learned a lot about starting a business, and there were many "aha" moments along the way. Now I can see the "why" behind a lot of product decisions. For example, subscriptions are easier on taxes and legal, so it's no wonder why so many products default to them. It's harder to do a "top-up" model, but I think it's the better way for customers.

As far as answering the question of "Can you launch a solo business with AI?" I suppose the answer is "Yes," but there was a lot of "real-world" stuff and things that could not be done via API. Even though the agents wrote the code, the whole thing was a mountain of work and brainpower. Not for the faint of heart. I was prompting in the elevator, calling on lunch breaks, going to the post office on Saturday morning, buying used iPhones on eBay, fighting with passkey setups for the 23 accounts I had to open, tracking passwords, recovering passwords, clicking in portals that couldn't be agent-driven—the list goes on.

In the end, though, yeah, you can launch a business, it was fun, try it!

![Orb mobile app](/img/orb-mobile.png)
