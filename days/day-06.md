<div align="center">

# 🔐 Week 2 Day 1 – IAM Deep Dive: Users, Groups & Roles

*On Week 2 Day 1 of my AWS Cloud journey, I went deeper into **AWS Identity and Access Management (IAM)** by learning how real teams manage permissions using **users, groups, roles, and policies**.*

*I also completed a practical lab where I built a simulated 3-person team structure and tested real access boundaries.*

*This topic is critical for both **AWS Solutions Architect Associate (SAA-C03)** and real-world cloud security.*

</div>

---

<br>

### 🌍 Why This Matters

In AWS, security is not just about passwords — it is about controlling **who can access what**.

Poor IAM design can lead to:

- Overprivileged users
- Data leaks
- Unauthorized actions
- Security incidents

Well-designed IAM structures use **least privilege**, meaning users only get the permissions they need.

👉 Key insight:
**Strong cloud security starts with proper IAM design.**

<br>

---

<br>

### 🔑 Key Concepts

**👤 IAM Users**
- Individual identities for people or applications.
- Examples: Developer account, Analyst account, Manager account

**👥 IAM Groups**
- Collections of users with shared permissions.
- Examples: Developers Group, Analysts Group, Managers Group

**🎭 IAM Roles**
- Temporary permissions assumed by AWS services or users.
- Example: An EC2 instance using a role to access S3 securely.

**📜 IAM Policies**
- JSON permission documents that define:
  - Effect (Allow / Deny)
  - Action
  - Resource

**🛡 Least Privilege Principle**
- Always grant only the minimum permissions required.

<br>

---

<br>

### ⚙️ How It Works (Simple Explanation)

1. Create users for each team member
2. Add users into groups based on job role
3. Attach policies to groups
4. Use roles for AWS services like EC2
5. Test permissions to verify access boundaries

<br>

---

<br>

### ⚙️ Technical Insight

**Lab Structure Built**

I created:

**👨‍💻 Developers Group**
- AmazonEC2FullAccess
- AWSLambdaFullAccess

**📊 Analysts Group**
- AmazonS3ReadOnlyAccess
- AmazonAthenaFullAccess

**👔 Managers Group**
- ReadOnlyAccess

**IAM Users Created**
- dev-user
- analyst-user
- manager-user

**IAM Role Created**
**EC2-S3-ReadOnly-Role**

Allows EC2 instances to read from S3 without storing credentials.

**Permission Testing Results**
- analyst-user could view S3 buckets
- analyst-user could NOT create S3 buckets
- manager-user could NOT launch EC2 instances

👉 This proved IAM permissions were working correctly.

<br>

---

<br>

### 🌍 Real-World Scenario (Nigeria)

A Lagos fintech startup has:
- Developers building APIs
- Analysts reviewing reports in Athena
- Managers monitoring resources

Using IAM groups:
- Developers get build permissions
- Analysts get read-only data access
- Managers get visibility only

👉 This improves security and reduces mistakes.

<br>

---

<br>

### ⚠️ Common Mistakes & Exam Traps

- ❌ Giving all users AdministratorAccess
  ✅ Use least privilege instead
- ❌ Creating long-term access keys for EC2
  ✅ Use IAM Roles instead
- ❌ Assigning permissions individually
  ✅ Use Groups for easier management
- ❌ Ignoring permission testing
  ✅ Always validate access boundaries
- ❌ Sharing one AWS login across team members
  ✅ Create separate IAM users

<br>

---

<br>

### 📝 Practice Question Insight

Correct Answer:
✅ IAM Roles should be used for EC2 instances needing access to AWS resources.

<br>

---

<br>

### 🧠 Reflection

Today, I learned how professional AWS teams manage access securely.

What stood out to me was how groups simplify administration, while roles eliminate the need to hardcode credentials.

Testing “Access Denied” responses helped me understand IAM far better than theory alone.

<br>

---

<br>

### 🚀 Key Takeaways

- IAM Users = identities
- IAM Groups = permission management
- IAM Roles = temporary secure access
- Policies define permissions
- Least privilege is essential
- Real learning happens when permissions are tested

<br>

---

## Lab Task Results

### Step 1: IAM Console with the 3 groups
Explored the IAM Console and created the three user groups.

![Step 1](../Week-02/Day%2001/Step%201%20-%20IAM%20Console%20with%20the%203%20groups.png)

---

### Step 2: Access Denied for analyst-user
Tested the `analyst-user` and confirmed they could not create S3 buckets.

![Step 2](../Week-02/Day%2001/Step%202%20-%20Access%20Denied%20for%20analyst-user.png)

---

### Step 3: Access Denied for manager-user
Tested the `manager-user` and confirmed they could not launch EC2 instances.

![Step 3](../Week-02/Day%2001/Step%203%20-%20Access%20Denied%20for%20manager-user.png)

---

### Step 4: IAM architecture diagram
Reviewed the IAM architecture diagram showing the relationship between users, groups, and roles.

![Step 4](../Week-02/Day%2001/Step%204%20-%20IAM%20architecture%20diagram.png)

---

### Step 5: EC2-S3-ReadOnly-Role Created
Created the IAM role `EC2-S3-ReadOnly-Role` for secure access.

![Step 5](../Week-02/Day%2001/Step%205%20-%20EC2-S3-ReadOnly-Role%20Created.png)

<br>

---

### 📅 Progress Tracker
- [x] **Week 2 Day 1 Completed** ✅
