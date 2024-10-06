# Enabling BuildKit

By default, Docker uses the old build system. To use BuildKit, you need to enable it. You can do this by setting an environment variable or updating Docker’s configuration file.

## Option 1: Temporary Session-based Setup
To enable BuildKit for your current session, run the following command in your terminal:
```bash
export DOCKER_BUILDKIT=1
```
## Option 2: Permanent Setup

If you want BuildKit to be enabled permanently, you can configure Docker's settings to always use BuildKit.

- **On Linux**:
  1. Open the Docker daemon configuration file, which is typically located at `/etc/docker/daemon.json`.
  2. Add the following configuration to enable BuildKit:
     ```json
     {
       "features": {
         "buildkit": true
       }
     }
     ```
  3. Save the file and restart Docker for the changes to take effect:
     ```bash
     sudo systemctl restart docker
     ```

- **On Docker Desktop (Windows/Mac)**:
  1. Open **Docker Desktop**.
  2. Navigate to **Settings** > **Docker Engine**.
  3. Add the following line under the `"settings"` object in the JSON configuration:
     ```json
     {
       "features": {
         "buildkit": true
       }
     }
     ```
  4. Click **Apply & Restart** to enable BuildKit permanently.

Once BuildKit is enabled, Docker will always use it as the default build system.

Click **Next** to proceed with enabling BuildKit and optimizing your Docker builds!
