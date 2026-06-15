# Automated GitOps CI/CD Pipeline with Live Infrastructure Monitoring

This repository demonstrates a production-ready, self-hosted GitOps automation and observability architecture implemented on an AWS cloud environment. Taking a decoupled frontend e-commerce storefront application, the entire infrastructure, delivery pipeline, containerization strategy, and telemetry stack were built from scratch to establish an enterprise-grade deployment lifecycle.

---

## 🏗️ System Architecture Overview

The system architecture features local automation and telemetry hosted completely on a single cloud server instance to minimize external dependencies and manage infrastructure footprints effectively.

* **Source Code Management:** Version Control via GitHub.
* **Continuous Integration & Deployment (CI/CD):** Self-hosted Jenkins Engine running localized automation scripts.
* **Containerization Engine:** Docker Engine executing optimized multi-stage build layers.
* **Web Server Architecture:** High-performance static routing handled via custom Nginx container rules.
* **Telemetry & Observability Stack:** Prometheus metrics collection engine coupled with Grafana visualization panels.

---

## 🛠️ Core Infrastructure & Tool Stack

* **Hosting Environment:** AWS EC2 (Ubuntu 24.04 LTS Engine)
* **Automation Automation Server:** Jenkins (LTS Release running on Java 21)
* **Container Lifecycle Management:** Docker Core Engine
* **Production Distribution Web Server:** Nginx (Stable-Alpine Base)
* **System Telemetry Collector:** Prometheus Node Exporter (Port 9100)
* **Metrics Scraper Database:** Prometheus Core Engine (Port 9090)
* **Observability Dashboard:** Grafana Server (Port 3000)

---

## 🐳 Containerization & Optimization Strategy

To move away from resource-heavy runtime environments, the application delivery structure leverages a strict **Multi-Stage Docker Build**. 

1. **Compilation Phase (Stage 1):** A temporary Node.js 20 environment pulls workspace files, installs locked vendor dependencies using `npm ci`, and executes production static bundling (`npm run build`).
2. **Execution Phase (Stage 2):** The heavy Node development runtime, code frameworks, and source dependencies are completely dropped. The compiled production bundle is transferred directly into an ultra-lightweight Nginx container instance, running static routing rules via a custom `nginx.conf` handler to resolve single-page application routing.

**Impact:** Dramatically minimized attack surfaces and optimized container memory footprints for performance efficiency.

---

## ⚙️ Automated Continuous Deployment Pipeline

The delivery engine maps configuration as code using a **Declarative Jenkinsfile Pipeline**. The automation loop processes tasks through distinct lifecycle stages:

```groovy
// Pipeline Stage Configuration Summary
// Stage 1: Workspace Initialization -> Clones targeted VCS branch dynamically
// Stage 2: Configuration Validation -> Assures multi-stage structural files exist
// Stage 3: Container Layer Build -> Compiles application bundle inside an isolated image
// Stage 4: Zero-Downtime Deployment -> Safely recycles application containers on Port 80
