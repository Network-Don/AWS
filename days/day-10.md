<div align="center">

# 🛡️ Week 2 Day 5 – MFA & Security Best Practices

*On Week 2 Day 5 of my AWS Cloud journey, I learned how to strengthen AWS account security using MFA (Multi-Factor Authentication), security best practices, and proactive hardening techniques.*

*I also completed a practical lab where I reviewed security findings, created an MFA enforcement policy, and built my own AWS Security Runbook.*

*This wrapped up a full week focused on IAM and cloud security fundamentals.*

</div>

---

<br>

### 🌍 Why This Matters

Passwords alone are no longer enough to secure cloud accounts.

If credentials are leaked or reused, attackers may gain access to:

- Sensitive data
- Billing controls
- IAM permissions
- Production systems

👉 Key insight:
**Strong cloud security starts with layered protection, especially MFA.**

<br>

---

<br>

### 🔑 Key Concepts

**🔐 Multi-Factor Authentication (MFA)**
- Adds a second verification factor beyond password login.

**🧾 AWS Security Hub**
- Service that checks AWS accounts against security best practices.

**📜 MFA Enforcement Policy**
- IAM policy that blocks actions unless MFA is enabled or present.

**📘 Security Runbook**
- A documented guide for securing accounts and responding to incidents.

**🛠 Hardening**
- Reducing security risk by applying recommended protections.

<br>

---

<br>

### ⚙️ How It Works (Simple Explanation)

1. Enable MFA on root and IAM users
2. Review security findings in Security Hub
3. Apply IAM policies that require MFA
4. Remove risky configurations
5. Document procedures in a runbook

<br>

---

<br>

### ⚙️ Technical Insight

**Security Hub Review**

Enabled:
- AWS Foundational Security Best Practices

Used findings dashboard to review failed vs passed controls.

**RequireMFA Policy Created**

This policy denied most actions if:
- MFA was not present

Allowed only MFA setup related actions.

Attached to:
- Analysts group

👉 This forces users to secure accounts before using them.

**Final Security Verification**

Confirmed:
- Root MFA enabled
- No root access keys
- IAM admin user with MFA
- Security recommendations improved

**Security Runbook Built**

Included:
- New account checklist
- IAM best practices
- Credential compromise response steps
- Monthly security review checklist

<br>

---

<br>

### 🌍 Real-World Scenario (Nigeria)

A startup employee in Lagos reuses a weak password across platforms.

If the password leaks:
- Without MFA → attacker may access AWS
- With MFA → login blocked without second factor

👉 MFA can prevent costly breaches.

<br>

---

<br>

### ⚠️ Common Mistakes & Exam Traps

- ❌ Relying only on passwords
  ✅ Enable MFA everywhere possible
- ❌ Using root account casually
  ✅ Lock root account and protect it
- ❌ Ignoring security findings
  ✅ Review dashboards regularly
- ❌ No response plan for leaks
  ✅ Maintain a security runbook
- ❌ Thinking security is one-time setup
  ✅ Security requires ongoing reviews

<br>

---

<br>

### 📝 Practice Question Insight

Correct Answer:
✅ MFA adds an extra authentication factor and significantly improves account security.

<br>

---

<br>

### 🧠 Reflection

Today, I learned that real cloud security is proactive, not reactive.

What stood out to me was how simple controls like MFA and routine reviews can prevent major incidents.

Building a runbook also showed me that security includes process, not just tools.

<br>

---

<br>

### 🚀 Key Takeaways

- MFA is essential for AWS security
- Security Hub reveals weaknesses
- IAM policies can enforce safer behavior
- Root account must be protected
- Runbooks improve incident readiness
- Security is continuous

<br>

---

## Lab Task Results

### Step 1: Security Hub Findings Dashbord
Reviewed the security findings dashboard to identify failed controls.

![Step 1](../Week-02/Day%2005/Step%201%20-%20Security%20Hub%20Findings%20Dashbord.png)

---

### Step 2: RequireMFA policy JSON in IAM Console
Created a policy to enforce MFA before allowing other actions.

![Step 2](../Week-02/Day%2005/Step%202%20-%20RequireMFA%20policy%20JSON%20in%20IAM%20Console.png)

---

### Step 3: IAM Security Recommendations - all green
Verified that IAM security recommendations were all improved and showing green.

![Step 3](../Week-02/Day%2005/Step%203%20-%20IAM%20Security%20Recommendations%20-%20all%20green.png)

---

### Step 4: First Page of Security Runbook Document
Documented my security procedures in a comprehensive runbook.

![Step 4](../Week-02/Day%2005/Step%204%20-%20First%20Page%20of%20Security%20Runbook%20Document.png)

---

### Bonus Challenge: AWS Trusted Advisor Security Recommendations
Checked Trusted Advisor for additional security recommendations.

![Bonus Challenge](../Week-02/Day%2005/Bonus%20Challege%20-%20AWS%20Trusted%20Advisor%20Security%20Recommendations.png)

<br>

---

### 📅 Progress Tracker
- [x] **Week 2 Day 5 Completed** ✅
- [x] **Week 2 Completed** ✅
