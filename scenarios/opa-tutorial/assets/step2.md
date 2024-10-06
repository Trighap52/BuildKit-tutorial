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
    name: allowedimageregistry
  spec:
    crd:
      spec:
        names:
          kind: AllowedImageRegistry # This name must match in your Constraint file
    targets:
      - target: admission.k8s.gatekeeper.sh
        rego: |
          package allowedimageregistry

          # Deny the request if the image is not from the allowed registry
          violation[{"msg": msg}] {
            image := input.review.object.spec.containers[_].image
            not startswith(image, "myregistry.com/")
            msg := "Only images from 'myregistry.com' are allowed."
          }
   ```
This code defines our policy in Rego Language. Here's a little explanation of the diffrent parts: 

1. **`metadata.name`**: This gives the template a name (`allowedimageregistry`) that identifies the template.
2. **`crd.spec.names.kind`**: Defines the new custom resource type (`AllowedImageRegistry`), which is used in the corresponding constraint file.
3. **`targets.target`**: Specifies where the policy will be applied. In this case, it's applied to Kubernetes admission control.
4. **`rego` block**: Contains the policy logic written in the Rego language.
   - **`package allowedimageregistry`**: Defines a package that holds the logic for the policy.
   - **`violation` rule**: This rule is triggered when a violation occurs. It checks whether the container image starts with `myregistry.com/` and raises an error message if it doesn't.

3. **Apply the template**:

   ```bash
   kubectl apply -f template.yaml
   ```
