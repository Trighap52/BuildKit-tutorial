#!/bin/bash

# Try to create a pod with an unauthorized image (docker.io/library/nginx)
unauthorized_pod_status=$(kubectl run test-pod --image=docker.io/library/nginx 2>&1)

# Check if the request was denied due to the image not being from the allowed registry
if echo "$unauthorized_pod_status" | grep -q "Error from server (Forbidden): admission webhook"; then
  echo "Gatekeeper correctly blocked the pod using an unauthorized image."
  
  # Now test deploying a pod with an allowed image from 'myregistry.com'
  allowed_pod_status=$(kubectl run test-pod-allowed --image=myregistry.com/nginx 2>&1)
  
  # Check if the pod creation with the allowed image was successful
  if echo "$allowed_pod_status" | grep -q "pod/test-pod-allowed created"; then
    echo "Pod with the allowed image was successfully created."
    exit 0
  else
    echo "Failed to create pod with the allowed image. Please check the allowed registry settings."
    exit 1
  fi

else
  echo "Gatekeeper failed to block the pod with an unauthorized image. Please check the policy."
  exit 1
fi