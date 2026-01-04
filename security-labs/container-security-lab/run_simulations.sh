#!/bin/bash

# Server Details (Load from local file or environment)
[ -f "lab_credentials.pass" ] && source lab_credentials.pass
SERVER_IP="${SERVER_IP:-YOUR_SERVER_IP}"
SERVER_USER="${SERVER_USER:-YOUR_SERVER_USER}"
SERVER_PASS="${SERVER_PASS:-YOUR_SERVER_PASS}"

# Define the list of simulation files
SIM_FILES=(
    "vulnerable-pod.yaml"
    "secret-pod.yaml"
    "secret-advanced.yaml"
    "malware-pod.yaml"
    "malware-advanced.yaml"
    "malware-webshell.yaml"
    "malware-miner.yaml"
    "malware-dropper-v2.yaml"
    "runtime-advanced.yaml"
    "fim-pod.yaml"
    "fim-deletion.yaml"
    "fim-advanced-tests.yaml"
    "compliant-pod.yaml"
    "compliant-test-pods.yaml"
)

echo "--- Starting Remote Security Simulations on $SERVER_IP ---"

for file in "${SIM_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "Applying $file remotely..."
        # We pipe the local file content to the remote kubectl command
        cat "$file" | sshpass -p "$SERVER_PASS" ssh -o StrictHostKeyChecking=no "$SERVER_USER@$SERVER_IP" "kubectl apply -f -"
    else
        echo "Warning: $file not found, skipping."
    fi
done

echo "--- All simulation pods have been deployed ---"
sshpass -p "$SERVER_PASS" ssh -o StrictHostKeyChecking=no "$SERVER_USER@$SERVER_IP" "kubectl get pods"