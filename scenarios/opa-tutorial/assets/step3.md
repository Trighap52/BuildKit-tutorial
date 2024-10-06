Now, let’s create a **Constraint** that applies the rule we defined in the template to all pods running in the cluster.

1. **Create another file** called `constraint.yaml`:

   ```bash
   nano constraint.yaml
   ```

2. **Paste the following content**:

   ```yaml
    apiVersion: constraints.gatekeeper.sh/v1beta1
    kind: AllowedImageRegistry # This must match the kind from the template
    metadata:
        name: allowed-image-registry
    spec:
        match:
        kinds:
            - apiGroups: [""]
            kinds: ["Pod"]
   ```

This configuration will ensure that the policy created in the **ConstraintTemplate** is applied to all Pods in the cluster, ensuring they use images from the allowed registry. Here's a little breakdown of the code : 

1. **`apiVersion`**: The version of the Gatekeeper constraint resource.
2. **`kind`**: This must match the `kind` defined in the **ConstraintTemplate** (`AllowedImageRegistry`).
3. **`metadata.name`**: The name of this specific constraint. This is what will identify this particular policy rule in the cluster.
4. **`spec.match`**: Defines the types of Kubernetes resources to which the policy applies.
   - **`apiGroups`**: An empty string refers to core resources like Pods.
   - **`kinds`**: Specifies that this constraint will apply only to Pods.

3. **Apply the constraint**:

   ```bash
   kubectl apply -f constraint.yaml
   ```
