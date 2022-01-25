
[![K8s based CI/CD for Streaming Integrator]({{base_path}}/assets/img/deploy/si-cicd-k8s.png)]({{base_path}}/assets/img/deploy/mi-cicd-k8s.png)

#### Deployment Descriptor Repository
- We maintain Deployment Descriptor repositories in Github. 
- There will be Kubernetes yaml files for each project inside a separate folder.
- This repository will have three branches representing each deployment environment.
- To use a new version / rollback to a previous version, the user should define the version inside the respective `deployment.yaml` and commit to the respective branch.

#### Deployment Descriptor Jenkins Build Job
- We need to maintain one Jenkins job per Environment.
- This job contains only the build phase. This will apply the relevant yaml files in the relevant environment.

### Kubernetes artifacts
Sample Kubernetes artifacts for a stateless deployment have been provided below. You can extend the below yaml files to introduce other components. (eg: configMaps, Ingress etc) 

```yaml tab="Deployment"
apiVersion: "apps/v1"
kind: Deployment
metadata:
  name: "si-deployment"
spec:
  replicas: 1
  minReadySeconds: 30
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
    type: RollingUpdate
  selector:
    matchLabels:
      app: "integration"
  template:
    metadata:
      labels:
        app: "integration"
    spec:
      containers:
      - name: wso2si-sample
        image: docker.io/samplerepo/helloworld:1.0.0
        imagePullPolicy: Always
        resources:
          requests:
            memory: "1Gi"
            cpu: "1000m"
          limits:
            memory: "1Gi"
            cpu: "1000m"
        ports:
        -
          containerPort: 9090
          protocol: "TCP"
        -
          containerPort: 9443
          protocol: "TCP"
        -
          containerPort: 9711
          protocol: "TCP"
        -
          containerPort: 9611
          protocol: "TCP"
        -
          containerPort: 7711
          protocol: "TCP"
        -
          containerPort: 7611
          protocol: "TCP"
```

```yaml tab="Service"
apiVersion: "v1"
kind: "Service"
metadata:
  name: "si-service"
spec:
  type: "ClusterIP"
  selector:
    app: "integration"
  ports:
    # ports that this service should serve on
    -
      name: pass-through-http
      protocol: TCP
      port: 9090
    -
      name: servlet-https
      protocol: TCP
      port: 9443
    -
      name: http-port-1
      protocol: TCP
      port: 9711
    -
      name: http-port-2
      protocol: TCP
      port: 9611
    -
      name: http-port-3
      protocol: TCP
      port: 7711
    -
      name: http-port-4
      protocol: TCP
      port: 7611
```

    
## Setting up the environment

### Prerequisites

1. Streaming Integrator Tooling

2. GitHub repository - To maintain the descriptor files of each environment

3. Jenkins server for Continuous Deployment

4. Docker registry - To store the SI images.

5. Kubernetes cluster with 3 different namespaces (dev, staging, prod)

### Sample User guide

1. Clone the [samples-apim](https://github.com/wso2/samples-apim/) repository

2. [Create Siddhi apps using Streaming Integrator tooling]({{base_path}}/get-started/streaming-quick-start-guide/). You can use the tool to run and test the applications.

3. Once the application is developed, you can create the Docker image and push them by using [“Export For Docker”]({{base_path}}/develop/streaming-apps/exporting-siddhi-applications/#exporting-siddhi-applications-as-a-docker-image).


    !!! note
        Currently, in SI-tooling 4.0.0, the Dockerfile uses SI 1.0.0 as base image. You may have to use the following Dockerfile to create the Docker image manually and push it to your private Docker registry.

            # use streaming-integrator-base-image
            FROM wso2/wso2si:4.0.0
            MAINTAINER WSO2 Docker Maintainers "dev@wso2.org"
            
            ARG STREAMING_INTEGRATOR_HOME=/home/wso2carbon/wso2si-4.0.0
            ARG HOST_BUNDLES_DIR=./bundles
            ARG HOST_JARS_DIR=./jars
            ARG HOST_APPS_DIR=./siddhi-files
            ARG JARS=${STREAMING_INTEGRATOR_HOME}/lib
            ARG BUNDLES=${STREAMING_INTEGRATOR_HOME}/lib
            ARG APPS=${STREAMING_INTEGRATOR_HOME}/wso2/server/deployment/siddhi-files
            ARG CONFIG_FILE=./configurations.yaml
            ARG CONFIG_FILE_PATH=${HOME}/configurations.yaml
            
            # copy bundles & jars to the siddhi-runner distribution
            COPY ${HOST_APPS_DIR}/ ${APPS}
            
            # expose ports
            EXPOSE 9090 9443 9712 9612 7711 7611 7070 7443

4. Confirm that the Docker image is available in the Docker registry.
5. [Set up Jenkins server](#setting-up-jenkins-server)
6. Use the above mentioned [Kubernetes artifacts](#kubernetes-artifacts) to create the Kubernetes deployment files.
7. Move the kubernetes artifacts files into a folder with the project name. This folder will contain Kubernetes artifacts for a particular project.
8. Commit the above project folder in to the Deployment Descriptor repo under dev branch. If you have multiple projects, you can commit them as well.
9. Once you commit the changes, you can observe that the descriptor-dev job starts running and it applies the Yaml files into the Dev namespace in Kubernetes cluster.
10. Verify that the new changes are available in the Dev environment.
11. You can repeat steps 8, 9 and 10 for the Staging and Prod environment.

#### Setting up Jenkins server

1. Docker scripts for setting up a Jenkins environment are provided inside `samples-apim/si-cicd`. This will spin up a preconfigured Docker image. By default, 3 Jenkins jobs will be created. One each for the environment descriptor branches (dev, staging, prod).

2. Descriptor repository will be maintained in GitHub.

3. Navigate to the Docker K8s artifacts directory.

      `cd sample-apim/si-cicd/docker-k8s-artifacts/`

4. Open up the Dockerfile and fill up the project and environment related details.

      `vi Dockerfile`

5. [Optional] If you want to customize the Jenkins configuration, update the Jenkins_casc.yaml file.

      `vi jenkins_casc.yaml`

6. Run the following build command to build the Docker image.

      `docker build -t <image-name>:<image-tag> .`

7. Run the following command to run the image. You need to configure the .ssh folder to access the dev, staging and production environment and mount the folder to the container.

      `docker run -d -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock -v ~/.kube:/root/.kube <image-name>:<image-tag>`

8. After installing Jenkins, the jobs can be accessed via [http://localhost:8080/](http://localhost:8081/)
