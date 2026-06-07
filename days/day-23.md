<div align="center">

# ☁️ Week 5 · Day 3 — Secure an S3 Bucket with Versioning, Encryption & Bucket Policies

*Today's lab focused on securing Amazon S3 using production-style security controls. I implemented S3 Versioning for accidental deletion recovery, configured Server-Side Encryption (SSE-S3) to protect data at rest, and applied an IAM-restricted Bucket Policy with an `ArnNotLike` condition to enforce strict access controls on the S3 bucket.*

</div>

---

<br>

### 📖 Lab Overview

Data security is a primary pillar of cloud engineering. As organizations move massive amounts of data to the cloud, protecting objects stored in Amazon Simple Storage Service (S3) becomes paramount. S3 is secure by default, but production-grade security requires layered controls to prevent data loss, ensure confidentiality, and restrict access.

In this lab, I implemented three core S3 security mechanisms:
1. **S3 Versioning:** To maintain historical versions of objects and recover from accidental or malicious deletions.
2. **Server-Side Encryption (SSE-S3):** To automatically encrypt objects at rest using Amazon S3-managed keys, meeting compliance standards without management overhead.
3. **S3 Bucket Policies:** To enforce resource-based access control, restricting bucket access exclusively to a designated IAM role.

<br>

---

<br>

### 🎯 Objectives

- **Implement S3 Versioning:** Enable versioning on an S3 bucket to track multiple iterations of files.
- **Configure Accidental Deletion Recovery:** Test object restoration using version history and Delete Markers.
- **Enforce Server-Side Encryption:** Enable default encryption using SSE-S3 and verify the status of new objects.
- **Implement Strict Resource-Based Access Control:** Write and apply an S3 Bucket Policy that denies access to all principals except a specific IAM role using the `ArnNotLike` condition.

<br>

---

<br>

### 🛠️ Services Used

- **Amazon S3 (Simple Storage Service):** Utilized for secure, scalable object storage.
- **AWS Key Management Service (KMS) & SSE-S3:** Employed for default encryption at rest.
- **AWS IAM (Identity and Access Management):** Used to define roles, conditions, and resource permissions for bucket access.

<br>

---

<br>

### 🏗️ Security Architecture & Lifecycle Flow

The diagram below illustrates how S3 security controls create multiple layers of defense:

```
                  ┌──────────────────────────────────────────────┐
                  │          Public/Unauthorized Users           │
                  └──────────────────────┬───────────────────────┘
                                         │
                                         ▼ (Blocks Access)
                  ┌──────────────────────────────────────────────┐
                  │           S3 Block Public Access             │
                  └──────────────────────┬───────────────────────┘
                                         │ (Allowed Principal?)
                                         ▼
                  ┌──────────────────────────────────────────────┐
                  │    S3 Bucket Policy (ArnNotLike Check)       │
                  └──────────────────────┬───────────────────────┘
                                         │ (IAM Role Verified)
                                         ▼
                  ┌──────────────────────────────────────────────┐
                  │    SSE-S3 (Server-Side Encryption at Rest)   │
                  └──────────────────────┬───────────────────────┘
                                         │ (Decrypts & Serves)
                                         ▼
                            ┌────────────────────────┐
                            │    S3 Bucket Objects   │
                            │  (Version 1, 2, 3...)  │
                            └────────────────────────┘
```

#### Object Versioning & Deletion Flow
When versioning is enabled, objects are protected against destructive deletions:
1. **Normal Deletion:** Hides the object and places a **Delete Marker** on top of the version stack.
2. **Recovery:** Removing the Delete Marker restores the latest version of the file to the active view.
3. **Permanent Deletion:** Only possible by explicitly passing the specific `Version ID` of the object during the delete request.

<br>

---

<br>

### ⚙️ Implementation Steps

#### 1. Enabled S3 Versioning & Version Uploads
- Created a new S3 bucket named `secure-bucket-lab-raphael` in the `us-east-1` region.
- In the bucket properties, enabled **Bucket Versioning**.
- To simulate standard file updates, uploaded three versions of the same file (`sensitive-data.txt`) sequentially:
  - **Version 1:** Original content containing initial data.
  - **Version 2:** Updated content representing a modified file.
  - **Version 3:** The latest content representing the final state of the file.
- Enabled the **Show Versions** toggle in the AWS S3 Console to verify that all three versions were saved with their respective unique Version IDs.

