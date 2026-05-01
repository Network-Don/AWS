<div align="center">

# 🏢 Week 2 Day 3 – SCPs & AWS Organizations

*On Week 2 Day 3 of my AWS Cloud journey, I learned how enterprises manage multiple AWS accounts using AWS Organizations and enforce governance using Service Control Policies (SCPs).*

*I also completed a practical lab where I designed a multi-account fintech architecture and wrote security-focused SCPs.*

*This is an advanced AWS governance topic often used in large companies.*

</div>

---

<br>

### 🌍 Why This Matters

As companies grow, running everything in one AWS account becomes risky and difficult to manage.

Using multiple accounts helps separate:

- Production workloads
- Development environments
- Billing
- Security logging

SCPs help leadership enforce organization-wide rules.

👉 Key insight:
**IAM manages permissions inside accounts, while SCPs control the maximum permissions across accounts.**

<br>

---

<br>

### 🔑 Key Concepts

**🏢 AWS Organizations**
- Service used to centrally manage multiple AWS accounts.

**👑 Management Account**
- Main account used for billing and organization management.

**🧩 Member Accounts**
- Separate AWS accounts under the organization.

**📂 Organizational Units (OUs)**
- Logical containers used to group accounts.
- Examples: Production, Development, Security

**🔒 Service Control Policies (SCPs)**
- Policies that define the permission boundary for member accounts.
- They do not grant access.

<br>

---

<br>

### ⚙️ How It Works (Simple Explanation)

1. Create an AWS Organization
2. Add multiple AWS accounts
3. Group accounts into OUs
4. Attach SCPs to OUs or accounts
5. IAM permissions still apply inside each account

<br>

---

<br>

### ⚙️ Technical Insight

**Mock Structure Built for OluPay Ltd**

- **Root**
  - **Management Account** (billing only)
  - **Production OU**
    - `prod-backend`
    - `prod-frontend`
    - `prod-database`
  - **Development OU**
    - `dev-team`
    - `staging`
  - **Security OU**
    - `audit-log`
    - `security-tools`

**SCP Written**

**Deny Disable CloudTrail**

Blocked:
- `cloudtrail:StopLogging`
- `cloudtrail:DeleteTrail`
- `cloudtrail:UpdateTrail`

👉 Prevents admins from disabling audit logs.

**Second SCP**

Blocked:
- `organizations:LeaveOrganization`

👉 Prevents accounts from leaving governance controls.

**Key Rule**
- Even if IAM allows something, an SCP deny can still block it.

<br>

---

<br>

### 🌍 Real-World Scenario (Nigeria)

A Nigerian fintech with multiple teams wants strong governance.

They separate accounts into:
- Production systems
- Test environments
- Audit logging
- Security tools

Then apply SCPs to stop risky actions like deleting logs.

👉 This improves compliance, security, and control.

<br>

---

<br>

### ⚠️ Common Mistakes & Exam Traps

- ❌ Thinking SCP grants permissions
  ✅ SCP only limits permissions
- ❌ Using one account for everything
  ✅ Use multi-account architecture
- ❌ Ignoring security logging accounts
  ✅ Separate audit/security accounts
- ❌ Confusing IAM with SCP
  ✅ IAM grants, SCP restricts
- ❌ No governance at OU level
  ✅ Apply controls centrally

<br>

---

<br>

### 📝 Practice Question Insight

Correct Answer:
✅ SCPs define the maximum permissions available to accounts in AWS Organizations.

<br>

---

<br>

### 🧠 Reflection

Today, I learned how real enterprises structure AWS environments.

What stood out to me was that governance happens above the account level, not just inside it.

Designing multiple accounts made AWS architecture feel much more professional and scalable.

<br>

---

<br>

### 🚀 Key Takeaways

- AWS Organizations manages multiple accounts
- OUs group accounts logically
- SCPs set permission boundaries
- SCPs do not grant access
- Multi-account design improves security
- Enterprise AWS requires governance

<br>

---

## Lab Task Results

### Step 1: OluPay Ltd Organizations diagram
Designed a multi-account organization structure for a fintech startup.

![Step 1](../Week-02/Day%2003/Step%201%20-%20OluPay%20Ltd%20Organizations%20diagram.png)

---

### Step 2: CloudTrail protection SCP JSON
Wrote an SCP to prevent any member account from disabling CloudTrail logging.

![Step 2](../Week-02/Day%2003/Step%202%20-%20CloudTrail%20protection%20SCP%20JSON.png)

---

### Step 3: SCP vs IAM Comparison
Reviewed how SCP boundaries affect IAM permissions.

![Step 3](../Week-02/Day%2003/Step%203%20-%20SCP%20vs%20IAM%20Comparison.png)

---

### Bonus Challenge: restrict all members accounts to af-south services
Applied an SCP to ensure resources can only be created in specific approved regions.

![Bonus Challenge](../Week-02/Day%2003/Bonus%20Challenge%20-%20restrict%20all%20members%20accounts%20to%20af-south%20services.png)

<br>

---

### 📅 Progress Tracker
- [x] **Week 2 Day 3 Completed** ✅
