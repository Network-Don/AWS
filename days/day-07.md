<div align="center">

# 🔐 Week 2 Day 2 – IAM Policies: Writing & Reading Permissions

*On Week 2 Day 2 of my AWS Cloud journey, I learned how IAM Policies work by reading managed policies, writing my first custom JSON policy from scratch, and testing permissions using the IAM Policy Simulator.*

*This topic helped me understand how AWS permissions are truly controlled behind the scenes.*

</div>

---

<br>

### 🌍 Why This Matters

IAM policies determine what actions identities can perform on AWS resources.

Without strong policies, users may receive:

- Too much access
- Accidental destructive permissions
- Security risks
- Poor governance

👉 Key insight:
**Cloud security is built through permissions, not assumptions.**

<br>

---

<br>

### 🔑 Key Concepts

**📜 IAM Policy**
- A JSON document that defines permissions.

**✅ Allow**
- Grants permission to perform an action.
- Example: `s3:GetObject`

**❌ Deny**
- Explicitly blocks access, even if another policy allows it.

**🎯 Resource Scoping**
- Limits permissions to specific AWS resources using ARNs.

**\*** (Wildcards)
- Used to match multiple resources or actions.
- Example: `my-app-bucket-*`

**🧪 Policy Simulator**
- Tool used to test if permissions will Allow or Deny before real use.

<br>

---

<br>

### ⚙️ How It Works (Simple Explanation)

1. Read an AWS managed policy
2. Understand Effect, Action, Resource
3. Create your own JSON policy
4. Attach it to a user
5. Test actions using Policy Simulator

<br>

---

<br>

### ⚙️ Technical Insight

**Custom Policy Built**

`S3-AppBucket-ReadOnly-NoDeletion`

This policy:

✅ **Allowed:**
- `s3:GetObject`
- `s3:ListBucket`

Only on buckets starting with: `my-app-bucket-*`

❌ **Denied:**
- `s3:DeleteObject` on all buckets

**Simulation Results**
- **Allowed:** `analyst-user` could read: `my-app-bucket-test/file.txt`
- **Denied:** `analyst-user` could NOT read: `other-bucket/file.txt`
- **Explicitly Denied:** `analyst-user` could NOT delete objects anywhere.

👉 This showed how explicit deny overrides allow.

<br>

---

<br>

### 🌍 Real-World Scenario (Nigeria)

A Lagos startup stores customer reports in S3.

They want analysts to:
- ✅ Read reports
- ❌ Delete reports
- ❌ Access unrelated buckets

Using custom IAM policies, they can safely enforce this.

👉 This protects business data while enabling productivity.

<br>

---

<br>

### ⚠️ Common Mistakes & Exam Traps

- ❌ Giving full S3 access unnecessarily
  ✅ Scope access to required buckets only
- ❌ Ignoring explicit deny
  ✅ Deny overrides Allow
- ❌ Using `*` for all resources carelessly
  ✅ Always scope resources where possible
- ❌ Deploying policies without testing
  ✅ Use Policy Simulator first
- ❌ Thinking managed policies are always best
  ✅ Custom policies often give better control

<br>

---

<br>

### 🧠 Reflection

Today, I learned that IAM policies are the real engine behind AWS security.

What stood out to me was how powerful simple JSON statements can be when properly written.

Testing permissions made me understand that security is not guesswork — it is logic.

<br>

---

<br>

### 🚀 Key Takeaways

- IAM Policies define permissions
- Allow grants access
- Explicit Deny overrides Allow
- Resource scoping improves security
- Wildcards must be used carefully
- Policy Simulator is essential

<br>

---

## Lab Task Results

### Step 1: Custom Policy JSON
Wrote my first custom JSON policy to grant read-only access and explicitly deny deletion.

![Step 1](../Week-02/Day%2002/Step%201%20-%20Custom%20Policy%20JSON.png)

---

### Step 2: Allowed for right bucket
Tested reading from `my-app-bucket-test` and verified access was **Allowed**.

![Step 2](../Week-02/Day%2002/Step%202%20-%20Allowed%20for%20right%20bucket.png)

---

### Step 3: Test access for wrong bucket
Tested reading from `other-bucket` using the simulator.

![Step 3](../Week-02/Day%2002/Step%203%20-%20Allowed%20for%20wrong%20bucket.png)

---

### Step 4: Explicit Deny
Tested deleting an object and verified the **Explicit Deny** worked.

![Step 4](../Week-02/Day%2002/Step%204%20-%20Explicit%20Deny.png)

---

### Bonus Challenge: Allowed from my public IP
Tested an advanced condition allowing access only from a specific public IP.

![Bonus Challenge](../Week-02/Day%2002/Bonus%20Challenge%20-%20Allowed%20from%20my%20public%20IP.png)

<br>

---

### 📅 Progress Tracker
- [x] **Week 2 Day 2 Completed** ✅
