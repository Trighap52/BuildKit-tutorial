# Enabling BuildKit

By default, Docker uses the old build system. To use BuildKit, you need to enable it. You can do this by setting an environment variable or updating Docker’s configuration file.

## **Installing Buildx (Required for BuildKit)**

If BuildKit is enabled but you encounter an error regarding the **Buildx** component being missing or broken, follow these steps to install and configure Docker **Buildx**:

### **Step 1: Install Buildx**
To install Buildx, run the following commands in your terminal:

```bash
mkdir -p ~/.docker/cli-plugins
curl -L https://github.com/docker/buildx/releases/download/v0.10.5/buildx-v0.10.5.linux-amd64 -o ~/.docker/cli-plugins/docker-buildx
chmod +x ~/.docker/cli-plugins/docker-buildx
```

### **Step 2: Create a Buildx Builder**
After installing Buildx, create a new builder and set it as the default:

```bash
docker buildx create --use
```

Verify the builder is active by running:

```bash
docker buildx ls
```

Once Buildx is installed and the builder is active, you can proceed to enable BuildKit as described below.

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

