#!/bin/bash

# Fetch all pod statuses in the gatekeeper-system namespace
all_pods=$(kubectl get pods -n gatekeeper-system --no-headers)

# Check if at least one pod is running
if [[ -n "$all_pods" && $(echo "$all_pods" | grep -c "Running") -ge 1 ]]; then
  echo "OPA Gatekeeper is installed and at least one component is running successfully."
  exit 0
else
  echo "OPA Gatekeeper is not running correctly. Please check the installation."
  exit 1
fi