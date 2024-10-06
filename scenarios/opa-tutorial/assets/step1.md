To install OPA Gatekeeper, follow these steps:

1. **Open a terminal** connected to your Kubernetes cluster.
2. **Install Gatekeeper** by running the following command:

   ```bash
   kubectl apply -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/master/deploy/gatekeeper.yaml
   ```

   This will install Gatekeeper on your cluster, allowing it to enforce policies.

3. **Verify the installation** by checking if Gatekeeper components are running:

   ```bash
   kubectl get pods -n gatekeeper-system
   ```

   You should see pods like `gatekeeper-controller-manager` running (it may take a few seconds). If they are all up and running, Gatekeeper is ready.