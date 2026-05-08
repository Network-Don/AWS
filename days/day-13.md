<div align="center">

# 🛡️ Week 3 Day 3 – Configure Security Groups (Your VPC Firewall)

*On Day 3, I focused on implementing Security Groups (SGs) within my AWS VPC to control traffic at the instance level. This lab emphasized how AWS uses Security Groups as stateful virtual firewalls to regulate inbound and outbound traffic for resources such as EC2 instances, load balancers, and databases.*

*Building on previous networking concepts (subnets, route tables, IGW, NAT), this session introduced fine-grained access control—ensuring only the right traffic reaches the right resources.*

</div>

---

<br>

### 🌍 Why This Matters

Security Groups are one of the most critical layers of cloud security in AWS.

Without proper SG configuration:
- Your servers could be exposed to the internet
- Attackers could gain unauthorized access (e.g., open SSH)
- Databases could be publicly reachable (major risk)

In real-world cloud environments, misconfigured security groups are one of the leading causes of breaches.

<br>

---

<br>

### 🔑 Key Concepts

- **Security Group (SG)**: A virtual firewall attached to AWS resources
- **Stateful Firewall**: Automatically allows return traffic
- **Inbound Rules**: Control incoming traffic
- **Outbound Rules**: Control outgoing traffic
- **Security Group Chaining**: Referencing another SG instead of IP ranges
- **Least Privilege Access**: Only allow required traffic

**Security Groups vs NACLs**

| Feature | Security Groups | Network ACLs |
| :--- | :--- | :--- |
| **Level** | Instance level | Subnet level |
| **Type** | Stateful | Stateless |
| **Rules** | Allow only | Allow & Deny |
| **Evaluation** | All rules evaluated | Rules evaluated in order |
| **Use Case** | Fine-grained control | Broad subnet filtering |

<br>

---

<br>

### ⚙️ How It Works (Simple Explanation)

Think of Security Groups like security guards at different doors:
- The Load Balancer allows traffic from the internet (HTTP/HTTPS)
- The Web Servers only accept traffic from the Load Balancer
- The Database only accepts traffic from the Web Servers

Instead of opening everything, you control who can talk to who inside your network.

<br>

---

<br>

### ⚙️ Technical Insight

In this lab, I implemented a 3-tier architecture security model:

**1. SG-LoadBalancer**
Allows:
- HTTP (port 80) from `0.0.0.0/0`
- HTTPS (port 443) from `0.0.0.0/0`

**2. SG-WebServers**
Allows:
- HTTP (port 80) only from `SG-LoadBalancer`
- HTTPS (port 443) only from `SG-LoadBalancer`
- SSH (port 22) only from my IP

**3. SG-Database**
Allows:
- MySQL (port 3306) only from `SG-WebServers`
- No public access

🔗 **Security Group Chaining**

Instead of using IP addresses, I configured rules like:
- Source: `SG-LoadBalancer` → `SG-WebServers`
- Source: `SG-WebServers` → `SG-Database`

This ensures:
- Dynamic scaling works (new instances inherit access)
- No need to manage IP changes manually

🔄 **Stateful Behavior**

Security Groups are stateful, meaning:
- If inbound traffic is allowed → response traffic is automatically allowed
- No need to create separate outbound rules for return traffic

Example:
User sends HTTP request → allowed
Server response → automatically allowed

<br>

---

<br>

### 🌍 Real-World Scenario (Nigeria)

Imagine you're building a fintech platform in Lagos:
- Customers access your app via the internet → handled by **Load Balancer**
- App servers process transactions → **Web Servers**
- Sensitive financial data → stored in **Database**

With proper SG setup:
- Only the Load Balancer is exposed publicly
- Backend servers are hidden
- Database is completely private

This is exactly how companies like Flutterwave or Paystack design secure cloud architectures.

<br>

---

<br>

### ⚠️ Common Mistakes & Exam Traps

- ❌ Opening SSH (22) to `0.0.0.0/0`
- ❌ Allowing database access from anywhere
- ❌ Forgetting Security Groups are stateful
- ❌ Confusing SGs with NACLs
- ❌ Not using Security Group references (chaining)
- ❌ Leaving default outbound rules too permissive

<br>

---

<br>

### 📝 Practice / Lab Insight

During this lab, I successfully:

**Created and configured:**
- `SG-LoadBalancer`
- `SG-WebServers`
- `SG-Database`

**Implemented:**
- HTTP/HTTPS public access via Load Balancer
- SSH restricted to my IP
- MySQL access restricted to Web Servers only
- Zero internet exposure for database

**Applied:**
- Security Group chaining
- Least privilege principle
- Stateful firewall logic

All configurations were validated using connectivity tests and architecture review.

<br>

---

<br>

### 🧠 Reflection

This lab made me realize that networking is only half the job—security is the real backbone.

Before now, I used to think opening ports was enough. But now I understand:
- Who is accessing matters more than what port is open
- IP-based rules are fragile → SG referencing is better
- Security should be layered (SG + NACL + architecture design)

This is a mindset shift from “make it work” → “make it secure”.

<br>

---

<br>

### 🚀 Key Takeaways

- Security Groups act as instance-level firewalls
- Always follow least privilege access
- Use Security Group chaining instead of IPs
- Never expose databases to the internet
- Restrict SSH access to known IPs
- Understand stateful vs stateless filtering
- Combine SGs with proper architecture for maximum security

<br>

---

## Lab Task Results

### Step 1: SG-LoadBalancer created with the inbound rules
![Step 1](../Week-03/Day%2003/Step%201%20-%20SG-LoadBalancer%20created%20with%20the%20inbound%20rules.png)

---

### Step 2: SG-WebServers with port 80 from SG-LoadBalancer
![Step 2](../Week-03/Day%2003/Step%202%20-%20SG-WebServers%20with%20port%2080%20from%20SG-LoadBalancer.png)

---

### Step 3: SG-Database with port 3306 from SG-WebServers
![Step 3](../Week-03/Day%2003/Step%203%20-%20SG-Database%20with%20port%203306%20from%20SG-WebServers.png)

---

### Step 4: Security Group Architecture Diagram
![Step 4](../Week-03/Day%2003/Step%204%20-%20Security%20Group%20Architecture%20Diagram.png)

---

### Bonus Challenge: NACL created with rules
![Bonus Challenge](../Week-03/Day%2003/Bomus%20Challenge%20-%20NACL%20created%20with%20the%20rules.png)

<br>

---

### 📅 Progress Tracker
- [x] **Week 3 Day 3 Completed** ✅
