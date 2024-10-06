# Running your first BuildKit Build
## Create a Simple Dockerfile**

Now that BuildKit is enabled, let’s create a simple Dockerfile to test the build process. Open a terminal and create a new file called `Dockerfile`:

```bash
nano Dockerfile
```

Inside the file, paste the following simple content:

```dockerfile
# Use an official Node.js runtime as a parent image
FROM node:14

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the package.json file and install dependencies
COPY package.json .
RUN npm install

# Copy the rest of the application’s source code
COPY . .

# Expose port 8080
EXPOSE 8080

# Command to run the app
CMD ["node", "index.js"]
```

This Dockerfile will:
- Use the Node.js 14 runtime.
- Set the working directory in the container.
- Copy the necessary files and install dependencies.
- Expose port 8080 and run the application.

## Build the Docker Image with BuildKit**

Now, let’s build the Docker image using BuildKit. In your terminal, run the following command to build the image:

```bash
docker build -t myapp .
```

When you run this build command, BuildKit will kick in, using its enhanced caching and parallel processing capabilities.

## Observe BuildKit in Action**

Once the build starts, you'll notice a few differences compared to the traditional Docker build system:
- **Parallel Processing**: BuildKit executes independent layers in parallel, speeding up the build process.
- **Optimized Caching**: BuildKit uses more intelligent layer caching, allowing for faster rebuilds when changes occur in the Dockerfile.

You should see output indicating that BuildKit is in use (e.g., `[+] Building 12.3s`).

## Run the Built Image**

Once the build completes, you can run the Docker image to test that everything works correctly:

```bash
docker run -p 8080:8080 myapp
```

This command will start your Node.js application inside a container and expose it on port 8080.

You can open your browser and go to `http://localhost:8080` to see the app running.

## Analysis of Build Performance**

Now that you’ve completed the build with BuildKit, let's analyze its performance by comparing the build time to a traditional Docker build.

1. **Run the Build Without BuildKit**:  
   First, disable BuildKit by running the following command:
   ```bash
   export DOCKER_BUILDKIT=0
   ```

   Then, rebuild the same Dockerfile using the traditional Docker build:
   ```bash
   docker build -t myapp .
   ```

   Record the time it takes to complete the build. You can use the built-in `time` command to track this:
   ```bash
   time docker build -t myapp .
   ```

   Take note of the time shown in the output.

2. **Re-enable BuildKit**:
   Now re-enable BuildKit and rebuild the image:
   ```bash
   export DOCKER_BUILDKIT=1
   time docker build -t myapp .
   ```

   Record the time taken for this build as well.