#### 2. Tested Accidental Deletion Recovery
- Navigated to the bucket objects view and deleted `sensitive-data.txt` under the standard interface (with "Show Versions" turned off).
- Observed that the file disappeared from the console list, mimicking an accidental deletion by a user.
- Enabled the **Show Versions** toggle to inspect the bucket history:
  - Found that the three original versions remained untouched.
  - Observed that a **Delete Marker** had been placed at the top of the version stack.
- Selected and deleted the **Delete Marker** object itself.
- Refreshed the page and verified that the file (`sensitive-data.txt`) was successfully restored to normal view, displaying the contents of Version 3.

#### 3. Configured Server-Side Encryption (SSE-S3)
- Scrolled to the **Default Encryption** section in the S3 Bucket Properties tab.
- Enabled encryption and selected **Server-Side Encryption with Amazon S3 Managed Keys (SSE-S3)**.
- Uploaded a new file (`encrypted-secrets.json`).
- Selected the newly uploaded file, viewed its properties, and verified that its encryption status was active and managed under SSE-S3.

#### 4. Implemented S3 Bucket Policy Restrictions
- Authored a resource-based S3 Bucket Policy to restrict access. The policy denies all S3 actions to any IAM principal whose ARN does *not* match the authorized IAM role (`PortfolioDevRole` in this lab).
- Applied the bucket policy in the S3 console.
- **Configured JSON Bucket Policy:**
```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "EnforceRoleBasedAccess",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::secure-bucket-lab-raphael",
                "arn:aws:s3:::secure-bucket-lab-raphael/*"
            ],
            "Condition": {
                "ArnNotLike": {
                    "aws:PrincipalArn": [
                        "arn:aws:iam::123456789012:role/PortfolioDevRole",
                        "arn:aws:iam::123456789012:root"
                    ]
                }
            }
        }
    ]
}
```
- Verified that other users, administrative roles, and unauthenticated principals were blocked from accessing, listing, or deleting files in the bucket, while the authorized role retained full access.

<br>

---

<br>

### 🛡️ Security Concepts Learned

#### S3 Versioning & Durability
- **Protection Against Accidental Deletion:** Versioning prevents the loss of critical files. If a file is deleted, it is simply hidden under a Delete Marker.
- **History Tracking:** Allows auditing of modifications over time, which is essential for code files, configuration sheets, or compliance documents.
- **Ransomware Mitigation:** If a ransomware attack attempts to encrypt files in S3, versioning preserves the unencrypted historical versions, allowing recovery without paying a ransom.

#### Delete Markers
- A Delete Marker is a placeholder object that has a key, a version ID, and a delete marker flag.
- It acts as the current version of the object when a user issues a standard delete request.
- Deleting the Delete Marker removes the marker and makes the previous version the current version again, restoring the file.

#### SSE-S3 Encryption
- **Data at Rest Protection:** Automatically encrypts objects when they are written to S3 and decrypts them when they are read.
- **Zero-Overhead Management:** Keys are fully managed, rotated, and protected by AWS.
- **Compliance Alignment:** Helps organizations meet regulatory frameworks (such as HIPAA, PCI-DSS, or GDPR) requiring encryption of personal data at rest.

#### Bucket Policies vs. IAM Policies
- **Resource-Based Policies:** Bucket policies are attached directly to S3. They are critical for enforcing account-level boundaries, public block access, or cross-account access rules.
- **Identity-Based Policies:** IAM policies are attached to users, groups, or roles. They define what that identity can do across multiple AWS services.
- **Combined Authorization:** The final permission is the intersection of both. If either policy has an explicit `Deny`, the request is denied. In this lab, the Bucket Policy enforced a strict `Deny` for any unauthorized principal, overriding any administrative IAM permissions they might have possessed.

<br>

---

<br>

### 💡 Key Takeaways

- **Versioning is Not a Backup Replacement:** While S3 Versioning protects against accidental file deletion and history changes, it does not protect against bucket deletion. Real disaster recovery requires replication (such as S3 Cross-Region Replication) to an isolated AWS backup account.
- **Encryption by Default:** In modern cloud architecture, default encryption should be enabled on all buckets. SSE-S3 is a cost-effective, low-latency method to secure data without managing keys. For highly sensitive data, SSE-KMS or SSE-C should be used to provide audit trails and customer-controlled rotation.
- **Layered Defense (Defense in Depth):** Relying solely on IAM policies is risky. A misconfigured IAM policy could easily grant global admin permissions to an identity. By applying a bucket policy that denies all access except for a specific role, we create a fallback safety net that limits the impact of IAM configuration drift.

