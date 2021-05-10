There are two kinds of jobs in Jenkins that we need to maintain. One for the Integration project repositories. Another kind is for the Deployment Descriptor repositories. 

[![K8s based CI/CD for Micro Integrator]({{base_path}}/assets/img/deploy/mi-cicd-k8s.png)]({{base_path}}/assets/img/deploy/mi-cicd-k8s.png)

#### Integration Project Build Job
- We need to maintain one Jenkins job per Integration Project repository.
- The Integration Project has to be a [Maven Multi Module project]({{base_path}}/integrate/develop/create-integration-project/#maven-multi-module-projects) and it has to contain one Kubernetes Exporter module. 
- The build phase of the job will build the Integration project and run the unit tests if a Unit test server is configured.
- The release phase of the job generates Docker images using the provided repository, name and project version and pushes the image to the configured Docker registry and creates a release tag in GitHub.

#### Deployment Descriptor Build Job
- We need to maintain one Jenkins job per Environment.
- There will be descriptor files for each project inside a separate folder. These will be generated in Integration Studio when you create a Kubernetes Exporter Module.
- To use a new version / rollback to a previous version, the user should define the version inside the respective descriptor file `integration_cr.yaml` or `integration_k8s.yaml` and commit to the respective branch.
- This job contains only the build phase. This will apply the relevant yaml files in the relevant environment.

### Kubernetes artifacts
Integration Studio will be used to generate Kubernetes artifacts, while creating the Kubernetes exporter module. There are two kinds of Kubernetes artifacts that you can create in Integration Studio. 
These will be generated inside a folder with the Project Name.

*   Pure Kubernetes artifacts 
    *   Deployment.yaml
    *   Service.yaml
    *   ConfigMap.yaml
*   K8s-Operator based Kubernetes artifact 
    *   CRD.yaml
    *   ConfigMap.yaml


## Setting up the environment

### Prerequisites

1. Integration Studio 8.0.0 or higher

2. Two GitHub repositories 

*   Source repository - To maintain the source of the project
*   Deployment repository - To maintain the descriptor files of the environment

3. Jenkins server for Continuous Integration

4. Docker registry - To store the MI images. 

5. Kubernetes cluster with 3 different namespaces

6. Separate Micro Integrator instance as Unit Testing Server (Optional)

#### Sample User guide

1. Clone the [samples-apim](https://github.com/wso2/samples-apim/) repository

2. Create Integration Project for your solution via the Integration Studio

	By default, Integration studio adds parent maven details in the submodule POMs. You can customize maven details while creating the solution.

3. Update Project pom scm details by filling the git location.
	
    ```
    <scm>
        <connection>scm:git:https://github.com/username/repository.git</connection>
        <developerConnection>scm:git:https://github.com/username/repository.git</developerConnection>
        <url>https://github.com/username/repository.git</url>
      </scm>
    ```
   
4. Commit your changes to the GitHub source repository
5. [Set up Jenkins server](#setting-up-jenkins-server)
6. Login to the Jenkins server using the credentials given in the Dockerfile of Jenkins instance.
7. Navigate to the project build job and trigger a build.
8. Create webhooks in relevant GitHub repositories pointing to the Jenkins server. (Source & Deployment)
9. Perform a maven release by giving release and development versions.
10. Once the release build is passed, confirm that the Docker image is available in the Docker registry.
11. Copy the folder containing the yaml files in Kubernetes exporter project inside a folder specific to each environment.
12. Commit the above created folder to the dev branch (environment) of the deployment repository. 
13. Once you commit the changes, you can observe that the descriptor-dev job starts running and it applies the Yaml files into the Dev namespace in Kubernetes cluster.
14. Verify that the new changes are available in the Dev environment.
15. You can repeat steps 12, 13 and 14 for the Staging and Prod environment.

    !!!Info
        Please note that according to current scripts, when you change only the config map, the change won’t get reflected in the running pod. To do a proper deployment you may need to use tools like [kustomize](https://kubernetes.io/docs/tasks/manage-kubernetes-objects/kustomization/).

#### Setting up Jenkins server

1. Docker scripts for setting up a Jenkins environment are provided here. This will spin up a preconfigured Docker image. By default, 4 Jenkins jobs will be created. One project for the Integration project and three more for the environment descriptor repos (dev, staging, prod). 

2. Both the Integration project, and descriptor repos will be in GitHub.

    Note: You can customize the Docker scripts to create Jenkins jobs for multiple Integration projects.

3. Navigate to the Docker VM artifacts directory.
    
    `cd sample-apim/ei-cicd/docker-vm-artifacts/jenkins`

3. Open up the Dockerfile and fill up the project and environment related details.

    `vi Dockerfile`

4. [Optional] If you want to customize the Jenkins configuration, update the Jenkins_casc_vm.yaml file.

    `vi jenkins_casc_k8s.yaml`

5. [Optional] : [Setting up Synapse Unit testing server](#setting-up-synapse-unit-testing-server)

6. Run the following build command to build the Docker image.

    `docker build -t <image-name>:<image-tag> .`

7. Run the following command to run the image. You need to configure the .ssh folder to access the dev, staging and production environment and mount the folder to the container.

    `docker run -d -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock -v ~/.kube:/root/.kube <image-name>:<image-tag>`

8. We need to share the host .ssh configurations with the Docker container as in above. The host machine needs to have ssh access to copy the CApps files to the remote instance where the Micro Integrator instances are running. 

9. After installing Jenkins, the jobs can be accessed via [http://localhost:8080/](http://localhost:8081/)

#### Setting up Synapse Unit testing server

If you have written Synapse unit tests for your Integration project, you can run them during the Jenkins build.

To set up the Synapse Unit testing server, please follow the below steps.


1. Run a separate Micro Integrator Instance in Unit testing mode. To start the server in Unit testing mode please pass this argument `-DsynapseTest`.

    If you want to change the synapse testing port, you can pass the `-DsynapseTestPort=<new Port>` to the above command. Default port is 9008

2. Update Jenkins Dockerfile as below.

        SYNAPSE_TEST_FRAMEWORK_CONFIGS= -DtestServerType=remote -DtestServerHost=<IP of testing server> -DtestServerPort=9008
