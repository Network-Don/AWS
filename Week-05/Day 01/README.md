<div align="center">

# ☁️ Week 5 · Day 1 — Create an S3 Bucket & Host a Static Website

*Today's lab focused on Amazon S3 fundamentals, specifically creating an Amazon Simple Storage Service (S3) bucket, configuring public access permissions, and enabling static website hosting. I successfully designed and deployed a serverless student portfolio website displaying projects and skills from Weeks 1–4, and verified its global availability using the S3 website endpoint.*

</div>

---

<br>

### 📖 Lab Overview

This hands-on lab demonstrated how to host a serverless static website using Amazon Simple Storage Service (S3). S3 is object storage built to store and retrieve any amount of data from anywhere, offering 99.999999999% (11 9s) of data durability. 

The lab walked through configuring bucket-level security permissions to transition from S3's default "private-by-default" security posture to a public website hosting configuration. This process involves two critical controls: disabling Block Public Access (BPA) at the bucket level and applying a bucket-level JSON resource policy to permit public read operations (`s3:GetObject`).

<br>

---

<br>

### 🎯 Objectives

- **Create a globally unique S3 bucket:** Provision a new storage bucket in a designated AWS Region with a unique DNS-compliant name.
- **Configure public access controls:** Adjust S3 security settings by disabling Block Public Access parameters.
- **Apply a secure bucket policy:** Write and attach a JSON resource policy allowing public read access to all objects.
- **Enable Static Website Hosting:** Configure the S3 bucket's website properties and define the entry files.
- **Deploy and verify portfolio site:** Upload static assets (`index.html`) and test access via the public S3 website endpoint URL.

<br>

---

<br>

### 🔑 Key Concepts Covered

- **Amazon S3 (Simple Storage Service):** High-performance, highly durable, and scalable object storage. S3 stores data as objects within containers called buckets.
- **Global Namespace:** S3 bucket names must be globally unique across all AWS accounts and regions. The name is used as part of the DNS endpoint URL.
- **Object Storage vs. Block Storage:** Unlike block storage (like EBS), which is formatted and mounted as a local filesystem by a operating system, S3 stores files as flat objects containing data, metadata, and a unique key (path).
- **Static Website Hosting:** A native S3 feature that allows serving client-side content (HTML, CSS, JavaScript, images, and audio/video) directly to web browsers without running any backend application servers.
- **Block Public Access (BPA):** A critical S3 safety control that blocks all public permissions by default. This must be explicitly disabled to allow public read access for website hosting.
- **S3 Bucket Policy:** A resource-based IAM policy written in JSON that defines permissions for the bucket and its objects, allowing or denying access based on principals, actions, and resources.

<br>

---

<br>

### ⚙️ Implementation Steps

1. **Provision S3 Bucket:**
   - Logged into the AWS Management Console and navigated to the Amazon S3 service dashboard.
   - Clicked **Create bucket** and entered a globally unique name.
   - Selected the preferred AWS Region.
   - Unchecked the **Block *all* public access** option under the *Block Public Access settings for this bucket* section to allow public website access.
   - Checked the acknowledgment warning box indicating that the bucket's objects may become publicly readable.
   - Left bucket versioning and encryption at default settings, then clicked **Create bucket**.

2. **Enable Static Website Hosting:**
   - Navigated to the newly created bucket, opened the **Properties** tab, and scrolled to the bottom.
   - Clicked **Edit** under *Static website hosting*.
   - Selected **Enable** and chose **Host a static website** as the hosting type.
   - Specified `index.html` as the **Index document** and `index.html` (or `error.html` if available) as the **Error document**.
   - Saved changes and noted the automatically generated S3 static website endpoint URL.

3. **Upload Web Portfolio Assets:**
   - Created a clean, responsive HTML file named `index.html` representing a student portfolio site.
   - **Portfolio Details:**
     - Included project summaries for Weeks 1–4:
       - **Custom VPC** with 4 subnets and security groups (Week 3)
       - **EC2 auto-scaling web server** (Week 4)
       - **IAM architecture** for a 3-tier team (Week 2)
       - **CloudTrail audit logging setup** (Week 2)
     - Created a **Skills** section highlighting: *EC2, S3, VPC, IAM, CloudTrail, Auto Scaling, and EBS*.
   - Navigated to the **Objects** tab of the bucket and clicked **Upload**.
   - Added `index.html` to the upload queue and clicked **Upload** to store it.

4. **Attach S3 Bucket Policy:**
   - Navigated to the **Permissions** tab and clicked **Edit** in the *Bucket policy* section.
   - Entered the following JSON policy to allow anonymous public read access (`s3:GetObject`) to all objects in the bucket:
     ```json
     {
         "Version": "2012-10-17",
         "Statement": [
             {
                 "Sid": "PublicReadGetObject",
                 "Effect": "Allow",
                 "Principal": "*",
                 "Action": "s3:GetObject",
                 "Resource": "arn:aws:s3:::<your-bucket-name>/*"
             }
         ]
     }
     ```
   - *Note: Replaced `<your-bucket-name>` with the exact name of the S3 bucket.*
   - Saved the policy, resulting in the bucket displaying a red `Public` badge.

