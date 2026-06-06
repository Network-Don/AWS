<div align="center">

# ☁️ Week 5 · Day 2 — S3 Storage Classes & Lifecycle

*Today's lab focused on data lifecycle management within Amazon S3, configuring rule policies to transition objects automatically across storage classes to optimize long-term storage costs. I modeled a FinOps cost analysis scenario for archiving 60 TB of clinical MRI data over a 7-year regulatory retention period and conducted a break-even analysis comparing manual lifecycle rules with S3 Intelligent-Tiering.*

</div>

---

<br>

### 📖 Overview

In real-world cloud environments, storing all data in the S3 Standard storage class indefinitely leads to significant cost inefficiencies. As data ages, its access frequency typically decreases. To address this, cloud engineers leverage **S3 Lifecycle Policies** to automate cost optimization by moving data to lower-cost storage tiers.

This documentation reviews the creation and testing of an automated S3 Lifecycle policy, provides a comprehensive FinOps cost comparison for a 60 TB healthcare database, compares the different S3 storage classes, and concludes with a break-even analysis of manual lifecycle rules versus S3 Intelligent-Tiering.

<br>

---

<br>

### 🎯 Objectives

- **Create a dedicated S3 archive bucket:** Provision a new bucket configured to store simulated long-term archive objects.
- **Implement automated lifecycle rules:** Configure `AutoArchiveRule` to automate the transition and expiration of objects across S3 Standard, S3 Standard-IA, S3 Glacier Instant Retrieval, and S3 Glacier Flexible Retrieval over a 7-year timeline.
- **Perform a FinOps Cost Analysis:** Calculate and compare storage fees for a 60 TB MRI dataset under S3 Standard and a blended lifecycle schedule.
- **Analyze S3 Intelligent-Tiering:** Assess the financial and operational trade-offs of manual lifecycle tiering versus automated S3 Intelligent-Tiering.

<br>

---

<br>

### 🛠️ Services Used

- **Amazon S3 (Simple Storage Service):** Used for object storage, lifecycle management configuration, and access controls.
- **Amazon S3 Storage Classes:** Leveraged Standard, Standard-IA, Glacier Instant Retrieval, and Glacier Flexible Retrieval.
- **AWS Cost Management / FinOps Concepts:** Applied standard pricing models to perform a multi-year cost projection.

<br>

---

<br>

### 🏗️ Architecture / Lifecycle Flow

The diagram below illustrates the lifecycle path configured for objects inside the S3 archive bucket under the `AutoArchiveRule`:

```
Day 0                Day 30                 Day 90                       Day 365                        Day 2555 (7 Years)
 ┌──────────────┐     ┌────────────────┐     ┌──────────────────────┐     ┌────────────────────────┐     ┌─────────────────┐
 │ S3 Standard  │ ──> │ S3 Standard-IA │ ──> │ Glacier Instant Ret. │ ──> │ Glacier Flexible Ret.  │ ──> │   Permanent     │
 │ (Active scan)│     │ (Infrequent)   │     │ (Milliseconds ret.)  │     │ (Minutes/Hours ret.)   │     │   Expiration    │
 └──────────────┘     └────────────────┘     └──────────────────────┘     └────────────────────────┘     └─────────────────┘
```

- **S3 Standard (Days 0–30):** Objects are uploaded here initially for fast, low-latency client access.
- **S3 Standard-IA (Days 30–90):** Objects transition here when access becomes infrequent, lowering storage costs.
- **S3 Glacier Instant Retrieval (Days 90–365):** Objects transition here as archives that still require immediate, millisecond access if requested.
- **S3 Glacier Flexible Retrieval (Days 365–2555):** Objects transition here for deep archival. Retrieval takes minutes to hours.
- **Permanent Expiration (Day 2555):** S3 automatically deletes the objects to meet the 7-year regulatory retention limit, avoiding ongoing storage costs.

<br>

---

<br>

### ⚙️ Implementation Steps

#### Step 1: Created S3 Archive Bucket
- Provisioned a new S3 bucket named `raphael-mri-archive-bucket` in the preferred AWS Region.
- Uploaded multiple mock files of varying sizes (e.g., representation of MRI scan images) to simulate an active archive store.

#### Step 2: Created Lifecycle Rule
- Navigated to the bucket's **Management** tab and clicked **Create lifecycle rule**.
- Named the rule `AutoArchiveRule` and chose to apply it to all objects in the bucket.
- Configured the following transitions for the current version of objects:
  - Transition to **Standard-IA** after **30 days** from object creation.
  - Transition to **Glacier Instant Retrieval** after **90 days** from object creation.
  - Transition to **Glacier Flexible Retrieval** after **365 days** from object creation.
  - Configured object **Expiration** to permanently delete objects after **2555 days** (exactly 7 years).
- Reviewed and activated the lifecycle rule.

<br>

---

