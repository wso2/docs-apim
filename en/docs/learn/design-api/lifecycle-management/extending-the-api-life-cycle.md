# Extending the API Life Cycle

APIs created in WSO2 API Manager have their own life cycle consisting of the following: a set of life cycle states, specific actions for each state transition, and a checklist of items before a state transition occurs. In previous API Manager versions, an API had a predefined life cycle consists of [six states]({{base_path}}/Learn/DesignAPI/LifecycleManagement/api-lifecycle/#api-lifecycle-states) which could not be customized or extended. From API Manager 1.10.0 onwards, you can extend the API life cycle with the WSO2 registry based life cycle in API Manager.

## Default API Lifecycle in WSO2 API Manager

The WSO2 registry based life cycle provides a configurable way to define the life cycle of an artifact, which can be extended easily, as the default API life cycle is defined as an XML configuration.

!!! note

    Note that this extending capability of the API life cycle is not available in API Manager versions prior to 1.10.0.


To see the default API life cycle configuration, follow the steps below.

1.  Start the API Manager server and log into the management console: <https://localhost:9443/carbon>.

2.  Navigate to **Extensions &gt; Configure &gt; Lifecycles**.

     ![]({{base_path}}/assets/img/Learn/api-lifecycle-veiw.png) 

3.  Click the **View/Edit** link corresponding to the API LifeCycle. T he default API life cycle configuration opens.

    ``` xml
        <aspect name="APILifeCycle" class="org.wso2.carbon.governance.registry.extensions.aspects.DefaultLifeCycle">
            <configuration type="literal">
                <lifecycle>
                    <scxml xmlns="http://www.w3.org/2005/07/scxml"
                           version="1.0"
                           initialstate="Created">
                        <state id="Created">
                            <datamodel>
                                <data name="checkItems">
                                    <item name="Deprecate Old Versions" forEvent="">
                                    </item>
                                    <item name="Require Re-Subscription" forEvent="">
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
                                <execution forEvent="Demote to Prototyped"
                                           class="org.wso2.carbon.apimgt.impl.executors.APIExecutor">
                                </execution>
                            </data>
                        </datamodel>
                        <transition event="Block" target="Blocked"/>
                        <transition event="Demote to Prototyped" target="Prototyped"/>
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
The above configuration includes the following important information:

1.  Lifecycle name: APILifeCycle.

2.  Set of six default states: **CREATED** , **PROTOTYPED** , **PUBLISHED** , **BLOCKED** , **DEPRECATED** , **RETIRED**

3.  Set of checklist items to be satisfied:  For example, when the API is in the **CREATED** state and has multiple versions, there are two checks that occur; deprecate old versions and re-subscriptions required.

4.  State transition events: Defines from which state to which target state an API can be moved.

5.  Actions for each state transition: A triggered action that executes during each state transition. For example, when an API state changes from **CREATED** to **PUBLISHED** , an execution occurs as a relative synapse API where an XML element is created and the related API data is saved in the database. This execution is defined for each state transition in the above registry life cycle configuration.


    The state transition events that occur in the default API life cycle is shown in the following diagram:

    ![]({{base_path}}/assets/attachments/103334766/103334771.png)

The **Lifecycle** tab shows the current state of an API, the target events defined in the API life cycle for that state, and the set of checklist items.

![]({{base_path}}/assets/attachments/103334766/103334768.png)

![]({{base_path}}/assets/attachments/103334766/103334767.png)

!!! note

    This UI is static in the default stage and is dynamically generated based on the defined API life cycle in the above XML configuration.

If you customize the default API life cycle configuration including states, transition events or check list items, those changes are updated in the life cycle of the Publisher UI accordingly.


## Extension Points of API Lifecycle

With the integration of the registry life cycle to the API life cycle of WSO2 API Manager, it is possible to extend the existing API life cycle and customize it according to your preference. Following are some extention points where the default API life cycle can be extended by modifying above mentioned XML configuration of the API life cycle.

!!! tip
    Consider the following points when extending and customising the API life cycle XML configuration.

-   Do not change the life cycle name since it needs to be engaged with the APIs dynamically.
-   Make sure you keep the **PUBLISHED** and **PROTOTYPED** states as those two states will be used by API Publisher in the API creation wizard.


Following are some extension points that can be used:

-   [Define your own life cycle states]({{base_path}}/Learn/DesignAPI/LifecycleManagement/customize-api-life-cycle/}) in the API life cycle
-   Change the state transition events as per the environmental preferences
-   Add custom checklist items for specific state transitions
-   Change the execution code for each state transition

!!! info
    For all state transitions, the same execution class is used ( `org.wso2.carbon.apimgt.impl.executors.APIExecutor` ). However, you can plug your own execution code when modifying the life cycle configuration. For example, if you want to add notifications for a specific state transition, you can plug your own custom execution class for that particular state in the API life cycle. Any changes are updated in the **Lifecycle** tab accordingly.


When a new transition event is introduced to the life cycle, an entry must be made to the `locale_default.json` file in order to view that life cycle transition event in the Publisher **Lifecycle** tab. This is introduced to support multi-language facility. For example, let's say a transition event called Notify Users is introduced in the **DEPRECATED** state as follows,

``` xml
<state id="Deprecated">
    <datamodel>
            <data name="transitionExecution">
                <execution forEvent="Retire"
                            class="org.wso2.carbon.apimgt.impl.executors.APIExecutor">
                </execution>
            </data>
    </datamodel>
    <transition event="Retire" target="Retired"/>
    <transition event="Notify Users" target="Retired"/>
</state>
```

You need to add `"notify users" : "Notify Users"` as an entry in the `<APIM_HOME>/repository/deployment/server/jaggeryapps/publisher/site/conf/locales/jaggery/locale_default.json` file. Note that the key value in this entry should be in lower case (e.g. notify users).

For other languages , add the entry to the relevant file. For further information, see [Adding Internationalization and Localization](https://docs.wso2.com/display/AM260/Adding+Internationalization+and+Localization).