5. **Test Web Accessibility:**
   - Copied the S3 website endpoint URL from the Properties tab.
   - Opened a web browser and navigated to the URL.
   - Verified the portfolio site loaded successfully and was fully accessible from the public internet.

<br>

---

<br>

### 🏗️ Architecture & Visual Flow

```
Internet User ──(HTTP Request via Port 80)──> S3 Website Endpoint ──> S3 Bucket [Public Read] ──> index.html
```

- **User Access:** The client initiates a request to the S3 website endpoint URL.
- **DNS Resolution:** S3 routes the request to the regional S3 static website hosting server.
- **Access Control Check:** S3 verifies that Block Public Access is disabled and that the attached Bucket Policy permits anonymous HTTP GET access.
- **Content Delivery:** S3 serves `index.html` directly to the client's browser, completely bypasssing the need for a web server instance.

<br>

---

<br>

### 🚀 Key Lessons Learned

- **Serverless Frontend Hosting:** Hosting static websites on S3 removes the need to provision, secure, patch, and monitor EC2 instances or other servers, drastically reducing administrative overhead.
- **Two-Step Public Authorization:** Making S3 assets public requires two active gates:
  1. The bucket/account-level **Block Public Access** settings must be turned off.
  2. A **Bucket Policy** must explicitly authorize `s3:GetObject` actions for anonymous or public principals (`*`).
- **Unmatched Durability and Availability:** S3 stores object data redundantly across a minimum of three physical Availability Zones within an AWS Region, delivering 99.999999999% durability.
- **Cost Efficiency:** S3 website hosting is one of the most cost-effective hosting methods on AWS, as you only pay for stored bytes and outbound data transfer.
- **Key-Value Paradigm:** Unlike directory structures in standard filesystems, S3 uses flat namespaces where folders are represented by metadata prefix keys inside the object's name.

<br>

---

<br>

### ⚡ Bonus Challenge — Multi-Page Static Website

For the bonus challenge, I expanded the portfolio website into a multi-page static site to demonstrate website structuring and navigation capabilities within S3.

#### Implementation Steps:
1. **Created a Secondary Page:** Authored a second file called `labs.html` listing all completed AWS Cloud Accelerator labs in detail.
2. **Linked the Pages:** Added a navigation link in `index.html` leading to `labs.html`, and a return link in `labs.html` pointing back to `index.html`.
3. **Uploaded Assets:** Uploaded the new `labs.html` file and the updated `index.html` file to the S3 bucket.
4. **Verified Navigation:** Accessed the website endpoint URL and successfully navigated between the home page and the labs page using the links.

#### Benefits of Multi-Page Static Sites:
- **Enhanced Content Organization:** Spreads content logically across pages instead of overcrowding a single page.
- **Improved User Experience:** Makes portfolio navigation cleaner and easier for viewers.
- **Professional Presentation:** Mimics professional corporate and portfolio site structures.
- **Demonstrates Structure Knowledge:** Confirms understanding of asset routing, linking paths, and multi-object uploads in an S3-based frontend structure.

<br>

---

<br>

## 📸 Screenshot Section

### S3 Bucket Created with Static Website Hosting Enabled
![S3 bucket created with static website hosting enabled](./Step%201%20-%20S3%20bucket%20created%20with%20static%20website%20hosting%20enabled.png)
*Creating the globally unique S3 bucket, disabling the default Block Public Access configuration, and enabling static website hosting in the Properties tab.*

---

### index.html Successfully Uploaded
![index.html successfully uploaded](./Step%202%20-%20index.html%20successfully%20uploaded%20%28showing%20in%20bucket%20contents%29.png)
*Uploading the portfolio landing page file (index.html) to the objects listing inside the S3 bucket.*

---

### Bucket Policy Applied
![Bucket policy applied](./Step%203%20-%20Bucket%20policy%20applied%20%28public%20read%29.png)
*Applying the S3 bucket policy permitting public s3:GetObject read permissions for anonymous users, marking the bucket with a public tag.*

---

### Portfolio Page Live in Browser
![Portfolio page live in browser showing S3 website endpoint URL](./Step%204%20-%20Portfolio%20page%20live%20in%20browser%20showing%20S3%20website%20endpoint%20URL.png)
*Accessing the live student portfolio page via the S3 static website hosting endpoint URL in a web browser.*

---

### Bonus Challenge: Link Added to index.html
![Bonus Challenge - second link added to index.html](./Bonus%20Challenge%20-%20%20second%20link%20added%20to%20index.html..png)
*Adding the navigation link targeting the secondary labs page within the index.html file.*

---

### Bonus Challenge: Live labs.html Page
![Bonus Challenge - second page from the index.html](./Bonus%20Challenge%20-%20second%20page%20from%20the%20index.html.png)
*Navigating to the active labs.html subpage directly from the S3 static website endpoint, showing all completed cohort labs.*

<br>

---

<br>

### 📅 Progress Tracker
- [x] **Week 5 Day 1 Completed** ✅

---

<div align="center">

| [« Previous Day: EC2 Storage — EBS & Instance Store](../../Week-04/Day%2005/README.md) | [Next Day: S3 Storage Classes & Lifecycle](../Day%2002/README.md) » |
| :---: | :---: |

</div>
