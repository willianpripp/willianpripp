#!/bin/bash

# Server Details (Load from local file or environment)
[ -f "lab_credentials.pass" ] && source lab_credentials.pass
SERVER_IP="${SERVER_IP:-YOUR_SERVER_IP}"
SERVER_USER="${SERVER_USER:-YOUR_SERVER_USER}"
SERVER_PASS="${SERVER_PASS:-YOUR_SERVER_PASS}"

echo "--- Exporting Security Logs from $SERVER_IP ---"

# 1. Export Scout Logs
echo "Capturing Scout logs..."
sshpass -p "$SERVER_PASS" ssh -o StrictHostKeyChecking=no "$SERVER_USER@$SERVER_IP" \
    "kubectl logs -n trendmicro-system trendmicro-scout-b28sd -c scout --tail=500" > agent_scout_detections.log

# 2. Export Workload Operator Logs
echo "Capturing Workload Operator logs..."
sshpass -p "$SERVER_PASS" ssh -o StrictHostKeyChecking=no "$SERVER_USER@$SERVER_IP" \
    "kubectl logs -n trendmicro-system trendmicro-workload-operator-58f754bc99-4hnvn --tail=500" > agent_cloud_sync.log

# 3. Export Scan Status
echo "Capturing Scan Status summary..."
sshpass -p "$SERVER_PASS" ssh -o StrictHostKeyChecking=no "$SERVER_USER@$SERVER_IP" \
    "kubectl get workloadimages -n trendmicro-system" > agent_scan_status.log

echo "--- Export Complete ---"
echo "Files created:"
ls -lh *.log