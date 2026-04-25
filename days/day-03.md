<div align="center">

# 🔐 Day 3 – AWS Shared Responsibility Model (Hands-On Lab)

*On Day 3 of my AWS Cloud journey, I completed a hands-on lab focused on the **AWS Shared Responsibility Model**. This model defines how security responsibilities are divided between **AWS (the provider)** and **the customer (the user)**.*

</div>

---

<br>

### 🎯 Lab Objective
To create a visual diagram that clearly separates:
- AWS responsibilities
- Customer responsibilities
- Shared controls

I also categorized real-world cloud security tasks to understand who is responsible for each.

<br>

---

<br>

### 🔐 Understanding the Model

**☁️ Security OF the Cloud (AWS Responsibility)**  
AWS is responsible for securing the **infrastructure that runs the cloud**, including:
- Physical data centers
- Hardware
- Networking
- Hypervisor (virtualization layer)

**🧑💻 Security IN the Cloud (Customer Responsibility)**  
Customers are responsible for securing **what they run in the cloud**, including:
- Data
- User access and permissions
- Operating systems (for EC2)
- Application security

<br>

---

<br>

### 📊 Categorisation of Responsibilities

**✅ AWS Responsibility**
- Physical server hardware  
- Data centre cooling & power  
- Network firewall between Availability Zones  
- Hypervisor (virtualisation layer)  
- Database backups (RDS – managed service)  

**👤 Customer Responsibility**
- EC2 operating system patches  
- S3 bucket access policy  
- IAM user passwords & MFA  
- Encrypting data stored in S3  
- Who can access AWS account  
- SSL certificate on web application  
- Database backups (MySQL on EC2)  

**🤝 Shared Controls**
- Patch management (AWS handles host, customer handles OS)  
- Configuration management  
- Security awareness training  

<br>

---

<br>

### ⚙️ Key Insight
The same task can have different responsibilities depending on the service used.

Example:
- RDS backups → AWS handles it  
- MySQL on EC2 → Customer handles it  

<br>

---

<br>

### 🧠 Plain Explanation (Non-Technical)
AWS takes care of the physical infrastructure like servers, buildings, and networking so you don’t have to worry about them.  
However, you are still responsible for protecting your data, managing who has access, and securing your applications.  
This is important because moving to the cloud does not remove your responsibility for security—it only changes it.

<br>

---

<br>

### 🛠️ What I Built
- A structured **diagram/table** showing AWS vs Customer vs Shared responsibilities  
- Categorised 12 real-world cloud security tasks  
- Created a simplified explanation for non-technical users  

<br>

---

<br>

### ⚠️ Key Takeaways
- Cloud security is a **shared responsibility**  
- AWS does NOT handle everything  
- Misconfiguration by customers is a major security risk  
- Understanding this model is critical for real-world cloud security  

<br>

---

## Lab Task Results

### Step 1: Explanation in Own Words
Provided an explanation of the core concept in my own words.

![Step 1](../Week-01/Day-03/Step%201-%20Explanation%20in%20Own%20Words.png)

---

### Step 2: Categorised all 12 items
Categorised the 12 cloud items into their respective areas.

![Step 2](../Week-01/Day-03/Step%202%20-%20Categorised%20all%2012%20items.png)

---

### Step 3: Built Diagram
Built a cloud architecture diagram based on requirements.

![Step 3](../Week-01/Day-03/Step%203%20-%20Built%20Diagram.png)

---

### Step 4: 3 sentence plain English explanation
Wrote a concise 3-sentence plain English explanation.

![Step 4](../Week-01/Day-03/Step%204%20-%203%20sentence%20plain%20English%20explanation.png)

---

### Bonus Challenge
Attempted the bonus challenge.

![Bonus Challenge](../Week-01/Day-03/Bonus%20Challenge%20attempted.png)

<br>

---

### 📅 Progress Tracker
- [x] **Day 3 Completed** ✅
