# Enabling or disabling the forum

The Forum is enabled by default in the API Manager Store.
Follow the instructions below to disable the Forum:

1.  Navigate to the `           <API_HOME>/repository/conf/api-manager.xml          ` file.
2.  Uncomment the following code.

    <table>
    <colgroup>
    <col width="100%" />
    </colgroup>
    <tbody>
    <tr class="odd">
    <td><div class="container" title="Hint: double-click to select code">
    <div class="line number1 index0 alt2">
    <code class="java plain">                    &lt;isStoreForumEnabled&gt;                   </code> <code class="java keyword">                    false                   </code> <code class="java plain">                    &lt;/isStoreForumEnabled&gt;                   </code>
    </div>
    </div></td>
    </tr>
    </tbody>
    </table>

3.  Restart WSO2 API Manager.
    If you access the API Store, you will notice that the Forum is no longer available.

