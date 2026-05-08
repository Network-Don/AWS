<div align="center">

# 🌐 Week 3 Day 2 – Subnets: Public vs Private

*On Week 3 Day 2 of my AWS Cloud journey, I learned how subnet design and route tables determine whether AWS resources are public, private, or fully isolated.*

*I also completed a hands-on networking lab where I attached an Internet Gateway to my custom VPC, created public route tables, associated subnets correctly, and visualized traffic flow inside the architecture.*

*This lesson made AWS networking much clearer.*

</div>

---

<br>

### 🌍 Why This Matters

The subnet architecture of a cloud environment directly impacts:

- Security
- Internet exposure
- Compliance
- Availability
- Application design

A single routing mistake can accidentally expose sensitive systems to the internet.

👉 Key insight:
**A subnet is NOT public because of its name.**
It becomes public only when its route table contains:
`0.0.0.0/0 → Internet Gateway`

<br>

---

<br>

### 🔑 Key Concepts

**🌐 Public Subnet**
- A subnet with a route to an Internet Gateway.
- Used for: Load balancers, Bastion hosts, NAT Gateways

**🔒 Private Subnet**
- A subnet with NO direct Internet Gateway route.
- Used for: Application servers, Databases, Internal services

**🚪 Internet Gateway (IGW)**
- Enables communication between a VPC and the public internet.

**🧭 Route Tables**
- Control how traffic flows inside and outside the VPC.
- Routing determines whether a subnet is public or private.

**📡 NAT Gateway**
- Allows private subnet resources to access the internet outbound only.

**🧮 Reserved IP Addresses**
- AWS reserves 5 IP addresses in every subnet.
- Example: `/24` subnet = 256 total IPs, Only 251 usable.

<br>

---

<br>

### ⚙️ How It Works (Simple Explanation)

1. Create an Internet Gateway
2. Attach it to the VPC
3. Create a public route table
4. Add route: `0.0.0.0/0 → IGW`
5. Associate public subnets with that route table
6. Leave private subnets without internet routes

👉 This creates network isolation.

<br>

---

<br>

### ⚙️ Technical Insight

**Internet Gateway Attached**

Created and attached: `OluTech-IGW` to `OluTech-Production-VPC`

**Public Route Table**

Created: `Public-Route-Table`

Routes:
- `10.0.0.0/16 → local`
- `0.0.0.0/0 → IGW`

**Public Subnets**

Associated:
- `Public-Subnet-AZ-A`
- `Public-Subnet-AZ-B`

Enabled: Auto-assign public IPv4

**Private Subnets**

Private subnets remained associated with the main route table containing only:
- `10.0.0.0/16 → local`

👉 No direct internet path exists.

**Traffic Flow Architecture**

Traffic path designed:
Internet User → Internet Gateway → Public Subnet → Web Tier → Private App Tier → Database Tier

<br>

---

<br>

### 🌍 Real-World Scenario (Nigeria)

A Nigerian fintech platform processing payments may:

- Place load balancers in public subnets
- Keep payment APIs in private subnets
- Store customer financial data in isolated database subnets

This architecture helps meet compliance requirements from regulators like:
- CBN
- SEC

while improving security and resilience.

<br>

---

<br>

### ⚠️ Common Mistakes & Exam Traps

- ❌ Thinking subnet names define public/private
  ✅ Route tables determine subnet type
- ❌ Believing Security Groups alone make a subnet private
  ✅ Internet routes must also be removed
- ❌ Forgetting subnets are AZ-specific
  ✅ A subnet exists in only ONE AZ
- ❌ Using default VPCs for production
  ✅ Default VPC subnets are public by default
- ❌ Forgetting AWS reserves 5 IPs per subnet
  ✅ Always calculate usable IPs correctly

<br>

---

<br>

### 📝 Practice Question Insight

Correct Answers:

✅ Data tier should use a route table with only the local VPC route.

✅ Application tier should use private subnets with NAT Gateway outbound access only.

<br>

---

<br>

### 🧠 Reflection

Today, I learned that routing is what truly controls network exposure in AWS.

What stood out to me most was understanding that a subnet can look “private” but still be public if its route table points to an Internet Gateway.

Building the traffic flow manually made AWS networking architecture much easier to understand.

<br>

---

<br>

### 🚀 Key Takeaways

- Route tables define subnet behavior
- Public subnet = IGW route exists
- Private subnet = no IGW route
- NAT Gateway provides outbound-only internet access
- Subnets are tied to one Availability Zone
- Network architecture directly affects security and compliance

<br>

---

## Lab Task Results

### Step 1: Internet Gateway attached to VPC
![Step 1](../Week-03/Day%2002/Step%201%20-%20Internet%20Gateway%20atached%20to%20VPC.png)

---

### Step 2: Public Route Table showing local route + 0.0.0.0/0 → IGW
![Step 2](../Week-03/Day%2002/Step%202%20-%20Public%20Route%20Table%20showing%20local%20route%20+%200.0.0.00%20→%20IGW.png)

---

### Step 3: Public subnets associated with Public Route Table
![Step 3](../Week-03/Day%2002/Step%203%20-%20Public%20subnets%20associated%20with%20Public%20Route%20Table.png)

---

### Step 4: Private subnets associated with main route table (local route only)
![Step 4](../Week-03/Day%2002/Step%204%20-%20Private%20subnets%20associated%20with%20main%20route%20table%20(local%20route%20only).png)

---

### Bonus Challenge: NAT Gateway Configuration

![Bonus Challenge 1](../Week-03/Day%2002/Bonus%20Challenge%201%20-%20NAT%20Gateway%20created.png)

![Bonus Challenge 2](../Week-03/Day%2002/Bonus%20Challenge%202%20-%20Add%20a%20route%20in%20the%20private%20route%20table%200.0.0.00%20→%20NAT%20Gateway..png)

**🌐 Internet Gateway (IGW)**
- **Used by**: Public Subnets
- **Traffic**:
  - Inbound ✅
  - Outbound ✅
- **Resources**: Can be publicly accessed

**🔒 NAT Gateway**
- **Used by**: Private Subnets
- **Traffic**:
  - Outbound ✅
  - Inbound ❌
- **Resources**: NOT publicly accessible

**🧠 Simple Way to Explain It**
- **IGW** exposes resources to the internet
- **NAT Gateway** hides resources but still lets them access the internet

**🎯 What This Enables**
With NAT, your private servers can now:
- Install updates (apt, yum, Windows Update)
- Pull Docker images
- Call external APIs
- Download packages

WITHOUT:
- Having a public IP
- Being exposed to attacks

<br>

---

### 📅 Progress Tracker
- [x] **Week 3 Day 2 Completed** ✅
