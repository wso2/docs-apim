# Create and Publish an AWS Lambda API

Follow the instructions in this tutorial to design and publish an AWS Lambda API.

<html>
   <div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>For more information on AWS Lambda, see <a href="https://docs.aws.amazon.com/lambda/latest/dg/welcome.html">What is AWS Lambda?</a></p>
   </div> 
</html>

### Step 1 - Design a REST API

1. Sign in to the API Publisher Portal.
   
    `https://<hostname>:9443/publisher` 
   
    Example: `https://localhost:9443/publisher`

    Use your username and password to sign in.

2. Click **CREATE API** and then click **Design a New REST API**.

    [![Create a new REST API]({{base_path}}/assets/img/Learn/create-api-design-rest-api-link.png)]({{base_path}}/assets/img/Learn/create-a-rest-api.jpg)

3. Enter API details and click **CREATE**.  

    [![Create a test API]({{base_path}}/assets/img/Learn/create-test-api.png)]({{base_path}}/assets/img/Learn/create-test-api.png)

    <html>
      <div class="admonition note">
         <p class="admonition-title">Note</p>
         <p>You don't need to enter the Endpoint at this moment.</p>
      </div> 
    </html>

Now, you have created a new REST API successfully. 

### Step 2 - Add AWS Lambda endpoint

1. Goto **Endpoints**
2. Add **AWS Lambda** endpoint type

    [![Select AWS Lambda endpoint]({{base_path}}/assets/img/Learn/Tutorials/endpoint-select-awslambda-endpoint.png)]({{base_path}}/assets/img/Learn/Tutorials/endpoint-select-awslambda-endpoint.png)

3. Select **Access Method**

    AWS SDK needs AWS credentials to invoke AWS Lambda functions. Access Method defines how you provide those AWS credentials. You can provide AWS credentials manually by selecting **Using stored AWS credentials** method. But if WSO2 API Manager is running on an Amazon EC2 instance, you can select **Using IAM role-supplied temporary AWS credentials** method.

    <html>
      <div class="admonition note">
         <p class="admonition-title">Note</p>
         <p>To use IAM role-supplied temporary AWS credentials method, you should attach an IAM role to grant permissions to applications running on Amazon EC2 instance.</p>
         <p>For more information on attaching IAM role to EC2, see <a href="https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2.html">Using an IAM Role to Grant Permissions to Applications Running on Amazon EC2 Instances</a>.</p>
      </div> 
    </html>

4. Click **Save**

    [![Save AWS Lambda endpoint]({{base_path}}/assets/img/Learn/Tutorials/endpoint-awslambda-save.png)]({{base_path}}/assets/img/Learn/Tutorials/endpoint-awslambda-save.png)

    <html>
      <div class="admonition note">
         <p class="admonition-title">Note</p>
         <p>You'll get an error message if you have not set the Access Method properly.</p>
      </div> 
    </html>

### Step 3 - Map Function-ARNs to Resources

<html>
   <div class="admonition note">
      <p class="admonition-title">Note</p>
      <p>
         For more information on ARNs, see 
         <a href="https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html">Amazon Resource Names (ARNs)</a>
         .
      </p>
   </div> 
</html>

1. Goto **Resources**.
2. Configure resources.

    By default, the API will have five resources with `/*` as the URL pattern.

    1. Click delete, as shown below, to remove all the existing resources.

          [![Delete all existing resources]({{base_path}}/assets/img/Learn/delete-all-existing-resources.jpg)]({{base_path}}/assets/img/Learn/delete-all-existing-resources.jpg)

    2. Add a new resource.
          1. Select **POST** as HTTP Verb.
          2. Enter a meaningful name for URI Pattern.
          3. Click **(+)** to add new resource.

          [![Add a new resource]({{base_path}}/assets/img/Learn/Tutorials/resource-add-post-test.png)]({{base_path}}/assets/img/Learn/Tutorials/resource-add-post-test.png)

3. Under AWS Lambda Settings select or type Amazon Resource Name (ARN) for the resource.

    You can select already created AWS Lambda functions listed in Autocomplete box.

    [![Select or type ARN]({{base_path}}/assets/img/Learn/Tutorials/resource-add-amazon-resource-name.png)]({{base_path}}/assets/img/Learn/Tutorials/resource-add-amazon-resource-name.png)

4. Optional - Default AWS SDK Client Execution Timeout is 50 seconds. You can can change it by **Set Timeout** option. 

    - Min Timeout - 1 second
    - Max Timeout - 15 minutes

    [![Set Timeout]({{base_path}}/assets/img/Learn/Tutorials/resource-set-amazon-resource-timeout.png)]({{base_path}}/assets/img/Learn/Tutorials/resource-set-amazon-resource-timeout.png)

5. Click **Save**.

    [![Save resources]({{base_path}}/assets/img/Learn/Tutorials/resource-save.png)]({{base_path}}/assets/img/Learn/Tutorials/resource-save.png)

### Step 4 - Publish the AWS Lambda API

1. Click **LIFECYCLE** to navigate to the API lifecycle.
2. Click **PUBLISH** to publish the API to the API Developer Portal.

[![Publish test API]({{base_path}}/assets/img/Learn/Tutorials/lifecycle-publish-test-api.png)]({{base_path}}/assets/img/Learn/Tutorials/lifecycle-publish-test-api.png)

You have successfully published the AWS Lambda API.