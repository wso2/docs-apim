# AI Policies

The following AI Policies can be utilized to cater to your intra-vendor model routing requirements:

- Model Round Robin Policy 
- Model Weighted Robin Robin Policy
- Model Failover Policy

!!! Note
    You can only attach a single AI policy to a given AI API.

!!! Tip
    If you require multiple endpoints to cater to your routing requirements, make sure you have added them under the Endpoints page.


## Model Round Robin Policy

Model Round Robin Policy can be used to route traffic to different models within the same AI/LLM vendor. If the intra-vendor model routing strategy you wish to utilize is round-robin, follow the instructions mentioned below.

1. Drag and drop the **Model Round Robin** policy which is available under the Common Policies section within the Policy List.

2. Configure the relevant details under the configuration drawer that appears. Add the production model list, sandbox model list, and specify the suspend duration.

    To add a model, click on **Add Model** button. Then, select a model from the dropdown (if no models are listed, make sure to add the supported model list under the AI/LLM vendor under the Admin Portal). Following the model selection, select the endpoint from the dropdown (if no endpoints are listed, make sure to add the required endpoints under the Endpoints page of Publisher Portal).

3. Then, click **Save**.

## Model Weighted Round Robin Policy

Model Weighted Round Robin Policy can be used to route traffic to different models within the same AI/LLM vendor based on the configured weights. If the intra-vendor model routing stratergy you wish to utilize is weighted round-robin, follow the instructions mentioned below.

1. Drag and drop the **Model Weighted Round Robin** policy which is available under the Common Policies section within the Policy List.

2. Configure the relevant details under the configuration drawer that appears. Add the production model list, sandbox model list, and specify the suspend duration.

    To add a model, click on **Add Model** button. Then, select a model from the dropdown (if no models are listed, make sure to add the supported model list under the AI/LLM vendor under the Admin Portal). Following the model selection, select the endpoint from the dropdown (if no endpoints are listed, make sure to add the required endpoints under the Endpoints page of Publisher Portal). Finally, set the desired weight.

3. Then, click **Save**.
