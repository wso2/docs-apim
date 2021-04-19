## Formatting get Command Outputs

Output of `get envs`, `get apis`, `get api-products` and `get apps` can be formatted with Go Templates. 

#### Available formatting options

<table>
    <thead>
        <tr class="header">
            <th>Name</th>
            <th>Usage</th>
            <th>Example</th>
        </tr>
    </thead>
    <tbody>
        <tr class="odd">
            <td>table</td>
            <td>This is the default format and the output is displayed as a table</td>
            <td>
                <div style="width: 100%; display: block; overflow: auto;">
                    ``` 
                    --format "table {% raw %}{{.Name}}\t{{.Id}}{% endraw %}" 
                    ```
                </div>
            </td>
        </tr>
        <tr class="odd">
            <td>json</td>
            <td>Output is formatted as JSON</td>
            <td>
                <div style="width: 100%; display: block; overflow: auto;">
                    ```
                    --format "{% raw %}{{ json . }}{% endraw %}" 
                    ```
                </div>
            </td>
        </tr>
        <tr class="odd">
            <td>jsonPretty</td>
            <td>Outputs a human-readable JSON with indented by 2 spaces</td>
            <td>
                <div style="width: 100%; display: block; overflow: auto;">
                    ``` 
                    --format "table {% raw %}{{ jsonPretty . }}{% endraw %}" 
                    ```
                </div>
            </td>
        </tr>
        <tr class="odd">
            <td>upper</td>
            <td>Convert string to uppercase</td>
            <td>
                <div style="width: 100%; display: block; overflow: auto;">
                    ``` 
                    --format "{% raw %}{{upper .Name}}\t{{upper .Context}}{% endraw %}" 
                    ```
                </div>
            </td>
        </tr>
        <tr class="odd">
            <td>lower</td>
            <td>Convert string to lowercase</td>
            <td>
                <div style="width: 100%; display: block; overflow: auto;">
                    ``` 
                    --format "{% raw %}{{lower .Name}}\t{{lower .Context}}{% endraw %}"
                    ```
                </div>
            </td>
        </tr>
        <tr class="odd">
            <td>title</td>
            <td>Convert the first letter to uppercase of a string</td>
            <td>
                <div style="width: 100%; display: block; overflow: auto;">
                    ``` 
                    --format "{% raw %}{{title .Name}}\t{{title .Context}}{% endraw %}" 
                    ```
                </div>
            </td>
        </tr>
    </tbody>
</table>
