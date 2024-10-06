#!/bin/bash

# Check if the Gatekeeper pods are running in the gatekeeper-system namespace
pods_status=$(kubectl get pods -n gatekeeper-system --no-headers | awk '{print $3}' | grep -v "Running")

# Verify if there are any non-running pods
if [[ -z "$pods_status" ]]; then
  echo "OPA Gatekeeper is installed and all components are running successfully."
  exit 0
else
  echo "OPA Gatekeeper is not running correctly. Please check the installation."
  exit 1
fi