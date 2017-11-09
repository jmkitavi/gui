+++
title = "Mr Robot Ctf"
date = 2017-11-09T12:15:19+03:00
+++

This is my write up on the prgress with the MR. ROT 1 CTF. Haven't added the screenshots but they'll be coming up shortly together with more progress.

First, start with quick set up of both Kali Virtual Machine and Mr. Robot, both in Virtual Box.

Now let's get cracking…

 First do a quick network discovery to determine ip address of the server.

`nmap -sn 192.168.56.0/24`

<Image here>

Quick nmap host discovery without port scan to make it faster.

_-sn:_  tells nmap not to do a port scan after host discovery.

- I have 2 Virtual machines running, my Kali machine and the Server.
- Checked my Kali machine ip its 192.168.56.102
- So, my Server is at 192.168.56.101

Now, let's scan the server ip and see what services are running and open ports.

`nmap -sV 192.168.56.101`
 
<Image here>

_-sV:_ Scan host while checking version of services running.

3 services running:

- ssh on port 22
- http on port 80
- https on port 443

Let's load up the browser and check.Accessing the ip through the browser.

<Image here>

Performed a quick check to see if the site is a wordpress site.(it saves a lot of time)

https://192.168.56.101/wp-login

And boom there was a login page.

<Image here>

Tried some common password combinations but that didn't work.

Let's go on and do a quick Wordpress scan.

`wpscan 192.168.56.101`

Long output but here's some of it.

<Image here>

Lot' of data, but let's go for the low hanging fruits first.

http://192.168.56.101/robots.txt

I didn't really expect much there… may be a few hidden folders, but to my surprise.

**KEY-1-OF-3 !!!!!!!**

<Image here>

https://192.168.56.101/key-1-of-3.txt

<Image here>

At first I thought this was may be a clue or something. Tried using _findmyhash_ but that was a dead end.

Let's move on to the other clue in the robots.txt file… fsociety.dic

https://192.168.56.101/fsocity.dic

Opening it up, it looks like a wordlist for password or dictionaries or directories…

<Image here>

Bruteforcing a login form is not usually easy without a username, but for Wordpress that problem is solved a little bit because wordpress tells you if a user is existent or not even for a wrong login. See below… Invalid username.

<Image here>

So we can brute force the login and filter out the Invalid usernames and we will have valid usernames to bruteforce for the password.

What better tool to do that than Hydra.

`hydra -l fsocity.dic -p password 192.168.56101 http-post-form "/wp-login.php:log=^USER^&pwd=^PASS^&wp-submit=Log+In&redirect_to=http%3A%2F%2F192.168.56.101%2Fwp-admin%2F&testcookie=1:Invalid username" -f -V`

After the first run I realized it was taking soo long, at first I thought it was the wordlist that was wrong. But then I noticed that some of the names were repeated, so I decided to abort and check that.

<Image here>

- `wc -l fsocity.dic`
  - Word count for the fsocity.dic

- `sort -u fsocity.dic | wc -l`
  - sort uniquely and do a word count

**NB:** You notice the word count reduces significantly

- `sort -u fsocity.dic >> fsocity2.dic`
  - Create a new sorted file.


### To be Continued...
