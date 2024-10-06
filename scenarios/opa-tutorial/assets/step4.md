Now that the policy is in place, let’s test it:

1. **Create a pod with an unauthorized image** (e.g., an image from `docker.io` instead of `myregistry.com`):

   ```bash
   kubectl run test-pod --image=docker.io/library/nginx
   ```

2. **Observe the result**:
   Gatekeeper should block the pod from being created, and you’ll see an error similar to this:

   ```bash
   Error from server (Forbidden): admission webhook "validation.gatekeeper.sh" denied the request: Image docker.io/library/nginx is not from the allowed registry.
   ```

3. **Test with an allowed image**:
   Now try deploying a pod with an image from the allowed registry:

   ```bash
   kubectl run test-pod --image=myregistry.com/nginx
   ```

   This should succeed, as the image matches the policy’s allowed registry.