<br>

### 💰 Cost Analysis

#### Scenario:
A regional hospital in Ibadan, Nigeria, generates and stores **60 TB (60,000 GB)** of MRI scans. Regulatory standards require the hospital to retain these patient records for **7 years**.

#### S3 Storage Class Comparison (Flat Pricing Model)
The table below projects the monthly and annual costs of storing this 60 TB dataset statically in each individual storage class (based on standard `us-east-1` pricing):

| Storage Class | Storage Rate ($/GB/month) | Monthly Storage Cost | Annual Storage Cost | 7-Year Storage Cost | Savings vs. S3 Standard |
| :--- | :---: | :---: | :---: | :---: | :---: |
| **S3 Standard** | $0.0230 | $1,380.00 | $16,560.00 | $115,920.00 | *Baseline* |
| **S3 Standard-IA** | $0.0125 | $750.00 | $9,000.00 | $63,000.00 | **45.6%** |
| **S3 Glacier Instant Retrieval** | $0.0040 | $240.00 | $2,880.00 | $20,160.00 | **82.6%** |
| **S3 Glacier Flexible Retrieval** | $0.0036 | $216.00 | $2,592.00 | $18,144.00 | **84.3%** |

#### Estimated Blended Lifecycle Cost (Our Configured Rule)
When applying the `AutoArchiveRule` to a 60 TB batch of files uploaded at Day 0, the cost changes dynamically over time as the data transitions through S3 tiers:

- **Year 1 Cost Breakdown:**
  - **Month 1 (Days 0–30):** 60,000 GB in S3 Standard = $1,380.00
  - **Months 2–3 (Days 30–90):** 60,000 GB in Standard-IA = 2 × $750.00 = $1,500.00
  - **Months 4–12 (Days 90–365):** 60,000 GB in Glacier Instant Retrieval = 9 × $240.00 = $2,160.00
  - **Year 1 Total Blended Cost:** **$5,040.00**
- **Years 2–7 Cost Breakdown (Months 13–84):**
  - **6 Years (72 months):** 60,000 GB in Glacier Flexible Retrieval = 72 × $216.00 = **$15,552.00**
- **Total Blended 7-Year Lifecycle Cost:** **$20,592.00**
- **Average Annual Blended Cost:** **$2,941.71**
- **Total Lifetime Savings vs. S3 Standard:** **$95,328.00 (82.2% Cost Reduction)**

#### FinOps Analysis:
Automating this data lifecycle allows the hospital to achieve Glacier-level pricing for over 85% of the data's retention lifetime, while ensuring that newer files remain immediately accessible. This eliminates manual script management and guarantees compliance without overpaying for dormant storage.

<br>

---

<br>

### 📋 Storage Class Reference Table

| Storage Class | Minimum Duration | Retrieval Time | Use Case |
| :--- | :---: | :---: | :--- |
| **S3 Standard** | None | Instant | Frequently accessed active data, website assets, and game builds. |
| **S3 Standard-IA** | 30 Days | Instant | Infrequently accessed data that needs immediate access when requested. |
| **S3 One Zone-IA** | 30 Days | Instant | Re-creatable secondary backups, stored in a single Availability Zone. |
| **S3 Glacier Instant Retrieval** | 90 Days | Milliseconds | Archived data accessed once or twice a quarter that needs instant retrieval. |
| **S3 Glacier Flexible Retrieval** | 90 Days | 1 min to 5 hours | Medical records, digital archives, and compliance logs with flexible retrieval. |
| **S3 Glacier Deep Archive** | 180 Days | 12 to 48 hours | Long-term digital preservation and regulatory backups accessed once a year. |

> [!IMPORTANT]
> **Minimum Retention Penalty:** Deleting Glacier or Standard-IA objects before their minimum retention period (e.g., 90 days for Glacier, 30 days for IA) results in a pro-rated charge matching the remaining storage duration. Care must be taken when setting up short-lived test buckets.

<br>

---

<br>

### 🔑 Key Learnings

- **Automated Cost Optimization:** I learned that S3 Lifecycle Rules act as a native, hands-off mechanism to enforce FinOps principles, transitioning data automatically based on age.
- **S3 Tiering Architecture:** Understood the technical trade-offs between storage unit costs, retrieval times, and minimum retention charges.
- **Archive Security Compliance:** Verified how to safely implement long-term compliance retention while ensuring automatic expiration cleans up data after 7 years.
- **Blended Billing Analysis:** Modeled complex storage costs over multi-year periods to present clear financial justifications for cloud migrations.

<br>

---

<br>

### ⚠️ Challenges Encountered

- **Minimum Size Limitations:** S3 Standard-IA and Glacier Instant Retrieval have a minimum object size billing threshold of 128 KB. During initial testing, uploading small files (<10 KB) did not yield cost benefits.
  - *Mitigation:* Documented the best practice to aggregate or zip smaller files before transitioning them to IA or Glacier classes.
