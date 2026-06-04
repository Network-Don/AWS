<div align="center">

# ☁️ Week 4 · Day 5 — EC2 Storage — EBS & Instance Store

*Today's lab focused on configuring, mounting, and managing EC2 block storage. I explored the differences between persistent network-attached storage (Amazon EBS) and ephemeral local storage (Instance Store). I attached a new EBS volume to an EC2 instance, formatted and mounted it, wrote persistent data, created an EBS snapshot, simulated a data loss event, and successfully restored the files from the snapshot.*

</div>

---

<br>

### 📖 Lab Overview

This hands-on lab demonstrated how to manage block storage on AWS. It covered provisioning Amazon Elastic Block Store (EBS) volumes, attaching them to EC2 instances, and configuring them within the Linux OS. The lab also illustrated how to use EBS snapshots as an incremental backup strategy to protect critical data from accidental loss or corruption, showing the lifecycle difference between persistent EBS volumes and temporary Instance Store volumes.

<br>

---

<br>

### 🎯 Objectives

- **Provision EBS volumes:** Create and configure a 5GB Amazon EBS volume in the same Availability Zone as the EC2 instance.
- **Attach and mount volumes:** Connect the block storage to an EC2 instance and format it using the `ext4` filesystem.
- **Verify data persistence:** Write sample data to the volume and verify its integrity.
- **Create point-in-time backups:** Create an EBS snapshot of the volume.
- **Demonstrate disaster recovery:** Simulate data loss by deleting the volume and then restoring the files from the EBS snapshot.

<br>

---

<br>

### 🔑 Key Concepts Covered

- **Amazon EBS (Elastic Block Store):** High-performance block storage volumes designed for use with Amazon EC2. They are network-attached and persist independently of the instance lifecycle.
- **EC2 Instance Store:** Temporary (ephemeral) physical block-level storage that is directly attached to the host computer. It offers low latency but does not survive instance stop, hibernation, or termination.
- **EBS Snapshots:** Incremental, point-in-time backups of EBS volumes stored in Amazon S3, allowing simple volume restoration and replication across Availability Zones.
- **Block Device Management:** Using Linux utilities like `lsblk` and `df` to manage block devices and view filesystem mount points.
- **Formatting and Mounting:** Creating a filesystem structure (e.g., ext4) on a raw block device and mounting it to a directory tree to make it accessible to the OS.

<br>

---

<br>

### ⚙️ Implementation Steps

1. **Create and Attach EBS Volume:**
   - Created a 5GB General Purpose SSD (`gp3`) volume in `us-east-1a` (matching the AZ of the running EC2 instance).
   - Attached the volume to the instance as `/dev/sdf`.
2. **Format and Mount the Volume:**
   - Connected to the instance via SSH.
   - Listed block devices using `lsblk` to verify that `xvdf` was visible.
   - Formatted the volume using `sudo mkfs -t ext4 /dev/xvdf`.
   - Created a mount directory using `sudo mkdir /data`.
   - Mounted the volume using `sudo mount /dev/xvdf /data` and verified using `df -h`.
3. **Write and Verify Data:**
   - Created a text file inside `/data` to act as persistent data: `echo "AWS EBS persistent storage demo" | sudo tee /data/mydata.txt`.
   - Verified the content was written successfully using `cat /data/mydata.txt`.
4. **Create an EBS Snapshot:**
   - From the AWS EC2 Console, selected the volume and created a snapshot named `EBS-Lab-Snapshot`.
   - Monitored the snapshot status until it reached the `Completed` state.
5. **Simulate Loss & Restore Data:**
   - Unmounted the volume and deleted it to simulate a drive failure or accidental deletion.
   - Created a new EBS volume from the snapshot.
   - Attached the restored volume to the EC2 instance.
   - Mounted the restored volume back to `/data`.
   - Verified that the original file `mydata.txt` was fully restored and intact with the correct contents.

<br>

---

<br>

### 🚀 Key Lessons Learned

- **AZ Constraint:** EBS volumes are geographically locked to a single Availability Zone. An instance in `us-east-1a` cannot mount a volume in `us-east-1b`.
- **Global Snapshot Reach:** While EBS volumes are locked to an AZ, EBS snapshots are stored in S3 and can be used to restore volumes in *any* AZ within the region.
- **Incremental Snapshots:** AWS only charges for the modified blocks in subsequent snapshots, reducing storage costs.
- **Ephemeral vs. Persistent:** EBS is ideal for databases and critical source code since it survives instance stops/starts. Instance Store is ideal for caching, temporary storage, and transient data.

