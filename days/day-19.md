<div align="center">

# ☁️ Week 4 · Day 4 — Auto Scaling & Load Balancing

*Today focused on designing and configuring scalable, highly available infrastructure on AWS. I configured an Application Load Balancer (ALB) and an Auto Scaling Group (ASG) across multiple Availability Zones using a CPU-based Target Tracking policy. This architecture ensures that the web application automatically handles traffic fluctuations, supports self-healing for unhealthy instances, and distributes load efficiently.*

</div>

---

<br>

### 🔑 Key Concepts Covered

- **Auto Scaling Group (ASG):** Automatically adjusts the number of EC2 instances to maintain performance and optimize costs based on demand metrics and capacity limits.
- **Application Load Balancer (ALB):** A Layer 7 load balancer that inspects traffic at the application level and routes HTTP/HTTPS requests to registered targets based on path, host, or header rules.
- **Launch Template:** A configuration template containing instance parameters (AMI, instance type, security groups, key pairs, and user data bootstrap scripts) used by ASGs to launch uniform instances.
- **Target Groups & Health Checks:** Target groups contain the registered EC2 backend instances. The ALB monitors their status via configured health check paths (e.g. `/index.html`) to ensure requests are only sent to healthy nodes.
- **Target Tracking Scaling Policy:** Dynamically scales instance capacity in response to real-time workload changes, aiming to keep a specific CloudWatch metric (e.g., average CPU utilization) at a target value (such as 50%).
- **Multi-AZ Architecture:** Distributing instances and ALB interfaces across multiple Availability Zones to prevent a single point of failure and guarantee high availability.

<br>

---

<br>

### 🏢 Real-World Application: Lagos Fintech Scaling (Paystack)

Fintech systems like Paystack handle massive traffic volumes that peak heavily during Lagos month-end payday windows. To maintain high availability while remaining cost-effective:

- **ALB Traffic Distribution:** The system uses an Application Load Balancer to route incoming transaction API queries to multiple application servers distributed across different Availability Zones.
- **Elastic Target Tracking:** As transaction request counts rise, CPU utilization climbs. Target tracking policies automatically spin up more EC2 instances to process the workload without manual operations.
- **Predictive Scaling:** Machine learning models forecast expected load patterns based on historical transaction history, proactively scaling out instance capacity before the high-traffic hours hit.
- **Self-Healing Infrastructure:** Unhealthy instances that fail payment gateway processing health checks are terminated, and the ASG replaces them automatically, minimizing transactional downtime.

<br>

---

<br>

### 🧠 SAA-C03 Exam Insights & Deep Dive

- **ALB vs. NLB Differences:**
  
  | Feature | Application Load Balancer (ALB) | Network Load Balancer (NLB) |
  | :--- | :--- | :--- |
  | **OSI Layer** | Layer 7 (Application) | Layer 4 (Transport) |
  | **Protocols** | HTTP, HTTPS, gRPC | TCP, UDP, TLS |
  | **Routing Decisions** | Path, hostname, HTTP headers, query parameters | IP address, port, TCP/UDP connection state |
  | **Latency** | Milliseconds (slower due to deep packet inspection) | Microseconds (extremely fast, handles millions of RPS) |
  | **Static IP Support** | Dynamic IPs (resolves via DNS hostname) | Supports assigning Static/Elastic IPs per subnet |

- **Connection Draining (Deregistration Delay):**
  - Prevents active users from experiencing connection drops when an instance is being scaled in or marked unhealthy.
  - The load balancer stops sending new requests to the instance but allows existing, in-flight requests to complete during a configurable timeout (default: 300 seconds).
- **Reactive vs. Proactive Scaling:**
  - Auto Scaling is primarily reactive, meaning capacity adjustment lags behind the metric breach. To mitigate lag during sudden, sharp spikes, engineers configure **Predictive Scaling** or step scaling policies.

<br>

---

<br>

### ⚠️ Common Mistakes & Exam Traps

- ❌ **Assuming Instant Scaling:** Scaling is not instantaneous. Instances require time to spin up and complete boot scripts. Design buffer capacity by setting lower metric thresholds (e.g., 50% CPU target).
- ❌ **Routing Traffic Directly to instances in ASG:** Direct connections bypass load balancing. Clients must always hit the ALB DNS name to achieve load distribution and failover protection.
- ❌ **Single Availability Zone Configurations:** Deploying an ALB or ASG in a single Availability Zone lacks resilience. Always span at least two subnets across distinct Availability Zones.
- ❌ **Community AMIs in Production:** Standardizing Launch Templates on community AMIs presents security risks. Utilize custom AMIs built from secured, baseline configurations.

<br>

---

<br>

### 🏗️ Key Architectural Flow

```
Client Request → Route 53/DNS → ALB → Healthy EC2 Instances → CloudWatch Metrics → ASG Scaling Decisions
```

<br>

---

<br>

### 🧠 Reflection

