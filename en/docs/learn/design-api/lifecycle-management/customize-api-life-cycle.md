# Customize API Life Cycle

APIs created in WSO2 API Manager have their own life cycle consisting of the following: a set of life cycle states, specific actions for each state transition, and a checklist of items before a state transition occurs. An API has a predefined life cycle consists of [six states]({{base_path}}/learn/design-api/lifecycle-management/api-lifecycle/#api-lifecycle-states). This tutorial demonstrates as to how you can edit the default API lifecycle and customize it based on to your requirements.

!!! note
    This capability is not available in WSO2 API Manager versions prior to 1.10.0.


Follow the steps below to add a new state to the default life cycle.

1.  Sign in to the API Publisher

2.  Click on the API that you created previously.
    (e.g., PizzaShackAPI - 1.0.0).
    ![Published life cycle state]({{base_path}}/assets/img/learn/default-lifecycle.png)

3.  Click **Lifecycle** to view the current states available by default.

4.  Open the WSO2 API Manager Management Console: <https://localhost:9443/carbon>

5.  Navigate to **Extensions &gt; Configure &gt; Lifecycles**.

    ![]({{base_path}}/assets/img/learn/lifecycle-menu.png)
    
6.  Click the **View/Edit** link corresponding to the default API LifeCycle.

    ![]({{base_path}}/assets/img/learn/api-lifecycle-veiw.png) 
    
     The APILifeCycle configurations appear.

    ``` java
        <aspect name="APILifeCycle" class="org.wso2.carbon.governance.registry.extensions.aspects.DefaultLifeCycle">
            <configuration type="literal">
                <lifecycle>
                    <scxml xmlns="http://www.w3.org/2005/07/scxml"
                           version="1.0"
                           initialstate="Created">
                    <state id="Created">
                        <datamodel>

                            <data name="checkItems">
                                <item name="Deprecate old versions after publish the API" forEvent="">
                                </item>
                                <item name="Requires re-subscription when publish the API" forEvent="">
                                </item>
                            </data>

                            <data name="transitionExecution">
                                <execution forEvent="Deploy as a Prototype"
                                           class="org.wso2.carbon.apimgt.impl.executors.APIExecutor">
                                </execution>
                                <execution forEvent="Publish"
                                           class="org.wso2.carbon.apimgt.impl.executors.APIExecutor">
                                </execution>
                            </data>
                        </datamodel>
                        <transition event="Publish" target="Published"/>
                        <transition event="Deploy as a Prototype" target="Prototyped"/>

                    </state>

                    <state id="Prototyped">
                        <datamodel>
                            <data name="checkItems">
                                <item name="Deprecate old versions after publish the API" forEvent="">
                                </item>
                                <item name="Requires re-subscription when publish the API" forEvent="">
                                </item>
                            </data>

                            <data name="transitionExecution">
                                <execution forEvent="Publish"
                                           class="org.wso2.carbon.apimgt.impl.executors.APIExecutor">
                                </execution>
                                <execution forEvent="Demote to Created"
                                           class="org.wso2.carbon.apimgt.impl.executors.APIExecutor">
                                </execution>
                            </data>
                        </datamodel>
                        <transition event="Publish" target="Published"/>
                        <transition event="Demote to Created" target="Created"/>
                        <transition event="Deploy as a Prototype" target="Prototyped"/>
                    </state>


                    <state id="Published">

                        <datamodel>

                            <data name="transitionExecution">
                                <execution forEvent="Block"
                                           class="org.wso2.carbon.apimgt.impl.executors.APIExecutor">
                                </execution>
                                <execution forEvent="Deprecate"
                                           class="org.wso2.carbon.apimgt.impl.executors.APIExecutor">
                                </execution>
                                <execution forEvent="Demote to Created"
                                           class="org.wso2.carbon.apimgt.impl.executors.APIExecutor">
                                </execution>
                                <execution forEvent="Deploy as a Prototype"
                                           class="org.wso2.carbon.apimgt.impl.executors.APIExecutor">
                                </execution>

                            </data>
                        </datamodel>
                        <transition event="Block" target="Blocked"/>
                        <transition event="Deploy as a Prototype" target="Prototyped"/>
                        <transition event="Demote to Created" target="Created"/>
                        <transition event="Deprecate" target="Deprecated"/>
                        <transition event="Publish" target="Published"/>
                    </state>

                    <state id="Blocked">
                        <datamodel>
                            <data name="transitionExecution">
                                <execution forEvent="Re-Publish"
                                           class="org.wso2.carbon.apimgt.impl.executors.APIExecutor">
                                </execution>
                                <execution forEvent="Deprecate"
                                           class="org.wso2.carbon.apimgt.impl.executors.APIExecutor">
                                </execution>
                            </data>
                        </datamodel>
                        <transition event="Deprecate" target="Deprecated"/>
                        <transition event="Re-Publish" target="Published"/>
                    </state>

                    <state id="Deprecated">
                        <datamodel>
                            <data name="transitionExecution">
                                <execution forEvent="Retire"
                                           class="org.wso2.carbon.apimgt.impl.executors.APIExecutor">
                                </execution>
                            </data>
                        </datamodel>
                        <transition event="Retire" target="Retired"/>
                    </state>

                    <state id="Retired">
                    </state>
                </scxml>
            </lifecycle>
        </configuration>
    </aspect>
    ```
7.  Update the API lifecycle definition.

     1.  Add a sample state to the API Lifecycle.
        
         Copy and paste the following sample code in the file.

        !!! info
            The sample **REJECTED** state is added between **PUBLISHED** and **RETIRED** . It uses the `Re-submit` and `Retire` state transition events to change to the consequent states. Custom checklist items are also given under `"checkItems"` , which are tasks to be done in a state transition. You can select/deselect these items in the management console.


        ``` java
                 <state id="Rejected">
                    <datamodel>
                        <data name="checkItems">
                            <item name="Deprecate old versions after rejecting the API" forEvent="">
                            </item>
                            <item name="Remove subscriptions after rejection" forEvent="">
                            </item>
                        </data>
                        <data name="transitionExecution">
                            <execution forEvent="Re-Submit" class="org.wso2.carbon.apimgt.impl.executors.APIExecutor">
                            </execution>
                            <execution forEvent="Retire" class="org.wso2.carbon.apimgt.impl.executors.APIExecutor">
                            </execution>
                        </data>
                    </datamodel>
                        <transition event="Re-Submit" target="Published"/>
                        <transition event="Retire" target="Retired"/>
                </state>
        ```

         !!! note
             The same execution class is used ( `org.wso2.carbon.apimgt.impl.executors.APIExecutor` ) for all state transitions. However, you can plug your own execution code when modifying the life cycle configuration.

         For example, if you want to add notifications for a specific state transition, you can plug your own custom execution class for that particular state in the API life cycle. Any changes are updated in the **Lifecycle** tab accordingly.


    2.  Add a new transition event under the PUBLISHED state, to show the state change to REJECTED.

         ``` java
         ...   
            <transition event="Reject" target="Rejected"/>
         ...
         ```

8.  Make the transition event visible in API Publisher.
     
     1.  Open the `<API-M_HOME>/repository/deployment/server/jaggeryapps/publisher/site/conf/locales/jaggery/locale_default.json` file.
    
     2.  Add the following code in the file. Note that the key value in the JSON pair should be lowercase.

        ``` java
        "reject": "Rejected",
        ```

9.  Restart the WSO2 API Manager server.

10.  Re-open API Publisher and check the Lifecycle to see the changes.

     ![]({{base_path}}/assets/attachments/103328609/103328611.png)

!!! tip
    Consider the following points when extending and customizing the API lifecycle XML configuration.

-   Do not change the life cycle name since it needs to be engaged with the APIs dynamically.
-   Make sure you keep the **PUBLISHED** and **PROTOTYPED** states as those two states will be used by API Publisher in the API creation wizard.


For more details on customizing the API lifecycle, see [Extending the API Life Cycle]({{base_path}}/learn/design-api/lifecycle-management/extending-the-api-life-cycle/) .
