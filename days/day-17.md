<div align="center">

# ☁️ Week 4 · Day 2 — EC2 Instance Types & AMIs

*Today focused on understanding EC2 instance families, workload-based instance selection, and Amazon Machine Images (AMIs). I learned how AWS provides different compute profiles optimized for CPU, memory, storage, and GPU workloads, and how AMIs allow engineers to launch preconfigured servers consistently at scale.*

</div>

---

<br>

### 🔑 Key Concepts Learned

- **EC2 instance families** are optimized for different workloads.
- **Instance names** contain information about family, generation, processor, and size.
- **AMIs (Amazon Machine Images)** are reusable templates containing OS, software, and configuration.
- **Custom AMIs** improve scalability and deployment consistency.
- **AMIs and EBS snapshots** are related but different resources.

<br>

---

<br>

### 🏢 EC2 Instance Families & Nigerian Use Cases

**✅ General Purpose (T, M)**
- **Profile:** Balanced CPU + RAM
- **Example:** Small business website or SME e-commerce platform in Lagos.

**✅ Compute Optimized (C)**
- **Profile:** High CPU power
- **Example:** Fintech transaction processing system (Paystack-like workloads).

**✅ Memory Optimized (R, X)**
- **Profile:** High RAM
- **Example:** Bank fraud detection system handling large in-memory datasets.

**✅ Storage Optimized (I, D)**
- **Profile:** High disk throughput and IOPS
- **Example:** Telecom logging systems for MTN or Airtel infrastructure.

**✅ Accelerated Computing (P, G)**
- **Profile:** GPU-based computing
- **Example:** AI startup training machine learning models for fraud detection or image recognition.

<br>

---

<br>

### 🧠 Technical Deep Dive

- **T-series** instances use CPU credits and burst performance.
- **C-series** are designed for sustained compute-heavy workloads.
- **R-series** focus on high-memory applications.
- **AMIs** package complete server environments.
- Deregistering an AMI does **NOT** delete its snapshots.
- **Custom AMIs** help Auto Scaling launch identical servers quickly.

<br>

---

<br>

### 🌍 Real-World Scenario (Nigeria)

**Konga Nigeria scaling for Black Friday:**

- Right-sized instances based on workload bottlenecks.
- Built a custom AMI with preinstalled applications.
- Used Auto Scaling Groups to launch identical servers during traffic spikes.

<br>

---

<br>

### ⚠️ Common Mistakes & Exam Traps

- ❌ Assuming Free Tier means production-ready.
- ❌ Expecting T-series to not throttle under sustained load.
- ❌ Believing AMI deregistration removes snapshots.
- ❌ Using Community AMIs for production environments (they are unsafe).

<br>

---

<br>

### 🧠 Reflection

Today helped me understand how AWS compute is optimized for different workloads instead of using one server type for everything. What stood out most was learning how custom AMIs allow organizations to scale identical servers rapidly and consistently during high-demand events.

<br>

---

<br>

### 🚀 Key Takeaways

- Match workloads to the correct EC2 family.
- Understand CPU, RAM, storage, and GPU bottlenecks.
- AMIs make infrastructure reusable and scalable.
- Custom AMIs are essential for production environments.
- AMI ≠ EBS Snapshot.

<br>

---

<br>

## 🛠️ Lab Tasks Completed

### Hands-On Activities

- Researched EC2 instance families.
- Built a 6-instance comparison table.
- Created a custom AMI from a configured EC2 instance.
- Installed `nginx`, `git`, and `htop` on Amazon Linux 2.
- Added custom MOTD banner.
- Launched a new EC2 instance directly from the custom AMI.
- Verified preinstalled packages persisted.
- Terminated all lab instances after testing.

### Bonus Challenge Completed — AWS Compute Optimizer

**AWS Compute Optimizer — Key Insights**

AWS Compute Optimizer analyzes CloudWatch CPU, memory, and network metrics to recommend right-sized EC2 instances for better performance and cost optimization.

**5 Key Points Learned:**
1. AWS Compute Optimizer analyzes CloudWatch metrics such as CPU utilization, memory usage, network traffic, and disk activity to evaluate resource performance.
2. It provides right-sizing recommendations for AWS resources like EC2 instances, EBS volumes, Auto Scaling groups, Lambda functions, and ECS services.
3. The service uses machine learning models trained on AWS workload patterns to recommend better-performing and cost-efficient resource configurations.
4. Recommendations include performance risk levels (low, medium, or high) to help users understand the impact before applying changes.
5. Compute Optimizer may take up to 24 hours or more to gather enough monitoring data before generating accurate optimization recommendations for newly created resources.

**Why This Matters**  
Compute Optimizer helps organizations reduce unnecessary cloud costs while maintaining application performance and operational efficiency.

<br>

---

<br>

## 📸 Screenshot Section

### Instance Comparison Table
![Instance Comparison Table](../Week-04/Day%2002/6-Instance%20comparison%20table.png)

---

### Custom AMI Available
![Custom AMI Available](../Week-04/Day%2002/Custom%20AMI%20showing%20Available%20status%20in%20EC2%20AMIs%20console.png)

---

### Custom MOTD Verification
![Custom MOTD Verification](../Week-04/Day%2002/SSH%20to%20new%20instance%20showing%20custom%20etcmotd%20message.png)

<br>

---

<br>

### 📅 Progress Tracker
- [x] **Week 4 Day 2 Completed** ✅

---

<div align="center">

| [« Previous Day: EC2 Introduction & Launch](./day-16.md) | [Next Day: EC2 Pricing Models](./day-18.md) » |
| :---: | :---: |

</div>