Today reinforced the importance of elasticity in cloud architecture. I learned how AWS automatically scales infrastructure based on demand while maintaining availability through load balancing and health checks. Seeing multiple instances launch and serve traffic dynamically made the concept of highly available cloud systems feel practical and real.

<br>

---

<br>

### 🚀 Key Lessons Learned

- **Static Infrastructure is Inefficient:** Fixed-capacity servers run idle during low periods and cause service failure during traffic surges.
- **Elasticity Equals Cost Optimization:** Dynamic scaling ensures capacity matches workload demand, optimizing infrastructure costs.
- **ALB and Target Groups:** Routing traffic only to healthy instances ensures seamless end-user experiences.
- **Self-Healing Infrastructure:** Automating health checks allows AWS to detect and replace failed nodes with zero manual intervention.
- **Target Tracking Simplicity:** Target tracking provides the simplest way to manage capacity based on resource utilization targets like CPU.
- **Connection Draining is Vital:** Graceful termination of targets prevents active session disruptions during scale-in operations.
- **Multi-AZ is Non-Negotiable:** Distributing resources across multiple Availability Zones is critical for building resilient, production-grade cloud architectures.

<br>

---

<br>

## 🛠️ Lab Tasks Completed

### Hands-On Activities

1. **Created a Launch Template:**
   - Configured a reusable launch configuration utilizing **Amazon Linux 2 AMI** and `t2.micro` instances.
   - Assigned the `web-server-key` key pair and the `SG-WebLab` security group.
   - Configured the following User Data bootstrap script to install Apache (`httpd`) and serve a custom homepage showcasing the instance's unique hostname:
     ```bash
     #!/bin/bash
     yum install -y httpd
     systemctl start httpd
     echo "<h1>Served from instance: $(hostname -f)</h1>" > /var/www/html/index.html
     ```
2. **Created Application Load Balancer (ALB):**
   - Configured an internet-facing ALB connected to both public subnets for multi-AZ high availability.
   - Configured the HTTP listener on Port 80, assigned the `SG-LoadBalancer` security group, and routed connections to the `WebServers-TG` target group.
3. **Created Auto Scaling Group:**
   - Initialized the `WebApp-ASG` utilizing the launch template.
   - Configured scaling limits: **Desired Capacity: 2**, **Minimum Capacity: 1**, and **Maximum Capacity: 4**.
   - Enabled ELB-based health checks and added a Target Tracking Scaling Policy targeting a 50% CPU utilization threshold.
4. **Tested Load Balancing and Scaling:**
   - Confirmed that the ASG launched two healthy instances across different AZs.
   - Accessed the ALB DNS name and refreshed the page, verifying round-robin traffic distribution as the hostnames updated dynamically.
   - Observed that all health checks passed successfully.
5. **Completed Resource Cleanup:**
   - Deleted the Auto Scaling Group (which automatically terminated all active instances).
   - Deleted the Application Load Balancer and Target Group to prevent unnecessary AWS charges.

### ⚡ Bonus Challenge Completed — Advanced Scaling & Load Balancing

- **Predictive Scaling:** Researched how machine learning evaluates historical scaling trends and forecasts future demand, proactively launching EC2 instances ahead of scheduled spikes (e.g., month-end payday traffic) to prevent reactive scaling delays.
- **Connection Draining (Deregistration Delay):** Investigated the mechanism that keeps a deregistering target active for in-flight requests while blocking any new connections, preventing session disruption during scale-in events.
- **Load Balancer Differences (ALB vs. NLB):** Explored how ALB operates at Layer 7 (best for HTTP/HTTPS routing, microservices, path-based routing) while NLB operates at Layer 4 (best for ultra-low latency, handling millions of requests per second, TCP/UDP traffic, and static IPs).
- **Handling Sudden Traffic Spikes:** Studied how scaling works during rapid spikes and how step scaling or scaling based on custom CloudWatch metrics helps mitigate lag.

<br>

---

<br>

## 📸 Screenshot Section

### Auto Scaling Group Running Instances
![Auto Scaling Group showing 2 running instances](../Week-04/Day%2004/Auto%20Scaling%20Group%20showing%202%20running%20instances.png)

---

### Load Balancer Active State
![Load Balancer Active State](../Week-04/Day%2004/Load%20Balancer%20showing%20Active%20state.png)

---

### Dynamic Load Balancing (Served from Different Hostnames)
![Dynamic Traffic Distribution](../Week-04/Day%2004/Browser%20showing%20traffic%20from%20different%20hostnames.png)

---

### Auto Scaling Group Activity History
![ASG Activity History](../Week-04/Day%2004/ASG%20activity%20history.png)

---

### Target Group Healthy Instances
![Target Group Healthy Instances](../Week-04/Day%2004/Target%20Group%20healthy%20instances.png)

---

### Lab Cleanup
![Lab Cleanup](../Week-04/Day%2004/Cleanup%20screenshots.png)

<br>

---

<br>

### 📅 Progress Tracker
- [x] **Week 4 Day 4 Completed** ✅
