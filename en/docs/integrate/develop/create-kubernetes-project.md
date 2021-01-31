# Creating Kubernetes Exporter

Create a Kubernetes Exporter if you want to deploy your integration solutions in a Kubernetes environment. 

The Kubernetes Exporter allows you to package multiple [integration modules]({{base_path}}/integrate/develop/create-integration-project) into a single Docker image. Also, a file named **integration_cr.yaml** is generated, which can be used to carry out Kubernetes deployments based on the [k8s-ei-operator](../../setup/deployment/kubernetes_deployment/#ei-kubernetes-k8s-operator).

## Creating the Kubernetes project

Follow the steps given below.   

1. [Create a new integration project]({{base_path}}/integrate/develop/create-integration-project) and create a Kubernetes Exporter project by doing one of the following.

    1. As part of creating an integration project, you can select the **Kubernetes Exporter** check box.

    2. You can right click on an existing integration project and select **New** -> **Kubernetes Exporter**.

2.  In the **New Kubernetes Exporter** dialog box that opens, enter a name for the Kubernetes exporter and other parameters as shown below.

    <img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/new_k8s_project_info.png" width="500">

    Enter the following information:

    <table>
        <tr>
            <th>
                Parameter
            </th>
            <th>
                Description
            </th>
        </tr>
        <tr>
            <td>
                Kubernetes Exporter Name
            </td>
            <td>
                <b>Required</b>. Give a name for the Kubernetes project.
            </td>
        </tr>
        <tr>
            <td>
                Integration Name
            </td>
            <td>
                <b>Required</b>. This name will be used to identify the integration solution in the kubernetes custom resource. The custom resource file (<b>integration_cr.yaml</b>) for this solution will be generated along with the other artifacts.
            </td>
        </tr>
        <tr>
            <td>
                Number of Replicas
            </td>
            <td>
                <b>Required</b>. Specify the number of pods that should be created in the kubernetes cluster.
            </td>
        </tr>
        <tr>
            <td>
                Base Image Repository
            </td>
            <td>
                <b>Required</b>. Select the base Micro Integrator Docker image for your solution. Use one of the following options:
                <ul>
                    <li>
                        <b>wso2/wso2mi</b>: This is the community version of the Micro Integrator Docker image, which is stored in the <a href="https://hub.docker.com/r/wso2/wso2mi">public WSO2 Docker registry</a>. This is selected by default.
                    </li>
                    <li>
                        <b>docker.wso2.com/wso2mi</b>: This is the Micro Integrator Docker image that includes <b>product updates</b>. This image is stored in the <a href="https://docker.wso2.com/tags.php?repo=wso2mi">private WSO2 Docker registry</a>.
                        Note that you need a valid <a href="https://wso2.com/subscription/free-trial">WSO2 subscription</a> to use the Docker image with updates.
                    </li>
                    <li>
                        You can also use a custom Docker image from a custom repository.
                    </li>
                </ul>
                If you specify a Docker image from a private repository, note that you need to log in to your repository from a terminal before you build and push the image (as explained below).
            </td>
        </tr>
            <td>
                Base Image Tag
            </td>
            <td>
                <b>Required</b>. Specify the tag of the base image that you are using.
            </td>
        <tr>
        <tr>
            <td>
                Target Image Repository
            </td>
            <td>
                <b>Required</b>. The Docker repository to which you will later push this Docker image. 
                <ul>
                    <li>
                        If your repository is in <b>Docker Hub</b>, use the <b>docker_user_name/repository_name</b> format.
                    </li>
                    <li>
                        If you are using any other repository, use the <b>repository_url/repository_user_name/repository_name</b> forrmat.
                    </li>
                </ul> 
                If required, you can update this information later when you build and push the Docker image to the relevant repository.
            </td>
        </tr>
        <tr>
            <td>
                Target Image Tag
            </td>
            <td>
                <b>Required</b>. Give a tag name for the Docker image.
            </td>
        </tr>
        <tr>
            <td>
                Automatically deploy configurations
            </td>
            <td>
                This check box indicates that you are using WSO2 EI 7 Micro Integrator as the base image. It is recommended to leave this check box selected when you use WSO2 EI 7.
            </td>
        </tr>
        <tr>
            <td>
                Environment Variables
            </td>
            <td>
                You can enter multiple environment variables as key-value pairs.
            </td>
        </tr>
    </table>

3.  Optionally, click **Next** and configure Maven details for the Kubernetes exporter.

    <img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/new_k8s_project_maven_info.png" width="500">
    
4.  Click **Finish**. The Kubernetes exporter is created in the project explorer. 

5.  This step is only required if you already have a Docker image (in your local Docker repository) with the same name as the base image specified above. 
    
    !!! Info
        In this scenario, WSO2 Integration Studio will first check if there is a difference in the two images before pulling the image specified in the **Base Image Repository** field. If the given base image is more updated, the existing image will be overwritten by this new image. Therefore, if you are currently using an older version, or if you have custom changes in your existing image, they will be replaced. 
        
    To avoid your existing custom/older images from being replaced, add the following property under **dockerfile-maven-plugin -> executions -> execution -> configurations** in the `pom.xml` file of your Kubernetes Exporter project. This configuration will ensure that the base image will not be pulled when a Docker image already exists with the same name.
            
    ```xml
    <pullNewerImage>false</pullNewerImage>
    ```

## The Kubernetes Exporter directory

Expand the **Kubernetes Exporter** in the project explorer. See that the following folders and files are created:

<img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/proj_explorer_k8s_project.png" width="400">

<table>
    <tr>
        <th>
            Directory
        </th>
        <th>
            Description
        </th>
    </tr>
    <tr>
        <td>
            Libs
        </td>
        <td>
            Directory to store libraries. During the build time, the libraries inside this folder will be copied to the image.
        </td>
    </tr>
    <tr>
        <td>
            Resources
        </td>
        <td>
            This folder stores additional files and resources that should be copied to the Docker image. During the build time, the resources inside this directory will be copied to the image.
        </td>
    </tr>
    <tr>
        <td>
            deployment.toml
        </td>
        <td>
            The <a href="{{base_path}}/reference/config-catalog">product configuration file</a>.
        </td>
    </tr>
    <tr>
        <td>
            Dockerfile
        </td>
        <td>
            The Dockerfile containing the build details.
        </td>
    </tr>
    <tr>
        <td>
            integration_cr.yaml
        </td>
        <td>
            Kubernetes configuration file generated based on the user inputs.
        </td>
    </tr>
    <tr>
        <td>
            pom.xml
        </td>
        <td>
            The file for selecting the relevant composite applications that should be included in the Docker image. This information is also used when you later build and push Docker images to the Docker registries.
        </td>
    </tr>
</table>
       
## Build and Push Docker images

Before you begin:

-   Create your integration artifacts in an [ESB Config sub project]({{base_path}}/integrate/develop/create-integration-project/#sub-projects) and package the artifacts in a [Composite Exporter]({{base_path}}/integrate/develop/packaging-artifacts). For example, see the HelloWorld sample given below.

    <img alt="Integration artifacts for Docker" src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/integration-projects-for-k8s.png" width="300">

-   Be sure to start your Docker instance before building the image. If Docker is not started, the build process will fail.

-   If you are using a Micro Integrator Docker image from a private registry as your base image:

    1.  Open a terminal and use the following command to log in to Docker:
        ```bash 
        docker login -u username -p password 
        ```
    2.  In the next step, specify the name of the private Docker registry.

To <b>build</b> and <b>push</b> the Docker image:

!!! Note
    As an alternative, you can skip the steps given below and manually build and push the Docker images using <b>maven</b>. Open a terminal, navigate to the Docker exporter and execute the following command:

    ```bash
    mvn clean install -Dmaven.test.skip=true -Ddockerfile.username={username} -Ddockerfile.password={password} 
    ```

    However, note that you need **Maven 3.5.2** or a later version when you build the Docker image manually (without using WSO2 Integration Studio).

1.  Open the **pom.xml** file inside the Kubernetes exporter and click **Refresh** on the top-right. Your composite application project with integration artifacts will be listed under **Dependencies** as follows:

    <img alt="Kubernetes pom view" src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/k8s-pom.png" width="600">
    
2.  Select the composite applications that should be packed inside the Docker image (under **Dependencies**).
3.  If required, you can update the **Target Repository** to which the image should be pushed and the **Target Tag**.
4.  Save the file and click **Build & Push** on the top-right to start the Docker image build-and-push process. The **Enter Docker Registry Credentials** wizard opens.

    <img alt="Docker Registry Auth Details" src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/k8s-auth.png" width="500">
    
4.  Enter the following details in the wizard:

    <table>
        <tr>
            <th>
                Parameter
            </th>
            <th>
                Description
            </th>
        </tr>
        <tr>
            <td>
                Registry URL Type
            </td>
            <td>
                The Docker image registry to which the image will be pushed: <b>Docker Hub</b> or <b>Other</b>.
            </td>
        </tr>
        <tr>
            <td>
                Username
            </td>
            <td>
                Username of the target registry repository.
            </td>
        </tr>
        <tr>
            <td>
                Password
            </td>
            <td>
                Password of the target registry repository.
            </td>
        </tr>
    </table>
    
5.  Once you enter the above details, click **Push Image**.
6.  First, it will build the Docker image based on the Dockerfile and the Target details. When the image is created, you will see the following message.

    <img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/build.png" alt="Docker Build Success">

7.  Finally, it will start to push the image to the given registry. Once the process is completed, you will see the following message.

    <img src="{{base_path}}/assets/img/integrate/create_project/docker_k8s_project/push.png" alt="Docker Push Success">
