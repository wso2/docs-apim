# **Role based access control for Admin Portal**

Super admin can restrict each section in the admin portal based on the scopes. Please follow the
below scopes  chart to define scopes.

| **Admin portal Menu**  | **scopes**                                                                                                                                   |
|------------------------|----------------------------------------------------------------------------------------------------------------------------------------------|
| Rate Limiting Policies | apim:admin_tier_view, apim:admin_tier_manage,  apim:tenantInfo, apim:bl_view, apim:bl_manage, apim:admin_settings         |
| Gateways               | apim:environment_manage, apim:admin_settings, apim:environment_read                                                                          |
| API Categories         | apim:api_category, apim:tenantInfo, apim:admin_settings                                                                                      |
| Key Managers           | apim:keymanagers_manage, apim:tenantInfo, apim:admin_settings                                                                                |
| Tasks                  | apim:api_workflow_view, apim:api_workflow_approve, apim:tenantInfo, apim:admin_setting                                                       |
| Settings               | apim:app_owner_change, apim:api_provider_change, apim:admin_application_view, apim:scope_manage, apim:admin_settings, apim:tenantInfo          |
