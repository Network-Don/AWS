<div align="center">

# ☁️ Week 4 · Day 3 — EC2 Pricing Models

*Today shifted my focus from launching compute power to optimizing its cost and performance. I explored AWS EC2 pricing models—On-Demand, Reserved Instances, Savings Plans, and Spot Instances—to understand how to design cost-effective cloud architectures. I applied these concepts by analyzing a workload scenario for a fintech platform and formulating a blended, FinOps-driven optimization strategy.*

</div>

---

<br>

### 🔑 Key Concepts Covered

- **On-Demand Pricing:** Pay-as-you-go compute capacity with no long-term commitment. High cost but maximum flexibility.
- **Reserved Instances (RIs):** Commitment to a specific instance configuration (type, region, OS) for a 1-year or 3-year term, yielding up to 72% savings.
- **Savings Plans:** A flexible commitment-based pricing model (1-year or 3-year) offering low rates in exchange for a commitment to a consistent amount of compute spend ($/hour).
- **Spot Instances:** Spare EC2 capacity offered at up to 90% savings, subject to reclamation by AWS with a 2-minute interruption notice.
- **Cost Optimisation Strategies:** Techniques such as right-sizing, scheduling, and leveraging commitment models to minimize AWS spend.
- **Blended Pricing Strategy:** Combining different pricing models to achieve cost savings without compromising workload reliability or scalability.
- **FinOps Mindset:** A cultural and operational practice that brings financial accountability to the variable spend model of cloud computing.
- **Cost Comparison & Recommendation Analysis:** Evaluating workload characteristics against pricing structures to make data-driven architectural decisions.

<br>

---

<br>

### 🏢 Workload Scenario: OluPay Fintech

**Workload Profile:**
- **Instances:** 4 × `m5.xlarge` EC2 instances
- **Region:** `us-east-1`
- **Operating System:** Linux
- **Schedule:** 24/7/365 (continuous baseline workload)

#### Cost Comparison & Spreadsheet Analysis

A spreadsheet analysis was performed to compare annual costs and evaluate the best fit:

| Pricing Model | Hourly Rate (per Instance) | Total Hourly Cost (4 Instances) | Annual Cost (4 Instances) | Savings vs. On-Demand | Flexibility | Commitment Level | Recommended Workload Fit |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **On-Demand** | $0.192 | $0.768 | $6,727.68 | 0% (Baseline) | **Extremely High** | None | Spiky, short-term, or unpredictable workloads. |
| **Compute Savings Plan (1-Year)** | ~$0.138 | ~$0.553 | ~$4,835.52 | ~28% | **High** | 1 Year | Stable workloads expecting architecture updates. |
| **Reserved Instances (1-Year Standard)** | ~$0.121 | ~$0.484 | ~$4,239.84 | ~37% | **Medium** | 1 Year | Predictable, stable baseline production systems. |
| **Compute Savings Plan (3-Year)** | ~$0.109 | ~$0.438 | ~$3,834.78 | **~43%** | **High** | 3 Years | Long-term baseline workloads requiring family/region flexibility. |
| **Reserved Instances (3-Year Standard)** | ~$0.090 | ~$0.361 | ~$3,162.01 | **~53%** | **Low** | 3 Years | Predictable, unchanging long-term production systems. |
| **Spot Instances** | ~$0.054 | ~$0.216 | ~$1,883.75 | **~72%** | **Low** | None | Fault-tolerant, batch, and interruptible background jobs. |

<br>

---

<br>

### 💡 Recommendation & Blended Strategy Summary

For predictable 24/7 workloads like payment processing APIs, Reserved Instances or Compute Savings Plans provide the best long-term cost efficiency. On-Demand pricing offers flexibility but becomes expensive at scale, while Spot Instances are best reserved for fault-tolerant background jobs due to interruption risks. A blended pricing strategy delivers the best balance between cost optimisation, scalability, and operational reliability.

