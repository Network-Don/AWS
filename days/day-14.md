<div align="center">

# 🔐 Week 3 Day 4 – Bastion Hosts & Private Subnet Access (Hands-On Lab)

*On Week 3 Day 4 of my AWS Cloud journey, I implemented one of the most common real-world cloud security patterns — the Bastion Host architecture.*

*I launched a public EC2 Bastion Host, a private EC2 application server, and configured secure SSH access between them. This lab demonstrated how production environments securely access private infrastructure without exposing servers directly to the internet.*

</div>

---

<br>

### 🌍 Why This Matters

In real production systems, databases and internal application servers should never have public internet access.

Instead of exposing every server publicly:
- Engineers connect to a hardened public server (Bastion Host)
- Then securely “hop” into private resources

This is a core AWS networking and security concept heavily used in:
- FinTech
- Banking
- Enterprise cloud environments
- DevOps operations

👉 **Key insight:** Private infrastructure should remain inaccessible from the public internet.

<br>

---

<br>

### 🔑 Key Concepts

**🏰 Bastion Host**
A Bastion Host is a public EC2 instance used as a secure entry point into private subnets. It acts as:
- A jump server
- Controlled SSH gateway
- Secure administration layer

**🔒 Private Subnets**
Private subnets:
- Do NOT have public IP addresses
- Cannot be accessed directly from the internet
- Are typically used for: Databases, Internal applications, Backend services

**🔑 SSH Key Authentication**
I used a `.pem` key pair for secure SSH authentication between:
- My local machine → Bastion Host
- Bastion Host → Private EC2 instance

**🛡 Security Groups**
Security Groups controlled traffic flow:
- **Bastion Host:** Allowed SSH (Port 22) from my IP only
- **Private EC2:** Allowed SSH only from the Bastion Host Security Group

This created a secure layered access model.

<br>

---

<br>

### ⚙️ How It Works (Simple Explanation)

1. Launch Bastion Host in Public Subnet
2. Assign public IP address
3. Launch private EC2 in Private Subnet
4. Disable public IP on private server
5. SSH from local machine into Bastion Host
6. From Bastion Host, SSH into private server using private IP

👉 **Result:** The private server remained completely unreachable from the internet.

<br>

---

<br>

### 🧠 Technical Deep Dive

**Public vs Private Access**
The Bastion Host had:
- Public IP
- Internet Gateway route
- SSH access from my IP

The private EC2 instance had:
- No public IP
- No direct internet route
- SSH access only from Bastion SG

**Security Group Chaining**
Access was controlled through Security Group relationships:
`Internet` → `Bastion SG` → `Private Server SG`

This ensures:
- No open SSH to the world
- Controlled administrative access
- Reduced attack surface

**Professional Cleanup Practice**
After testing:
- I terminated both EC2 instances
- Prevented unnecessary AWS charges
- Maintained clean cloud resource management habits

<br>

---

<br>

### 🌍 Real-World Scenario (Nigeria)

A Nigerian fintech company hosts:
- Public APIs in public subnets
- Internal payment processors in private subnets
- Databases fully isolated from the internet

Cloud engineers:
- SSH into a Bastion Host
- Then securely access private infrastructure internally

This architecture protects sensitive financial systems from direct exposure.

<br>

---

<br>

### ⚠️ Common Mistakes & Exam Traps

- ❌ Assigning public IPs to private servers
- ✅ Private servers should remain isolated
- ❌ Allowing SSH from `0.0.0.0/0`
- ✅ Restrict SSH to your own IP only
- ❌ Exposing databases publicly
- ✅ Databases belong in private subnets
- ❌ Forgetting to terminate EC2 instances
- ✅ Always clean up lab resources after use

<br>

---

<br>

### 🧪 Bonus Challenge – AWS Systems Manager Session Manager vs Bastion Hosts

I researched AWS Systems Manager Session Manager, which is considered the modern replacement for Bastion Hosts.

**3 Key Advantages:**

**1️⃣ No SSH Ports Needed**
- No Port 22 exposure
- Reduces attack surface

**2️⃣ No Key Management**
- No `.pem` files required
- Access controlled via IAM roles

**3️⃣ No Bastion Host Required**
- Direct access to private EC2 via AWS Console/CLI
- Lower cost and simpler architecture

📌 **Summary:**
Session Manager is more secure, scalable, and operationally efficient than traditional bastion host setups because it removes SSH exposure, key handling, and extra infrastructure.

<br>

---

<br>

### 📝 Practice Question Insight

**Correct Answer:**
✅ A Bastion Host allows secure administrative access to private subnet resources without exposing them directly to the internet.

<br>

---

<br>

### 🧠 Reflection

Today, I learned how secure access to private cloud infrastructure is implemented in real AWS environments.

What stood out to me most was how the Bastion Host acts as a controlled gateway into private resources while keeping sensitive systems hidden from the public internet.

I also learned that AWS Systems Manager Session Manager is becoming the preferred modern alternative because it removes the need for open SSH ports and key pair management.

<br>

---

<br>

### 🚀 Key Takeaways

- Bastion Hosts secure access to private EC2 instances
- Private subnets should not expose public IPs
- Security Groups enforce layered access control
- SSH access should always be tightly restricted
- Session Manager is a modern alternative to Bastion Hosts
- Always terminate unused EC2 resources to avoid charges

<br>

---

## Lab Task Results

### Step 1: EC2 console showing both instances running
![Step 1](../Week-03/Day%2004/Step%201%20-%20EC2%20console%20showing%20both%20instances%20running.png)

---

### Step 2: Successful SSH connection to Bastion Host
![Step 2](../Week-03/Day%2004/Step%202%20-%20Successful%20SSH%20connection%20to%20Bastion%20Host.png)

---

### Step 3: Successful SSH hop from bastion to private instance
![Step 3](../Week-03/Day%2004/Step%203%20-%20Successful%20SSH%20hop%20from%20bastion%20to%20private%20instance.png)

---

### Step 4: EC2 instances terminated
![Step 4](../Week-03/Day%2004/Step%204%20-%20EC2%20instances%20terminated.png)

<br>

---

<br>

### 📅 Progress Tracker
- [x] **Week 3 Day 4 Completed** ✅
