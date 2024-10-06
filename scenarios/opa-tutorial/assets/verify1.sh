#!/bin/bash

# Fetch the count of pods in the Running state in the gatekeeper-system namespace
all_pods=$(kubectl get pods -n gatekeeper-system --no-headers | grep -c "Running")

# Check if at least one pod is running
if [[ $all_pods -ne 0 ]]; then
  echo "OPA Gatekeeper is installed and at least one component is running successfully."
  exit 0
else
  echo "OPA Gatekeeper is not running correctly. Please check the installation."
  exit 1
fi