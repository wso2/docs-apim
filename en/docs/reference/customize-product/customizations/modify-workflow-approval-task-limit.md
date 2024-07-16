# Modify Workflow Approval Task Limit

By default, in the Admin Portal(https://<host>:<port>/admin), only 25 workflow approval tasks can be seen. If you expect to have more than 25 pending approval tasks at a time, in order to view them, you need to increase the "limit" parameter inside the `<APIM_HOME>/repository/deployment/server/jaggeryapps/admin/site/public/conf/settings.js` file.

## Steps to Modify Workflow Approval Task Limit

1. **Navigate to the configuration file:**

      - Go to the `<APIM_HOME>/repository/deployment/server/jaggeryapps/admin/site/public/conf/` directory.
      - Open the `settings.js` file in a text editor.

2. **Locate the workflows configuration:**

      - Find the section in the `settings.js` file where the `workflows` object is defined.

3. **Update the limit parameter:**

      - Modify the `limit` parameter to a higher value to suite your requirements. For example, to set the limit to 50 tasks, update the file as follows:
   
      ```javascript
      workflows: {
         limit: 50,
      }
      ```

4. **Save the changes:**
      - Save the `settings.js` file after making the changes.

5. **Restart the server:**
      - Restart the APIM server to apply the changes.
