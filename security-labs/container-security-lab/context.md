# Project Context: Container Security Research Lab

## Lab Objectives
The primary goal of this lab is to provide a reproducible environment for testing the efficacy of container security tools. By combining a real-world Kubernetes distribution (K3s) with a suite of automated attack simulations, we can observe, capture, and document security events across multiple vectors (Runtime, Malware, FIM, and Vulnerabilities).

## Project Structure & File Manifest

### Orchestration Scripts
- **`run_simulations.sh`**: Remote orchestration to deploy the attack suite to the K3s cluster.
- **`cleanup_simulations.sh`**: Reset the lab by purging all simulation resources.
- **`export_logs.sh`**: Harvests raw security evidence from the agent for forensic review.
- **`install_agent.sh` / `modify_agent.sh`**: Lifecycle management for the security stack.

### Security Test Cases (YAML)
- **Vulnerabilities**: `vulnerable-pod.yaml` (Metasploit image scanning).
- **Credential Theft**: `secret-pod.yaml` (AWS Key exposure).
- **Malware**: `malware-pod.yaml` (EICAR delivery).
- **File Integrity**: `fim-pod.yaml` & `fim-advanced-tests.yaml` (Critical system file tampering).
- **Compliance**: `compliant-pod.yaml` (Gold standard configuration verification).

---

## Environment Setup Guide (From Scratch)

### 1. Ubuntu Server Preparation
Update the host and synchronize time (critical for log correlation).
```bash
sudo apt update && sudo apt upgrade -y
sudo timedatectl set-timezone America/Sao_Paulo
```

### 2. Install K3s (Kubernetes)
```bash
curl -sfL https://get.k3s.io | sh -
sudo chmod 644 /etc/rancher/k3s/k3s.yaml
echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" >> ~/.bashrc
source ~/.bashrc
```

### 3. Install Helm & Security Agent
```bash
# Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Trend Micro Agent
helm install trendmicro \
  --namespace trendmicro-system --create-namespace \
  --values overrides.yaml \
  https://github.com/trendmicro/visionone-container-security-helm/archive/main.tar.gz
```

### 4. Remote Simulation Setup
On your local machine (e.g., Kali Linux):
```bash
sudo apt install sshpass -y
chmod +x *.sh
```

---

## Commonly Used Commands

### Checking Agent Health
```bash
kubectl get pods -n trendmicro-system
# Check the 'Scout' logs for real-time detections
kubectl logs -n trendmicro-system -l app=trendmicro-scout -c scout -f
```

### Verifying Simulation Results
1. Run `./run_simulations.sh`.
2. Wait 2-3 minutes for pod initialization and FIM baselining.
3. Check `export_logs.sh` or use the Vision One Console to observe the alerts.

---

## Lab Evidence & Forensic Artifacts
To demonstrate the success of the simulations on platforms like GitHub, the lab uses `export_logs.sh` to capture evidence directly from the cluster.

### Key Artifacts Generated:
- **`agent_scout_detections.log`**: Contains the raw runtime alerts for Malware, FIM, and Policy violations.
- **`agent_scan_status.log`**: Proves successful completion of image vulnerability and secret scans.
- **`agent_cloud_sync.log`**: Confirms the agent is successfully communicating with the security backend.

### Summary of Findings:
- **Malware:** Signature detection verified via Scout logs.
- **FIM:** Baseline divergence captured for `/etc/hosts` and `/etc/passwd`.
- **Vulnerabilities:** Successful scan completion for high-risk images (Metasploit).
- **Secrets:** Env-var scanning successfully identified hardcoded keys.
