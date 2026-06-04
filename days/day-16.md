<div align="center">

# ☁️ Week 4 · Day 1 — EC2 Introduction & Launch

*On Week 4 Day 1 of my AWS Cloud journey, I learned the core concepts of Amazon Elastic Compute Cloud (EC2) and successfully launched my first virtual server in the cloud.*

*I also created a custom web server by injecting a User Data script during the instance launch, connected to my instance securely via SSH, explored the Instance Metadata Service (IMDS), and finally learned the importance of terminating unused instances to avoid unexpected billing.*

</div>

---

<br>

### 🌍 Why This Matters

Virtually every business migrating to the cloud starts with computing power. Amazon EC2 is the backbone of AWS computing.

Organizations use EC2 for:
- Hosting web applications and blogs
- Running enterprise databases
- Processing massive datasets
- Creating testing and development environments

👉 **Key insight:** Understanding how to correctly provision, secure, and manage EC2 instances is a fundamental skill for any Cloud Engineer. Misconfiguring security groups or failing to terminate unused instances can lead to security breaches or massive unexpected bills.

<br>

---

<br>

### 🔑 Key Concepts

**🖥️ EC2 (Elastic Compute Cloud)**
EC2 is AWS's flagship virtual server service. It provides resizable compute capacity in the cloud, allowing you to launch servers in minutes rather than waiting weeks for physical hardware.

**💿 Amazon Machine Image (AMI)**
An AMI provides the information required to launch an instance. Amazon Linux 2 is a commonly used, highly optimized Linux AMI provided by AWS, which I used for this lab.

**🛡️ Security Groups**
Security Groups act as stateful virtual firewalls for your EC2 instances. They control inbound and outbound traffic. In this lab, I opened HTTP (80) to the world and SSH (22) restricted only to my IP address for security.

**📜 User Data**
User Data allows you to automate software installation and configuration scripts that run automatically when the instance boots up for the very first time. I used this to install and start the Apache web server (httpd) without manual intervention.

**📡 Instance Metadata Service (IMDS)**
IMDS is an endpoint that allows running EC2 instances to retrieve data about themselves dynamically (like their instance-id, public-ipv4, and IAM roles) without needing to use the AWS Console.

<br>

---

<br>

### ⚙️ How It Works (Simple Explanation)

To make a web server accessible to the world, several components must work together:
1. **Public Subnet + IGW:** The instance must be placed in a public subnet with a Route Table pointing to an Internet Gateway (IGW) to enable internet access.
2. **Public IP Address:** The instance requires a Public IP address to be reachable from the internet.
3. **Security Group:** The firewall must allow inbound web traffic (Port 80) and secure remote administration traffic (Port 22).
4. **Web Server Software:** Software like Apache (httpd) must be installed and running to serve the HTML pages to the browser.

<br>

---

<br>

### 🧠 Technical Deep Dive

**Secure Remote Administration (SSH)**
SSH (Secure Shell) provides a secure, encrypted connection to manage your EC2 instances remotely. It requires a private key pair (`.pem` file). Best practice dictates never opening Port 22 to `0.0.0.0/0` (the entire internet), but rather restricting it to your specific IP address to prevent brute-force attacks.

**Bootstrapping with User Data**
By passing a bash script into the EC2 User Data field:
```bash
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Hello from my AWS Web Server!</h1>" > /var/www/html/index.html
```
The instance boots up fully configured. This is the first step toward Infrastructure as Code (IaC) and automation.

**Terminating vs. Stopping Instances**
- **Stopping** an instance shuts it down, but you still pay for the attached EBS storage.
- **Terminating** an instance permanently deletes it and prevents any unexpected billing. Always terminate lab instances when finished!

<br>

---

<br>

### 🏗️ Architecture & Visual Model

1. **User** accesses the **Public IP** via a web browser (HTTP over Port 80).
2. The request hits the **Security Group (SG-WebLab)**, which permits the traffic.
3. The traffic routes through the **Internet Gateway** into the **Public-Subnet-AZ-A** inside the **OluTech-Production-VPC**.
4. The **EC2 Instance (Web-Server-Lab)** processes the request using the installed **Apache (httpd)** service.
5. The custom `index.html` page (created via **User Data**) is returned to the user's browser.
6. The Cloud Administrator connects securely via **SSH (Port 22)** using a `.pem` key to manage the server.

<br>

---

<br>

### 🌍 Real-World Scenario (Nigeria)