#### 🎯 Recommendation for OluPay Fintech
> For OluPay’s payment processing workload, a Compute Savings Plan is the optimal choice as it balances cost savings (~43%) with flexibility across instance types and services. While 3-year Reserved Instances offer the highest savings (~53%), they lack flexibility and lock the business into a fixed configuration. Therefore, a 1–3 year Savings Plan is recommended to reduce costs while still allowing scalability as the platform grows.

<br>

---

<br>

### ⚡ Bonus Challenge — EC2 Spot Instances & Compute Optimizer

#### 💡 Spot Instance Notes
- Spot Instances can provide up to **90% savings** compared to On-Demand pricing by selling unused AWS capacity.
- **Best Suited For:** Interruptible workloads such as batch processing, big data analytics, image rendering, and machine learning training.
- **Production Warning:** They are **not ideal** for critical production workloads because AWS can reclaim capacity at any time with a **2-minute interruption notice**.
- **Mitigation Strategies:**
  - Utilizing **Auto Scaling Groups** or **Spot Fleets** configured with multiple instance types and Availability Zones.
  - Designing application checkpoints to save progress and state regularly.
  - Employing a blended strategy where Spot instances handle burst capacity while RIs/Savings Plans support the core baseline.

#### 🤖 AWS Compute Optimizer — 5 Bullet Summary
1. AWS Compute Optimizer analyzes CloudWatch metrics such as CPU utilization, memory usage, network traffic, and disk activity to evaluate resource performance.
2. It provides right-sizing recommendations for AWS resources like EC2 instances, EBS volumes, Auto Scaling groups, Lambda functions, and ECS services.
3. The service uses machine learning models trained on AWS workload patterns to recommend better-performing and cost-efficient resource configurations.
4. Recommendations include performance risk levels (low, medium, or high) to help users understand the impact before applying changes.
5. Compute Optimizer may take up to 24 hours or more to gather enough monitoring data before generating accurate optimization recommendations for newly created resources.

<br>

---

<br>

### 🧠 Reflection

Today’s lab shifted my perspective from basic instance launching to cloud financial management (FinOps). I realized that choosing the right pricing model is just as important as choosing the right architecture. Calculating the annual cost differences for OluPay Fintech made it clear how rapidly pay-as-you-go costs can accumulate at scale. Selecting a Compute Savings Plan showed me how to strike a balance between securing massive savings (~43% for a 3-year commitment) and retaining the agility to upgrade our architecture as the company grows.

<br>

---

<br>

### 🚀 Key Lessons Learned

- **Analyze Before Committing:** Predictability dictates the model. Baseline workloads running 24/7 should never be left on On-Demand pricing.
- **Flexibility Has a Price:** Compute Savings Plans offer slightly lower savings than Standard RIs, but the freedom to change instance families, regions, or compute services is worth the premium for growing systems.
- **Spot is for Scale, Not Production:** Spot instances can save up to 90% but require careful architectural planning (like ASGs, fleets, and checkpointing) to handle sudden reclamation.
- **FinOps is Continuous:** Cost optimization is not a one-time event; tools like AWS Compute Optimizer must be integrated into daily operations to maintain efficiency.

<br>

---

<br>

## 📸 Screenshot Section

### Step 1: Pricing comparison spreadsheet with all 4 pricing models
![Pricing comparison spreadsheet](../Week-04/Day%2003/Step%201%20-%20Pricing%20comparison%20spreadsheet%20with%20all%204%20pricing%20models.png)

---

### Step 2: Savings percentages calculated and highlighted
![Savings calculations highlighted](../Week-04/Day%2003/Step%202%20-%20Savings%20percentages%20calculated%20and%20highlighted.png)

<br>

---

<br>

### 📅 Progress Tracker
- [x] **Week 4 Day 3 Completed** ✅

---

<div align="center">

| [« Previous Day: EC2 Instance Types & AMIs](./day-17.md) | [Next Day: Auto Scaling & Load Balancing](./day-19.md) » |
| :---: | :---: |

</div>