<br>

---

<br>

### ⚡ Bonus Challenge – EBS vs Instance Store

#### EBS vs Instance Store Comparison

| Feature                   | Amazon EBS                                              | EC2 Instance Store                                  |
| ------------------------- | ------------------------------------------------------- | --------------------------------------------------- |
| Storage Type              | Network-attached block storage                          | Physically attached local storage                   |
| Persistence               | Persistent beyond instance stop/start                   | Ephemeral (temporary)                               |
| Data Survives Reboot      | Yes                                                     | Yes                                                 |
| Data Survives Stop        | Yes                                                     | No                                                  |
| Data Survives Termination | Depends on DeleteOnTermination setting                  | No                                                  |
| Snapshot Support          | Yes (EBS Snapshots)                                     | No                                                  |
| Backup Capability         | Native snapshot backup and restore                      | Must be replicated externally                       |
| Performance               | High performance, scalable                              | Very low latency and high throughput                |
| Best Use Cases            | Databases, application data, operating systems, backups | Cache, buffers, temporary processing, scratch space |
| Encryption Support        | Yes (KMS)                                               | Not natively managed like EBS                       |

#### Instance Type Example Using Instance Store

**i3.large** (Storage Optimized family) includes local NVMe SSD Instance Store volumes designed for workloads requiring extremely fast I/O performance.

#### When to Use Instance Store Instead of EBS

Use Instance Store when:
- Data can be recreated if lost
- Extremely high-speed local storage is required
- Workloads use temporary files, caches, or buffers
- Data is replicated elsewhere

Examples:
- Application caching layers
- Temporary fraud-analysis processing data
- High-performance scratch storage

#### When EBS Should Be Used

Use EBS whenever data durability is required:
- Databases
- Customer uploads and payment records
- Application source code
- Critical business data
- Backup and recovery workflows

#### Key Takeaways

- EBS provides persistent storage that survives instance lifecycle events and supports snapshots for backup and disaster recovery.
- Instance Store delivers very fast local storage but loses data when instances are stopped, hibernated, or terminated.
- Production databases should use EBS rather than Instance Store.
- Backup strategies should always include tested snapshot restores.

<br>

---

<br>

## 📸 Screenshot Section

### Step 1: EBS Volume Attached and Showing in lsblk
![Step 1 - EBS volume attached](./Step%201%20-%20EBS%20volume%20attached%20and%20showing%20in%20lsblk%20output.png)
*Verifying that the newly attached 5GB EBS volume (xvdf) appears in the block devices list on the Linux EC2 instance.*

---

### Step 2: Filesystem Mounted and Verified
![Step 2 - df -h output](./Step%202%20-%20df%20-h%20showing%20data%20mounted%20with%205GB.png)
*Confirming that the volume has been formatted with the ext4 filesystem and mounted to the /data directory.*

---

### Step 3: Writing Sample Data to Mounted Directory
![Step 3 - Writing data](./Step%203%20-%20cat%20datamydata.txt%20showing%20my%20written%20content.png)
*Verifying that the file mydata.txt has been successfully created and written to the persistent storage.*

---

### Step 4: Creating EBS Snapshot in AWS Console
![Step 4 - EBS Snapshot Completed](./Step%204%20-%20EBS%20snapshot%20status%20Completed.png)
*Confirming that the incremental point-in-time snapshot backup has successfully reached the 'Completed' state in the AWS console.*

---

### Step 5: Restoring Data from Snapshot
![Step 5 - restored volume content](./Step%205%20-%20same%20content%20on%20restored%20volume.png)
*Confirming successful data recovery. The new volume created from the snapshot contains the exact same data as the original volume.*

<br>

---

<br>

### 📅 Progress Tracker
- [x] **Week 4 Day 5 Completed** ✅

---

<div align="center">

| [« Previous Day: Auto Scaling & Load Balancing](../Day%2004/README.md) | [Next Day: N/A »](../../README.md) |
| :---: | :---: |

</div>
