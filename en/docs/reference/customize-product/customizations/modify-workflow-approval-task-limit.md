# Modify Workflow Approval Task Limit

By default, in the admin portal, only 25 workflow approval tasks can be seen. If there are more than 25 approval tasks pending, in order to view them, you need to increase the "limit" parameter inside the `[APIM_HOME]/repository/deployment/server/jaggeryapps/admin/site/public/conf/settings.js` file.

## Steps to Modify Workflow Approval Task Limit

1. **Navigate to the Configuration File:**

      - Go to the `[APIM_HOME]/repository/deployment/server/jaggeryapps/admin/site/public/conf/` directory.
      - Open the `settings.js` file in a text editor.

2. **Locate the Workflows Configuration:**

      - Find the section in the `settings.js` file where the `workflows` object is defined.

3. **Update the Limit Parameter:**

      - Modify the `limit` parameter to a higher value to suit your requirements. For example, to set the limit to 50 tasks, update the file as follows:
   
      ```javascript
      workflows: {
         limit: 50,
      }
      ```

4. **Save the Changes:**
      - Save the `settings.js` file after making the changes.

5. **Restart the Server:**
      - Restart the APIM server to apply the changes.
