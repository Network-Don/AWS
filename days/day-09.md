<div align="center">

# 🕵️ Week 2 Day 4 – CloudTrail & Audit Logging

*On Week 2 Day 4 of my AWS Cloud journey, I learned how AWS tracks account activity using CloudTrail and how audit logs help investigate actions performed in the cloud.*

*I also completed a practical lab where I enabled CloudTrail, generated real AWS actions, and analyzed raw log files stored in S3.*

*This is a critical cloud security and compliance skill.*

</div>

---

<br>

### 🌍 Why This Matters

Every action in AWS can impact security, cost, or operations.

Without logging, it becomes difficult to know:

- Who created resources
- Who deleted data
- Who changed permissions
- Where suspicious actions came from

👉 Key insight:
**CloudTrail gives visibility, accountability, and evidence.**

<br>

---

<br>

### 🔑 Key Concepts

**📜 AWS CloudTrail**
- Service that records AWS API activity and account actions.

**🪣 Trail**
- Configuration that delivers logs to S3 continuously.

**📂 Event History**
- Built-in CloudTrail view for recent management events.

**🧾 Log Entry Fields**
- Common fields include:
  - `eventName`
  - `eventTime`
  - `userIdentity`
  - `sourceIPAddress`
  - `requestParameters`

**🔐 Audit Logging**
- Recording actions for monitoring, investigations, and compliance.

<br>

---

<br>

### ⚙️ How It Works (Simple Explanation)

1. Create a CloudTrail trail
2. Choose an S3 bucket for storage
3. Perform AWS actions in the console
4. CloudTrail records those actions
5. Review logs in Event History or S3 JSON files

<br>

---

<br>

### ⚙️ Technical Insight

**Trail Created**

`my-account-audit-trail`

Stored logs in a dedicated S3 bucket.

**Actions Generated**

I performed:
- Created IAM user
- Created S3 bucket
- Started EC2 launch flow (cancelled)
- Deleted IAM user
- Deleted S3 bucket

**Log Analysis**

Found entries for:

**CreateUser**
- Included:
  - Timestamp
  - My identity
  - Source IP address
  - Request details

**DeleteUser**
- Recorded deletion activity clearly.

**Security Use Case**

CloudTrail can help investigate:
- Unauthorized logins
- Suspicious deletions
- Privilege changes
- Resource misuse

<br>

---

<br>

### 🌍 Real-World Scenario (Nigeria)

A fintech company in Lagos notices an S3 bucket was deleted unexpectedly.

Using CloudTrail, they can identify:
- Who deleted it
- What time it happened
- Which IP address was used
- What credentials were involved

👉 This is essential for incident response and compliance.

<br>

---

<br>

### ⚠️ Common Mistakes & Exam Traps

- ❌ Assuming CloudTrail is optional
  ✅ Logging is a security best practice
- ❌ Not storing logs centrally
  ✅ Use dedicated S3 buckets
- ❌ Never reviewing logs
  ✅ Logs are only useful when monitored
- ❌ Ignoring suspicious IP addresses
  ✅ Investigate unfamiliar login sources
- ❌ Thinking CloudTrail only tracks EC2
  ✅ It records actions across AWS services

<br>

---

<br>

### 📝 Practice Question Insight

Correct Answer:
✅ AWS CloudTrail records API activity and account actions for auditing and monitoring.

<br>

---

<br>

### 🧠 Reflection

Today, I learned that cloud security is not only prevention — it is also visibility.

What stood out to me was seeing my own AWS actions captured in raw JSON logs with timestamps and IP addresses.

This made cloud forensics feel practical and real.

<br>

---

<br>

### 🚀 Key Takeaways

- CloudTrail records AWS actions
- Logs help with investigations
- S3 stores audit history
- IP addresses reveal access sources
- Logging supports compliance
- Visibility is key to security

<br>

---

## Lab Task Results

### Step 1: CloudTrail created
Enabled CloudTrail to track account activity securely.

![Step 1](../Week-02/Day%2004/Step%201%20-%20Cloudtrail%20created.png)

---

### Step 2: S3 Bucket with CloudTrail folder structure
Verified that CloudTrail created a structured folder hierarchy in the dedicated S3 bucket.

![Step 2](../Week-02/Day%2004/Step%202%20-%20S3%20Bucket%20with%20Cloudtrail%20folder%20structure.png)

---

### Step 3: Raw JSON log file
Examined the raw CloudTrail logs stored in S3.

![Step 3](../Week-02/Day%2004/Step%203%20-%20Raw%20JSON%20log%20file.png)

---

### Step 4: CreateUser event entry
Analyzed the `CreateUser` event to find timestamps, source IP, and identity details.

![Step 4](../Week-02/Day%2004/Step%204%20-%20CreateUser%20event%20entry.png)

---

### Step 5: DeleteUser event entry
Confirmed `DeleteUser` actions are precisely tracked in Event History.

![Step 5](../Week-02/Day%2004/Step%205%20-%20DeleteUser%20event%20entry.png)

---

### Bonus Challenge: Console login
Investigated a ConsoleLogin event to see how authentication is captured.

![Bonus Challenge](../Week-02/Day%2004/Bonus%20Challenge%20-%20Console%20login.png)

<br>

---

### 📅 Progress Tracker
- [x] **Week 2 Day 4 Completed** ✅
