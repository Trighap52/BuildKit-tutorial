#!/bin/bash

# Fetch all pod statuses in the gatekeeper-system namespace
all_pods=$(kubectl get pods -n gatekeeper-system --no-headers)

# Check if there are any pods and whether all of them are in Running state
if [[ -n "$all_pods" && $(echo "$all_pods" | grep -c "Running") -eq $(echo "$all_pods" | wc -l) ]]; then
  echo "OPA Gatekeeper is installed and all components are running successfully."
  exit 0
else
  echo "OPA Gatekeeper is not running correctly. Please check the installation."
  exit 1
fi