- **Transition Overlaps:** Care had to be taken when sequencing transitions (IA must occur before Glacier). Setting Glacier before IA would result in rule compilation errors in the AWS console.
  - *Mitigation:* Followed a chronological progression (30 -> 90 -> 365 days) during rule definition.

<br>

---

<br>

### 🎯 Outcome

- A dedicated S3 bucket was successfully created with `AutoArchiveRule` enabled.
- Objects uploaded to the bucket are now governed by policy-based automated transitions.
- Completed a full financial model highlighting **$95,328.00** in savings over 7 years for the Ibadan hospital MRI dataset.

<br>

---

<br>

## 📸 Screenshots

### Step 1: Lifecycle Rule Created in AWS Console
![Lifecycle rule created and showing in Management tab](./Step%201%20-%20Lifecycle%20rule%20created%20and%20showing%20in%20Management%20tab.png)
*Confirming that the AutoArchiveRule has been successfully created and is active under the Management tab of the S3 bucket.*

---

### Step 2: Storage Class Cost Comparison
![Cost analysis spreadsheet with all storage classes](./Step%202%20-%20My%20cost%20analysis%20spreadsheet%20with%20all%204%20storage%20classes.png)
*The spreadsheet detailing the monthly, annual, and 7-year storage costs across the four analyzed S3 storage classes for the 60 TB dataset.*

---

### Step 3: Lifecycle Savings Calculations
![Savings vs Standard calculated and highlighted](./Step%203%20-%20Savings%20vs%20Standard%20calculated%20and%20highlighted.png)
*The final cost projections showing the blended lifecycle average annual cost and the net savings compared to storing everything in S3 Standard.*

<br>

---

<br>

### ⚡ Bonus Challenge — S3 Intelligent-Tiering Break-even Analysis

#### Scenario:
A 60 TB healthcare database contains approximately **100,000 objects** with highly unpredictable access patterns. We evaluate manual tiering (using lifecycle policies) versus S3 Intelligent-Tiering.

#### Cost Comparison:

##### Option A: Lifecycle Rules (Manual Tiering)
- **Lifecycle Flow:** Standard ➔ IA ➔ Glacier Flexible
- **Total Annual Cost:** **~$2,592.00** (under stable Glacier Flexible storage phase).
- **Pros:** Lowest possible raw storage cost.
- **Cons:** Rigid scheduling. If data in Glacier is frequently accessed, high retrieval fees are incurred. Requires operational overhead to monitor and tune.

##### Option B: S3 Intelligent-Tiering
- **Access Flow:** Automatically moves data between Frequent, Infrequent, Archive Instant, and Archive Access tiers.
- **Monitoring Fee:** $0.0025 per 1,000 objects per month.
  - 100,000 objects × $0.0025/1,000 × 12 months = **$3.00/year** monitoring charge.
- **Total Annual Cost:** **~$2,600.00 – $2,900.00** (depending on how frequently objects shift access tiers).
- **Pros:** No retrieval fees when files are accessed. No management overhead.
- **Cons:** Slightly higher storage rate if objects remain stuck in frequent access tiers.

#### Break-even and Decision Matrix Insight:
Manual Lifecycle policies are highly effective when data access patterns are **predictable** (e.g., records are never accessed after 90 days). S3 Intelligent-Tiering is the superior design choice when:
1. **Access patterns are unknown or erratic:** If records are randomly queried, Intelligent-Tiering prevents costly S3 Glacier retrieval fees.
2. **Operational simplicity is prioritized:** Reduces the engineering hours required to manage, audit, and troubleshoot custom lifecycle rules.

#### Conclusion:
While Lifecycle Policies provide the *absolute lowest* raw storage cost for predictable workloads, **S3 Intelligent-Tiering** is justified for large, unpredictable datasets because the tiny operational monitoring cost ($3.00/year for 100,000 objects) is far outweighed by the protection against retrieval fees and the elimination of ongoing lifecycle policy maintenance.

<br>

---

<br>

### 🧠 Skills Demonstrated

- **AWS Storage Architecture Design:** Choosing the optimal storage tier based on retrieval time, retention limits, and durability goals.
- **Lifecycle Policy Orchestration:** Defining and testing rule engines to automate data flows.
- **FinOps Analysis:** Designing TCO (Total Cost of Ownership) financial models and conducting break-even assessments to justify architectural decisions.
- **Regulatory Compliance Engineering:** Structuring S3 properties to conform with standard medical and financial data retention rules.

<br>

---

<br>

### 📅 Progress Tracker
- [x] **Week 5 Day 2 Completed** ✅

---

<div align="center">

| [« Previous Day: Create an S3 Bucket & Host a Static Website](../Day%2001/README.md) | [Next Day: N/A »](../../README.md) |
| :---: | :---: |

</div>
