#!/bin/bash

# Check if the Constraint has been created successfully
constraint_status=$(kubectl get constraints allowed-image-registry --no-headers 2>/dev/null)

# If the constraint exists, it will return the status, otherwise it will return an error
if [[ -n "$constraint_status" ]]; then
  echo "Constraint 'allowed-image-registry' has been created successfully."
  exit 0
else
  echo "Constraint 'allowed-image-registry' not found. Please check if the constraint has been applied correctly."
  exit 1
fi