A fast-growing e-commerce startup in Lagos, Nigeria, is preparing for a massive "Black Friday" sale.

**Requirements:**
- They need a reliable server to host their new marketing landing page.
- The server must be accessible to customers nationwide.
- The IT team needs secure administrative access from their Lagos office only.

**Solution:**
- They launch an **EC2 instance** using an **Amazon Linux 2 AMI**.
- They configure a **Security Group** allowing HTTP (80) from anywhere for customers, and SSH (22) restricted solely to their Lagos office IP address.
- They use an **EC2 User Data** script to automatically install the web server and load the Black Friday HTML content upon launch.
- After the promotional period ends, they **terminate** the instance to save costs.

👉 This scalable, cost-effective approach ensures they can handle the traffic and pay only for what they use.

<br>

---

<br>

### ⚠️ Common Mistakes & Exam Traps

- ❌ Opening SSH (Port 22) to `0.0.0.0/0` (everyone).
- ✅ ALWAYS restrict SSH to your specific IP address or a known corporate IP range.
- ❌ Forgetting to assign a Public IP address to a web server.
- ✅ Enable auto-assign public IP during launch, or attach an Elastic IP later.
- ❌ Thinking an instance in a private subnet can be reached directly from the internet.
- ✅ Only instances in public subnets (with an IGW and route tables) can be accessed directly.
- ❌ Leaving unused instances running or just "stopped".
- ✅ Terminate unused instances to completely avoid EC2 and EBS storage charges.

<br>

---

<br>

### 📝 Practice Question Insight

**Correct Answer:**
✅ Restrict Security Group inbound rules for Port 22 to the administrator's specific IP address.

**Why?**
Security Groups are stateful firewalls. Opening Port 22 to `0.0.0.0/0` exposes the instance to global brute-force attacks. Restricting it to a known IP is an AWS security best practice and a frequent exam topic.

<br>

---

<br>

### 🧠 Reflection

Today, I finally moved from networking infrastructure to actual compute power. Launching my first EC2 instance was exciting!

What stood out to me most was the power of the User Data script. Instead of launching a blank server, manually connecting to it, and typing commands one by one, the server was fully functional and hosting a webpage the moment it booted up. This automation mindset is incredibly powerful.

I also found exploring the Instance Metadata Service (IMDS) fascinating. Being able to query the server's own information dynamically from within the terminal (`curl http://169.254.169.254/latest/meta-data/`) showed me how applications can be made to adapt to their environment automatically.

<br>

---

<br>

### 🚀 Key Takeaways

- EC2 provides flexible, scalable virtual servers in the cloud.
- Amazon Linux 2 is an optimized OS choice for AWS workloads.
- Security Groups are stateful firewalls controlling instance traffic.
- User Data scripts automate software installation during the first boot.
- IMDS allows instances to securely retrieve their own metadata.
- Terminating lab instances is critical to prevent unexpected billing.

<br>

---

<br>

## Lab Task Results

### Step 1: EC2 console showing instance in Running state with public IP
![Step 1](../Week-04/Day%2001/Step%201%20-%20EC2%20console%20showing%20instance%20in%20Running%20state%20with%20public%20IP.png)

---

### Step 2: SSH connection successful
![Step 2](../Week-04/Day%2001/Step%202%20-%20SSH%20connection%20successful.png)

---

### Step 3: Apache httpd service showing active (running)
![Step 3](../Week-04/Day%2001/Step%203%20-%20Apache%20httpd%20service%20showing%20active%20%28running%29.png)

---

### Step 4: Browser showing my webpage
![Step 4](../Week-04/Day%2001/Step%204%20-%20Browser%20showing%20my%20webpage.png)

---

### Step 5: Instance metadata showing instance-id and public-ip
![Step 5](../Week-04/Day%2001/Step%205%20-%20Instance%20metadata%20showing%20instance-id%20and%20public-ip.png)

---

### Bonus Challenge: Second page added to my website
![Bonus Challenge](../Week-04/Day%2001/Bonus%20Challenge%20-%20Second%20page%20added%20to%20my%20website.png)

<br>

---

<br>

### 📅 Progress Tracker
- [x] **Week 4 Day 1 Completed** ✅

---

<div align="center">

| [« Previous Day: VPC Connectivity & Enterprise Network Architecture](./day-15.md) | [Next Day: EC2 Instance Types & AMIs](./day-17.md) » |
| :---: | :---: |

</div>
