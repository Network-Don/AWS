<div align="center">

# 🔐 Day 5 – IAM & Account Security Setup (Theory)

*On Day 5 of my AWS Cloud journey, I learned about IAM (Identity and Access Management) and how to properly secure an AWS account from day one. This topic covers how to control who can access AWS resources, what they can do, and how to prevent costly or dangerous mistakes.*

</div>

---

<br>

### 🌍 Why This Matters
Your AWS account is like the root of your entire cloud infrastructure — if it’s not secured properly, everything is at risk.

A very common beginner mistake is leaving resources running or mismanaging access, which can lead to unexpected bills or security breaches.

👉 Key insight:
Security and cost control start with proper account setup — not later.

<br>

---

<br>

### 🔑 Key Concepts

**🖥 AWS Management Console**
- Web interface for managing AWS
- Accessible via browser
- Central hub for all services

**🌍 AWS Region Selector**
- Resources are region-specific
- Always confirm your region before creating anything
- IAM & Billing are global services

**💰 AWS Budgets**
- Set cost or usage limits
- Get alerts at thresholds (e.g., 50%, 80%, 100%)
- Helps prevent overspending

**📊 AWS Cost Explorer**
- Visual tool for tracking spending
- Forecast future costs
- Analyze usage by service

**🔔 CloudWatch Billing Alarms**
- Trigger alerts when spending exceeds a threshold
- Example: alert when cost > $5
- Acts as your early warning system

<br>

---

<br>

### ⚙️ How It Works (Simple Explanation)
- You log into the AWS Console
- You select a region before creating resources
- You configure billing alerts (CloudWatch / Budgets)
- You manage access using IAM users, roles, and policies

<br>

---

<br>

### ⚙️ Technical Insight

**IAM Identities**
- Root User → Full access (never use daily)
- IAM Users → Individual accounts
- IAM Groups → Manage permissions for multiple users
- IAM Roles → Temporary access for services (e.g., EC2)

**IAM Policies**
- JSON documents defining permissions
- Structure:
  - Effect (Allow/Deny)
  - Action (e.g., s3:GetObject)
  - Resource (specific or *)

**Security Best Practices**
- Enable MFA (Multi-Factor Authentication)
- Use least privilege principle
- Avoid using root account
- Assign permissions via groups, not individually

**Reality Check**
- Root account = unlimited power → dangerous if exposed
- No billing alerts = surprise charges
- Poor IAM setup = security vulnerabilities

<br>

---

<br>

### 🌍 Real-World Scenario (Nigeria)
A student in Lagos launches an EC2 instance for practice but forgets to stop it.

- No billing alert set
- Instance runs for days
- Unexpected charge appears (~$40+)

**With Proper Setup:**
- $5 billing alarm triggers early
- Student gets notified within days
- Instance is stopped immediately

👉 Result: Problem avoided before it becomes expensive

<br>

---

<br>

### ⚠️ Common Mistakes & Exam Traps
- ❌ Using root account for daily tasks
  ✅ Use IAM users instead
- ❌ Not enabling MFA
  ✅ Always enable MFA (especially for root)
- ❌ Creating billing alarms in wrong region
  ✅ Billing data only in us-east-1
- ❌ Assigning permissions directly to users
  ✅ Use groups for better management
- ❌ Thinking IAM setup can wait
  ✅ It should be done immediately

<br>

---

<br>

### 📝 Practice Question Insight
Correct Answer:
✅ Enable MFA on the root account and avoid using it for daily tasks

<br>

---

<br>

### 🧠 Reflection
Today, I learned that AWS security starts immediately after account creation, not later.

What stood out to me is how simple habits like enabling MFA and setting billing alerts can prevent major issues.

This made me realize that being a cloud engineer is not just about building systems, but also about protecting them from day one.

<br>

---

<br>

### 🚀 Key Takeaways
- IAM controls who can access what
- Never use the root account for daily tasks
- Always enable MFA
- Billing alerts are essential
- Use least privilege for security

<br>

---

## Lab Task Results

### Step 1: IAM Dashboard
Explored the IAM Dashboard to view security status.

![Step 1](../Week-01/Day-05/Step%201%20-%20IAM%20Dahsboard.png)

---

### Step 2: New IAM User
Created a new IAM user with specific permissions.

![Step 2](../Week-01/Day-05/Step%202%20-%20New%20IAM%20User.png)

---

### Step 3: Console Sign-in as IAM User
Signed into the AWS Management Console as the newly created IAM user.

![Step 3](../Week-01/Day-05/Step%203%20-%20Console%20Sign-in%20as%20IAM%20User.png)

---

### Step 4: IAM Security Recommendations
Reviewed and applied IAM security recommendations.

![Step 4](../Week-01/Day-05/Step%204%20-%20IAM%20Security%20Recommendations.png)

---

### Bonus Challenge
Attempted to access resources not allowed by ReadOnlyAccess policy, confirming access was denied.

![Bonus Challenge](../Week-01/Day-05/Bonus%20Challenge%20Attempted%20-%20ReadOnlyAccess%20denied.png)

<br>

---

### 📅 Progress Tracker
- [x] **Day 5 Completed** ✅
