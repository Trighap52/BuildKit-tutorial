# Setting Up OPA for Kubernetes Policy Enforcement

In this step, we will set up **OPA Gatekeeper** in a Kubernetes environment to enforce a simple policy that controls what images can be deployed. Gatekeeper is a Kubernetes-native integration of OPA that makes it easy to enforce policies on Kubernetes clusters.

### **Step 1: Install OPA Gatekeeper**

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

   You should see pods like `gatekeeper-controller-manager` running. If they are all up and running, Gatekeeper is ready.

---

### **Step 2: Create a Policy Template**

Gatekeeper uses **Constraint Templates** to define reusable policies. Let’s create a simple policy that only allows containers to run images from a trusted registry (for example, `myregistry.com`).

1. **Create a file** called `template.yaml`:

   ```bash
   nano template.yaml
   ```

2. **Paste the following content** into the file:

   ```yaml
   apiVersion: templates.gatekeeper.sh/v1beta1
   kind: ConstraintTemplate
   metadata:
     name: k8srequiredlabels
   spec:
     crd:
       spec:
         names:
           kind: K8sRequiredLabels
     targets:
       - target: admission.k8s.gatekeeper.sh
     rego: |
       package k8srequiredlabels
       violation[{"msg": msg}] {
         image := input.review.object.spec.containers[_].image
         not startswith(image, "myregistry.com/")
         msg := sprintf("Image %v is not from the allowed registry.", [image])
       }
   ```

3. **Apply the template**:

   ```bash
   kubectl apply -f template.yaml
   ```

---

### **Step 3: Create a Policy Constraint**

Now, let’s create a **Constraint** that applies the rule we defined in the template to all pods running in the cluster.

1. **Create another file** called `constraint.yaml`:

   ```bash
   nano constraint.yaml
   ```

2. **Paste the following content**:

   ```yaml
   apiVersion: constraints.gatekeeper.sh/v1beta1
   kind: K8sRequiredLabels
   metadata:
     name: allowed-image-registry
   spec:
     match:
       kinds:
         - apiGroups: [""]
           kinds: ["Pod"]
   ```

3. **Apply the constraint**:

   ```bash
   kubectl apply -f constraint.yaml
   ```

---

### **Step 4: Test the Policy**

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

---

### **Explanation**
- **ConstraintTemplate**: This defines the logic of the policy, using OPA's **Rego** language.
- **Constraint**: This applies the policy logic to specific resources (in this case, pods) in the Kubernetes cluster.
- **Test**: We try deploying pods with both allowed and forbidden images to see how Gatekeeper enforces the policy.

---

## Suggested ImageID for KillerKoda

For this tutorial, you will need a **Kubernetes environment** with tools like **kubectl** installed and **OPA Gatekeeper** available. A good Docker image for this purpose is:

```json
"imageid": "k8s.gcr.io/kubernetes-opa:latest"
```

This image should have the Kubernetes tools necessary for interacting with your cluster, and you can install OPA Gatekeeper as needed.

Alternatively, you can use a **Kubernetes-in-Docker (kind)** environment or an **Ubuntu image** and install the necessary tools during the scenario initialization.

---

Let me know if this simplified version works for you or if you need further adjustments!