<br>

---

<br>

### ⚠️ Challenges & Solutions

- **Understanding Delete Markers:**
  - *Challenge:* It was initially confusing why a deleted file still counted against S3 storage costs and didn't free up space.
  - *Solution:* Learned that in a version-enabled bucket, standard deletes do not free up space since all old versions and delete markers remain in the bucket. To free up space, historical versions must be deleted explicitly or managed via S3 Lifecycle Policies.
- **Avoiding Policy Lockouts:**
  - *Challenge:* Using a blanket `Deny` policy on `Principal: "*"` without excluding the root account or specific admin principals can result in locking everyone—including the administrator—out of the bucket.
  - *Solution:* Included the root account ARN (`arn:aws:iam::123456789012:root`) in the `ArnNotLike` condition list to ensure that the AWS Account root user or key administrator retains the ability to modify or delete the bucket policy if needed.
- **Resource-Based vs. Identity-Based Policies:**
  - *Challenge:* Figuring out how an administrator with administrative IAM permissions could still be denied access to the bucket.
  - *Solution:* Realized that an explicit `Deny` in a resource-based policy always overrides an `Allow` in an identity-based policy, confirming the primacy of the bucket policy for enforcing resource boundaries.

<br>

---

<br>

### 🧠 Skills Demonstrated

- **S3 Bucket Configuration:** Administered versioning, static hosting, and default encryption.
- **Data Protection Implementation:** Utilized version recovery and server-side encryption at rest.
- **Identity & Access Management (IAM):** Formulated complex JSON policies using `Deny`, `Principal`, and `Condition` keys.
- **Least-Privilege Security Design:** Enforced strict boundaries utilizing the `ArnNotLike` condition.
- **Cloud Security Best Practices:** Applied defense-in-depth principles to S3 buckets.

<br>

---

<br>

### 🎯 Outcome

By completing this lab, I successfully built a hardened S3 bucket that is resilient against data loss (via versioning), secures data at rest (via SSE-S3), and restricts access to a single authorized IAM role (via bucket policy). This layered security framework mirrors production environments, ensuring that sensitive data is protected against administrative mistakes and unauthorized access.

<br>

---

<br>

## 📸 Screenshot Section

### S3 Bucket Versioning Enabled
![S3 bucket with versioning enabled](../Week-05/Day%2003/Step%201%20-%20S3%20bucket%20with%20versioning%20enabled.png)
*Configuring the S3 bucket properties tab to enable versioning.*

---

### Object Version History
![Show versions toggle showing all 3 versions of my file](../Week-05/Day%2003/Step%202%20-%20Show%20versions%20toggle%20showing%20all%203%20versions%20of%20my%20file.png)
*Viewing the file version list in the S3 console with the "Show Versions" toggle active, exposing Version 1, 2, and 3.*

---

### Delete Marker Creation
![File disappears after delete (delete marker added)](../Week-05/Day%2003/Step%203%20-%20File%20disappears%20after%20delete%20%28delete%20marker%20added%29.png)
*Deleting the object under normal view, resulting in the creation of a Delete Marker at the top of the version stack.*

---

### Object Restoration
![File restored after removing delete marker](../Week-05/Day%2003/Step%204%20-%20File%20restored%20after%20removing%20delete%20marker.png)
*Deleting the Delete Marker itself, successfully restoring the latest active version of the file.*

---

### SSE-S3 Encryption Properties
![File properties showing SSE-S3 encryption](../Week-05/Day%2003/Step%205%20-%20File%20properties%20showing%20SSE-S3%20encryption.png)
*Verifying in the object properties panel that Server-Side Encryption (SSE-S3) is active on the uploaded file.*

---

### S3 Bucket Policy Applied
![Bucket policy applied in console](../Week-05/Day%2003/Step%206%20-%20Bucket%20policy%20applied%20in%20console.png)
*Applying the JSON bucket policy with the ArnNotLike condition in the S3 Permissions console tab.*

<br>

---

<br>

### 📅 Progress Tracker
- [x] **Week 5 Day 3 Completed** ✅

---

<div align="center">

| [« Previous Day: S3 Storage Classes & Lifecycle](./day-22.md) | [Next Day: N/A »](#) |

</div>
