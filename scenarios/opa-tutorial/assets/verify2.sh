#!/bin/bash

# Check if the ConstraintTemplate has been created successfully
template_status=$(kubectl get constrainttemplates allowedimageregistry --no-headers 2>/dev/null)

# If the template exists, it will return the status, otherwise it will return an error
if [[ -n "$template_status" ]]; then
  echo "ConstraintTemplate 'allowedimageregistry' has been created successfully."
  exit 0
else
  echo "ConstraintTemplate 'allowedimageregistry' not found. Please check if the template has been applied correctly."
  exit 1
fi