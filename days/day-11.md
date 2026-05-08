<div align="center">

# 🌐 Week 3 Day 1 – VPC Fundamentals

*On Week 3 Day 1 of my AWS Cloud journey, I learned the fundamentals of Amazon VPC (Virtual Private Cloud) and how networking forms the foundation of every AWS architecture.*

*I also completed a practical lab where I built a custom production-style VPC with public and private subnets spread across multiple Availability Zones.*

*This was my first real exposure to AWS networking architecture.*

</div>

---

<br>

### 🌍 Why This Matters

Every AWS service runs inside a network.

Without understanding VPCs, it becomes difficult to design:

- Secure applications
- Private databases
- Internet connectivity
- High availability systems
- Production-ready architectures

👉 Key insight:
**VPC is the networking foundation of AWS.**

<br>

---

<br>

### 🔑 Key Concepts

**🌐 VPC (Virtual Private Cloud)**
- A logically isolated network inside AWS.

**🧮 CIDR Block**
- Defines the IP address range of the VPC.
- Example: `10.0.0.0/16`

**🧩 Subnets**
- Smaller network sections inside a VPC.
- Types:
  - Public subnet
  - Private subnet

**🚪 Internet Gateway (IGW)**
- Allows communication between a VPC and the internet.

**🔄 NAT Gateway**
- Allows private subnet resources to access the internet outbound only.

**🛡 Security Groups vs NACLs**
- Security Groups → Stateful
- NACLs → Stateless

One of the most tested AWS networking concepts.

<br>

---

<br>

### ⚙️ How It Works (Simple Explanation)

1. Create a VPC with a CIDR block
2. Create public and private subnets
3. Spread subnets across multiple AZs
4. Configure routing
5. Attach an Internet Gateway
6. Use NAT Gateway for private outbound access

<br>

---

<br>

### ⚙️ Technical Insight

**Custom VPC Created**

VPC Name: `OluTech-Production-VPC`

CIDR: `10.0.0.0/16`

**Subnets Built**

*Public Subnets*
- `10.0.1.0/24`
- `10.0.2.0/24`

Used for: Web servers, Load balancers

*Private Subnets*
- `10.0.10.0/24`
- `10.0.20.0/24`

Used for: Application servers, Databases

**Availability Zones**

Distributed across:
- AZ-A
- AZ-B

👉 Improves high availability and resilience.

**Public IP Configuration**

- Enabled auto-assign public IPv4 only on public subnets.
- Private subnets remained isolated.

<br>

---

<br>

### 🌍 Real-World Scenario (Nigeria)

A Nigerian fintech platform handling customer payments may place:

- Load balancers in public subnets
- APIs in private subnets
- Databases in isolated private subnets

This helps meet compliance and security requirements while keeping systems highly available.

<br>

---

<br>

### ⚠️ Common Mistakes & Exam Traps

- ❌ Thinking subnet names determine public/private
  ✅ Route tables determine that
- ❌ Confusing Security Groups with NACLs
  ✅ SG = Stateful, NACL = Stateless
- ❌ Using public subnets for databases
  ✅ Databases should stay private
- ❌ Assuming NAT Gateway allows inbound traffic
  ✅ NAT is outbound only
- ❌ Forgetting subnets are AZ-specific
  ✅ VPC spans Region, subnet spans one AZ only

<br>

---

<br>

### 📝 Practice Question Insight

Correct Answers:

✅ Place EC2 instances in private subnets with a NAT Gateway for outbound internet access.

✅ Use a public-facing Application Load Balancer to route traffic securely.

<br>

---

<br>

### 🧠 Reflection

Today, I learned that networking is one of the most important parts of cloud architecture.

What stood out to me was understanding how public and private subnets work together to create secure production environments.

Designing the VPC manually also helped me understand how AWS networking components connect.

<br>

---

<br>

### 🚀 Key Takeaways

- VPC is the foundation of AWS networking
- CIDR controls IP allocation
- Public vs private depends on routing
- NAT Gateway provides outbound internet only
- High availability requires multiple AZs
- Networking design impacts security and resilience

<br>

---

## Lab Task Results

### Step 1: VPC showing OluTech
![Step 1](../Week-03/Day%2001/Step%201%20-%20VPC%20showing%20OluTech.png)

---

### Step 2: The 4 subnets with correct CIDRs
![Step 2](../Week-03/Day%2001/Step%202%20-%20The%204%20subnets%20with%20correct%20CIDRs.png)

---

### Step 3: Public Subnet with auto-assign public IP enabled
![Step 3](../Week-03/Day%2001/Step%203%20-%20Public%20Subnet%20with%20auto-assign%20public%20IP%20enabled.png)

---

### Step 4: VPC Architecture Diagram
Built a custom production-style VPC with:
- 1 VPC
- 4 subnets
- Multi-AZ design
- Public/private segmentation

![Step 4](../Week-03/Day%2001/Step%204%20-%20VPC%20Architecture%20Diagram.png)

---

### Bonus Challenge: Default VPC vs Custom VPC
![Bonus Challenge](../Week-03/Day%2001/Bonus%20Challenge%20-%20Default%20VPC.png)

**📌 Default VPC vs Custom VPC**

**🖼️ Default VPC**

**🔍 Key Differences**
* **CIDR Block**
  * Default: `172.31.0.0/16` (auto-assigned)
  * Custom: `10.0.0.0/16` (manually defined)
* **Subnets**
  * Default: Auto-created, all public
  * Custom: Manually created (public & private)
* **Internet Access**
  * Default: Enabled by default
  * Custom: Must be configured
* **Route Tables**
  * Default: Preconfigured (internet access included)
  * Custom: Fully manual control
* **Security Design**
  * Default: Flat network, no isolation
  * Custom: Segmented (web, app, DB layers)

**⚠️ Why Not Use Default VPC in Production?**
* No network segmentation
* Higher risk of public exposure
* Limited control over architecture
* Not aligned with security best practices

**✅ Takeaway**
* Default VPC: Good for testing
* Custom VPC: Required for secure, production environments

<br>

---

### 📅 Progress Tracker
- [x] **Week 3 Day 1 Completed** ✅
