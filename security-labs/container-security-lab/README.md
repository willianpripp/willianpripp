# Container Security Research Lab (K3s + Trend Micro Vision One)

## 🎯 Project Objective
This project provides a complete, automated environment for researching container security. It automates the setup of a Kubernetes (K3s) cluster, the deployment of a professional security stack (Trend Micro Vision One), and the execution of real-world attack simulations to test detection and prevention capabilities.

The goal is to provide a hands-on lab to observe how security agents behave when confronted with malware, unauthorized file modifications, credential theft, and known vulnerabilities.

## 🏗 Lab Architecture
- **Host:** Ubuntu Server (Virtualized or Bare Metal).
- **Cluster:** Lightweight Kubernetes (K3s).
- **Security Engine:** Trend Micro Vision One Container Security (Scout, Metacollector, Workload-Operator).
- **Control Plane:** Remote orchestration from a local terminal (e.g., Kali Linux) using `sshpass` and `kubectl`.

## 🛡 Security Test Cases
| Feature | Simulation Action | Observed Outcome |
| :--- | :--- | :--- |
| **Runtime Security** | Reverse shells, Host-mount escapes, `kubectl exec` | Behavioral blocking & telemetry |
| **Malware Defense** | EICAR, Dropper scripts, & Compressed malware | Signature & Behavioral detection |
| **FIM** | `/etc/hosts` tampering & Critical file deletion | Baseline divergence alerts |
| **Secret Scanning** | AWS Keys (Env) & SSH Keys/GCP Keys (Files) | Static & Deep file scanning |
| **Vulnerability Mgmt**| Scanning known-vulnerable images (Metasploit) | CVE mapping & Risk scoring |

## 🚀 Quick Start
1. **Prepare Server:** Follow the `Environment Setup Guide` in `context.md` to install K3s and Helm.
2. **Deploy Security:** Run `./install_agent.sh` (Requires Vision One `overrides.yaml`).
3. **Run Attacks:** Execute `./run_simulations.sh` to deploy the threat suite.
- **Analyze:** Use `./export_logs.sh` to pull raw security telemetry for review.
- **Evidence:** Exported logs (`.log` files) serve as forensic artifacts for documentation and project validation.

## 📊 Artifacts & Evidence
One of the key features of this lab is the ability to export and showcase real security telemetry. The repository is designed to generate:
- **Detection Logs:** Raw JSON/Text evidence of malware and policy violations.
- **Scan Reports:** Status summaries of vulnerability and secret scanning.
- **Forensic Artifacts:** Local copies of agent-side events, perfect for showcasing results on GitHub or in security reports.

## 📁 Repository Structure
...

## 🗺️ Roadmap & Future Integrations
This lab is the first phase of a larger SOC engineering project. Future phases include:
- **Elastic SIEM Integration:** Automating the ingestion of these generated logs into Elastic Search.
- **Detection Engineering:** Developing custom KQL rules and alerts based on the telemetry captured in this lab.
- **Dashboarding:** Building a Kibana dashboard specifically for container runtime threats.

---
*This lab is designed for security education and tool validation.*
