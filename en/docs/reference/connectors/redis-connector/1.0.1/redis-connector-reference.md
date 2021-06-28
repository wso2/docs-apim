# Redis Connector Reference

To use the Redis connector, add the <redis.init> element in your configuration before carrying out any other Redis operations. 

??? note "redis.init"
    The redis.init operation initializes the connector to interact with Redis.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisHost</td>
            <td>The Redis host name (default localhost).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisPort</td>
            <td>The port on which the Redis server is running (the default port is 6379).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisTimeout</td>
            <td>The server TTL (Time to Live) in milliseconds.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    ```xml
    <redis.init>
        <redisHost>{$ctx:redisHost}</redisHost>
        <redisPort>{$ctx:redisPort}</redisPort>
        <redisTimeout>{$ctx:redisTimeout}</redisTimeout>
    </redis.init>
    ```

---

### Connection Commands

??? note "echo"
    The echo operation returns a specified string. See the [related documentation](https://redis.io/commands/echo) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisMessage</td>
            <td>The message that you want to echo.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.echo>
        <redisMessage>{$ctx:redisMessage}</redisMessage>
    </redis.echo>
    ```
    
    **Sample request**

    ```json
    {
        "redisMessage":"sampleMessage"
    }
    ```

??? note "ping"
    The ping operation pings the server to verify whether the connection is still alive. See the [related documentation](https://redis.io/commands/ping) for more information.

    **Sample configuration**

    ```xml
    <redis.ping/>
    ```
    
    **Sample request**

    An empty request can be handled by the ping operation.

??? note "quit"
    The quit operation closes the connection to the server. See the [related documentation](https://redis.io/commands/quit) for more information.

    **Sample configuration**

    ```xml
    <redis.quit/>
    ```
    
    **Sample request**

    An empty request can be handled by the quit operation.

### Hashes

??? note "hDel"
    The hDel operation deletes one or more specified hash fields. See the [related documentation](https://redis.io/commands/hdel) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key where the hash is stored.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisFields</td>
            <td>The fields that you want to delete.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.hDel>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisFields>{$ctx:redisFields}</redisFields>
    </redis.hDel>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisFields":"sampleField1 sampleField2"
    }
    ```

??? note "hExists"
    The hExists operation determines whether a specified hash field exists. See the [related documentation](https://redis.io/commands/hexists) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key where the hash is stored.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisFields</td>
            <td>The fields that determine existence.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.hExists>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisFields>{$ctx:redisFields}</redisFields>
    </redis.hExists>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisFields":"sampleField"
    }
    ```

??? note "hGet"
    The hGet operation retrieves the value of a particular field in a hash stored in a specified key. See the [related documentation](https://redis.io/commands/hget) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key where the hash is stored.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisFields</td>
            <td>The field for which you want to retrieve the value.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.hGet>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisFields>{$ctx:redisFields}</redisFields>
    </redis.hGet>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisFields":"sampleField"
    }
    ```

??? note "hGetAll"
    The hGetAll operation retrieves all the fields and values of a hash stored in a specified key. See the [related documentation](https://redis.io/commands/hgetall) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key where the hash is stored.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.hGetAll>
        <redisKey>{$ctx:redisKey}</redisKey>
    </redis.hGetAll>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey"
    }
    ```

??? note "hIncrBy"
    The hIncrBy operation increments the integer value of a hash field by the specified amount. See the [related documentation](https://redis.io/commands/hincrby) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key where the hash is stored.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisFields</td>
            <td>The hash field for which you want to increment the value.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisValue</td>
            <td>The amount by which you want to increment the hash field value.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.hIncrBy>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisField>{$ctx:redisField}</redisField>
        <redisValue>{$ctx:redisValue}</redisValue>
    </redis.hIncrBy>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisField":"sampleField",
        "redisValue":"1"
    }
    ```

??? note "hKeys"
    The hKeys operation retrieves all the fields in a hash. See the [related documentation](https://redis.io/commands/hkeys) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key where the hash is stored.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.hKeys>
        <redisKey>{$ctx:redisKey}</redisKey>
    </redis.hKeys>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey"
    }
    ```

??? note "hLen"
    The hLen operation retrieves the number of fields in a hash. See the [related documentation](https://redis.io/commands/hlen) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key where the hash is stored.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.hKeys>
        <redisKey>{$ctx:redisKey}</redisKey>
    </redis.hKeys>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey"
    }
    ```

??? note "hMGet"
    The hMGet operation retrieves values associated with each of the specified fields in a hash that is stored in a particular key. See the [related documentation](https://redis.io/commands/hmget) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key where the hash is stored.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisFields</td>
            <td>The hash field for which you want to retrieve values.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.hMGet>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisFields>{$ctx:redisFields}</redisFields>
    </redis.hMGet>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisFields":"sampleField1 sampleField2"
    }
    ```

??? note "hMSet"
    The hMSet operation sets specified fields to their respective values in the hash stored in a particular key. See the [related documentation](https://redis.io/commands/hmset) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key where the hash is stored.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisFieldsValues</td>
            <td>The fields you want to set and their respective values.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.hMSet>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisFieldsValues>{$ctx:redisFieldsValues}</redisFieldsValues>
    </redis.hMSet>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisFieldsValues":"sampleField1 sampleValue1 sampleField2 sampleValue2"
    }
    ```

??? note "hSet"
    The hSet operation sets a specific field in a hash to a specified value. See the [related documentation](https://redis.io/commands/hset) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key where the hash is stored.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisFields</td>
            <td>The field for which you want to set a value.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisValue</td>
            <td>The amount by which you want to increment the hash field value.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.hSet>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisField>{$ctx:redisField}</redisField>
        <redisValue>{$ctx:redisValue}</redisValue>
    </redis.hSet>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisField":"sampleField",
        "redisValue":"1"
    }
    ```

??? note "hSetnX"
    The hSetnX operation sets a specified field to a value, only if the field does not already exist in the hash. If field already exists, this operation has no effect. See the [related documentation](https://redis.io/commands/hsetnx) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key where the hash is stored.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisFields</td>
            <td>The field for which you want to set a value.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisValue</td>
            <td>The amount by which you want to increment the hash field value.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.hSetnX>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisField>{$ctx:redisField}</redisField>
        <redisValue>{$ctx:redisValue}</redisValue>
    </redis.hSetnX>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisField":"sampleField",
        "redisValue":"1"
    }
    ```

??? note "hVals"
    The hVals operation retrieves all values in a hash that is stored in a particular key. See the [related documentation](https://redis.io/commands/hvals) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key where the hash is stored.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.hVals>
        <redisKey>{$ctx:redisKey}</redisKey>
    </redis.hVals>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey"
    }
    ```

### Keys

??? note "del"
    The del operation deletes a specified key if it exists. See the [related documentation](https://redis.io/commands/del) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key that you want to delete.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.del>
        <redisKey>{$ctx:redisKey}</redisKey>
    </redis.del>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey"
    }
    ```

??? note "exists"
    The exists operation determines whether a specified key exists. See the [related documentation](https://redis.io/commands/exists) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key that you want to determine existence.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.exists>
        <redisKey>{$ctx:redisKey}</redisKey>
    </redis.exists>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey"
    }
    ```

??? note "expire"
    The expire operation sets a TTL(Time to live) for a key so that the key will automatically delete once it reaches the TTL. The TTL should be specified in seconds. See the [related documentation](https://redis.io/commands/expire) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key that you want to specify a TTL.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisSeconds</td>
            <td>The number of seconds representing the TTL that you want to set for the key.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.expire>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisSeconds>{$ctx:redisSeconds}</redisSeconds>
    </redis.expire>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisSeconds":"10"
    }
    ```

??? note "expireAt"
    The expireAt operation sets the time after which an existing key should expire. Here the time should be specified as a UNIX timestamp. See the [related documentation](https://redis.io/commands/expireat) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key that you want to set an expiration.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisUnixTime</td>
            <td>The time to expire specified in the UNIX timestamp format.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.expire>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisUnixTime>{$ctx:redisUnixTime}</redisUnixTime>
    </redis.expire>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisUnixTime":"1293840000"
    }
    ```

??? note "keys"
    The keys operation retrieves all keys that match a specified pattern. See the [related documentation](https://redis.io/commands/keys) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisPattern</td>
            <td>The pattern that you want to match when retrieving keys.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.keys>
        <redisPattern>{$ctx:redisPattern}</redisPattern>
    </redis.keys>
    ```
    
    **Sample request**

    ```json
    {
        "redisPattern":"*"
    }
    ```

??? note "randomKey"
    A sample request with an empty body can be handled by the randomKey operation. See the [related documentation](https://redis.io/commands/randomkey) for more information.
    
    **Sample configuration**

    ```xml
    <redis.randomKey/>
    ```
    
    **Sample request**

    ```json
    {
        "redisPattern":"*"
    }
    ```

??? note "rename"
    The rename operation renames an existing key to a new name that is specified. See the [related documentation](https://redis.io/commands/rename) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisOldKey</td>
            <td>The name of an existing key that you want to rename.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisNewKey</td>
            <td>The new name that you want the key to have.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.rename>
        <redisOldKey>{$ctx:redisOldKey}</redisOldKey>
        <redisNewKey>{$ctx:redisNewKey}</redisNewKey>
    </redis.rename>
    ```
    
    **Sample request**

    ```json
    {
        "redisOldKey":"sampleOldKey",
        "redisNewKey":"sampleNewKey"
    }
    ```

??? note "renamenX"
    The renamenX operation renames a key to a new key, only if the new key does not already exist. See the [related documentation](https://redis.io/commands/renamenx) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisOldKey</td>
            <td>The name of an existing key that you want to rename.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisNewKey</td>
            <td>The new name that you want the key to have.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.renamenX>
        <redisOldKey>{$ctx:redisOldKey}</redisOldKey>
        <redisNewKey>{$ctx:redisNewKey}</redisNewKey>
    </redis.renamenX>
    ```
    
    **Sample request**

    ```json
    {
        "redisOldKey":"sampleOldKey",
        "redisNewKey":"sampleNewKey"
    }
    ```

??? note "ttl"
    The ttl operation retrieves the TTL (Time to Live) value of a specified key. See the [related documentation](https://redis.io/commands/ttl) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key for which you want to retrieve the TTL.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.ttl>
        <redisKey>{$ctx:redisKey}</redisKey>
    </redis.ttl>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey"
    }
    ```

??? note "type"
    The type operation retrieves the data type of a value stored in a specified key. See the [related documentation](https://redis.io/commands/type) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key that the value is stored.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.type>
        <redisKey>{$ctx:redisKey}</redisKey>
    </redis.type>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey"
    }
    ```

### Lists

??? note "blPop"
    The blPop operation retrieves the first element in a list, if available, or blocks the connection for a specified amount of time until an element is available. See the [related documentation](https://redis.io/commands/blpop) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key where the list is stored.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisBrPopTimeout</td>
            <td>The amount of time to keep the connection blocked, waiting for an element to be available in the tail of the list.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.brPop>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisBrPopTimeout>{$ctx:redisBrPopTimeout}</redisBrPopTimeout>
    </redis.brPop>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey"
        "redisBrPopTimeout":"0"
    }
    ```

??? note "brPop"
    The brPop operation retrieves the last element in a list, if available, or blocks the connection for a specified amount of time until an element is available. See the [related documentation](https://redis.io/commands/brpop) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key where the list is stored.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisBlPopTimeout</td>
            <td>The amount of time to keep the connection blocked, waiting for an element to be available in the head of the list.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.blPop>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisBlPopTimeout>{$ctx:redisBlPopTimeout}</redisBlPopTimeout>
    </redis.blPop>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey"
        "redisBlPopTimeout":"0"
    }
    ```

??? note "lInsert"
    The lInsert operation inserts a specified element before or after an existing element in a list that is stored in a specified key. See the [related documentation](https://redis.io/commands/linsert) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key where the list is stored.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisWhere</td>
            <td>The place where you want to add an element. Possible values are BEFORE or AFTER. For example, whether you want to add an element before a particular element that exists in the list.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisPivot</td>
            <td>An existing element in the list that is used as the pivot element.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisValue</td>
            <td>The element that you want to insert to the list.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.lInsert>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisWhere>{$ctx:redisWhere}</redisWhere>
        <redisPivot>{$ctx:redisPivot}</redisPivot>
        <redisValue>{$ctx:redisValue}</redisValue>
    </redis.lInsert>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisWhere":"BEFORE",
        "redisPivot":"samplePivotElement",
        "redisValue":"sampleInsertElement"
    }
    ```

??? note "lLen"
    The lLen operation retrieves the length of a list that is stored in a specified key. See the [related documentation](https://redis.io/commands/llen) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key where the list is stored.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.lLen>
        <redisKey>{$ctx:redisKey}</redisKey>
    </redis.lLen>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
    }
    ```

??? note "lPop"
    The lPop operation retrieves the first element in a list that is stored in a specified key. See the [related documentation](https://redis.io/commands/lpop) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key where the list is stored.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.lLen>
        <redisKey>{$ctx:redisKey}</redisKey>
    </redis.lLen>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey"
    }
    ```

??? note "lPush"
    The lPush operation inserts one or more elements to the head of a list that is stored in a specified key. See the [related documentation](https://redis.io/commands/lpush) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key where the list is stored.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisStrings</td>
            <td>One or more elements that you want to add to the head of the list.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.lPush>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisStrings>{$ctx:redisStrings}</redisStrings>
    </redis.lPush>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisStrings":"sampleValues"
    }
    ```

??? note "lPushX"
    The lPushX operation inserts one or more elements to the head of a list stored in a specified key, only if the key already exists and holds a list. See the [related documentation](https://redis.io/commands/lpushx) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key where the list is stored.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisStrings</td>
            <td>One or more elements that you want to add to the head of the list.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.lPushX>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisStrings>{$ctx:redisStrings}</redisStrings>
    </redis.lPushX>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisStrings":"sampleValues"
    }
    ```

??? note "lRange"
    The lRange operation retrieves a range of elements from a list. See the [related documentation](https://redis.io/commands/lrange) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key where the list is stored.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisStart</td>
            <td>The starting index.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisEnd</td>
            <td>The ending index.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.lRange>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisStart>{$ctx:redisStart}</redisStart>
        <redisEnd>{$ctx:redisEnd}</redisEnd>
    </redis.lRange>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisStart":"0",
        "redisEnd":"-1"
    }
    ```

??? note "lRem"
    The lRem operation removes elements from a list. See the [related documentation](https://redis.io/commands/lrem) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key where the list is stored.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisCount</td>
            <td>The number of occurrences of the element that you want to remove.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisValue</td>
            <td>The element that you want to remove.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.lRem>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisCount>{$ctx:redisCount}</redisCount>
        <redisValue>{$ctx:redisValue}</redisValue>
    </redis.lRem>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisCount":"1",
        "redisValue":"sampleValue"
    }
    ```

??? note "lSet"
    The lSet operation sets the value of an element in a list by its index. See the [related documentation](https://redis.io/commands/lset) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key where the list is stored.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisIndex</td>
            <td>The starting index.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisValue</td>
            <td>The value of the key</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.lSet>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisIndex>{$ctx:redisIndex}</redisIndex>
        <redisValue>{$ctx:redisValue}</redisValue>
    </redis.lSet>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisIndex":"0",
        "redisValue":"sampleValue"
    }
    ```

??? note "lTrim"
    The lTrim operation trims a list to a specified range. See the [related documentation](https://redis.io/commands/ltrim) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key where the list is stored.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisStart</td>
            <td>The starting index.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisEnd</td>
            <td>The ending index.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.lTrim>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisStart>{$ctx:redisStart}</redisStart>
        <redisEnd>{$ctx:redisEnd}</redisEnd>
    </redis.lTrim>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisStart":"0",
        "redisEnd":"-1"
    }
    ```

??? note "rPopLPush"
    The rPopLPush operation removes the last element in a list, then inserts it to another list, and then returns it. See the [related documentation](https://redis.io/commands/rpoplpush) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisSrckey</td>
            <td>The name of the source key from where the last element is retrieved.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisDstkey</td>
            <td>The name of destination key.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.rPopLPush>
        <redisSrckey>{$ctx:redisSrckey}</redisSrckey>
        <redisDstkey>{$ctx:redisDstkey}</redisDstkey>
    </redis.rPopLPush>
    ```
    
    **Sample request**

    ```json
    {
        "redisSrckey":"sampleSourceKey",
        "redisDstkey":"sampleDestinationKey"
    }
    ```

??? note "rPush"
    The rPush operation inserts one or more elements to the tail of a list that is stored in a specified key. See the [related documentation](https://redis.io/commands/rpush) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key where the list is stored.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisStrings</td>
            <td>One or more elements that you want to add to the tail of the list.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.rPush>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisStrings>{$ctx:redisStrings}</redisStrings>
    </redis.rPush>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisStrings":"sampleValues"
    }
    ```

??? note "rPushX"
    The rPushX operation inserts one or more elements to the tail of a list stored in a specified key, only if the key already exists and holds a list. See the [related documentation](https://redis.io/commands/rpushx) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key where the list is stored.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisValue</td>
            <td>One or more elements that you want to add to the tail of the list.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.rPushX>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisValue>{$ctx:redisValue}</redisValue>
    </redis.rPushX>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisValue":"sampleValue"
    }
    ```

### Server Commands

??? note "flushAll"
    The flushAll operation deletes all the keys from all existing databases. See the [related documentation](https://redis.io/commands/flushall) for more information.

    **Sample configuration**

    ```xml
    <redis.flushAll/>
    ```
    
    **Sample request**

    A sample request with an empty body can be handled by the flushAll operation.

??? note "flushDB"
    The flushDB operation deletes all the keys from the currently selected database. See the [related documentation](https://redis.io/commands/flushdb) for more information.

    **Sample configuration**

    ```xml
    <redis.flushDB/>
    ```
    
    **Sample request**

    A sample request with an empty body can be handled by the flushDB operation.

### Sets

??? note "sadd"
    The sadd operation is used to add one or more members to a set. See the [related documentation](https://redis.io/commands/sadd) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisMembers</td>
            <td>The value to be added to the key.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.sadd>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisMembers>{$ctx:redisMembers}</redisMembers>
    </redis.sadd>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisMembers":"sampleValue"
    }
    ```

??? note "sDiffStore"
    The sDiffStore operation is used to subtract multiple sets and store the resulting set in a key. See the [related documentation](https://redis.io/commands/sdiffstore) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisDstkey</td>
            <td>The name of the destination key.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.sDiffStore>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisDstkey>{$ctx:redisDstkey}</redisDstkey>
    </redis.sDiffStore>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisDstkey":"sampleDestinationKey"
    }
    ```

??? note "sInter"
    The sInter operation is used to intersect multiple sets. See the [related documentation](https://redis.io/commands/sinter) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.sInter>
        <redisKey>{$ctx:redisKey}</redisKey>
    </redis.sInter>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey"
    }
    ```

??? note "sInterStore"
    The sInterStore operation is used to intersect multiple sets and store the resulting set in a key. See the [related documentation](https://redis.io/commands/sinterstore) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisDstkey</td>
            <td>The name of the destination key.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.sDiffStore>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisDstkey>{$ctx:redisDstkey}</redisDstkey>
    </redis.sDiffStore>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisDstkey":"sampleDestinationKey"
    }
    ```

??? note "sIsMember"
    The sIsMember operation is used to determine if a given value is a member of a set. See the [related documentation](https://redis.io/commands/sismember) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisMembers</td>
            <td>The name of a member in a key.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.sIsMember>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisMembers>{$ctx:redisMembers}</redisMembers>
    </redis.sIsMember>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisMembers":"sampleValue"
    }
    ```

??? note "sMembers"
    The sMembers operation is used to get the all members in a set. See the [related documentation](https://redis.io/commands/smembers) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.sMembers>
        <redisKey>{$ctx:redisKey}</redisKey>
    </redis.sMembers>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey"
    }
    ```

??? note "sMove"
    The sMove operation is used to move a member from one set to another. See the [related documentation](https://redis.io/commands/smove) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisSrckey</td>
            <td>The name of the source key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisDstkey</td>
            <td>The name of the destination key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisMember</td>
            <td>The name of the member.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.sMove>
        <redisSrckey>{$ctx:redisSrckey}</redisSrckey>
        <redisDstkey>{$ctx:redisDstkey}</redisDstkey>
        <redisMember>{$ctx:redisMember}</redisMember>
    </redis.sMove>
    ```
    
    **Sample request**

    ```json
    {
        "redisSrckey":"sampleSourceKey",
        "redisDstkey":"sampleDestinationKey",
        "redisMember":"sampleMember"
    }
    ```

??? note "sPop"
    The sPop operation is used to remove and return one or multiple random members from a set. See the [related documentation](https://redis.io/commands/spop) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.sPop>
        <redisKey>{$ctx:redisKey}</redisKey>
    </redis.sPop>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey"
    }
    ```

??? note "sRandMember"
    The sRandMember operation is used to get one or multiple random members from a set. See the [related documentation](https://redis.io/commands/srandmember) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.sRandMember>
        <redisKey>{$ctx:redisKey}</redisKey>
    </redis.sRandMember>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey"
    }
    ```

??? note "sRem"
    The sRem operation is used to remove one or more members from a set. See the [related documentation](https://redis.io/commands/srem) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisMembers</td>
            <td>The name of a member in a key.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.sRem>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisMembers>{$ctx:redisMembers}</redisMembers>
    </redis.sRem>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisMembers":"sampleValue"
    }
    ```

??? note "sUnion"
    The sUnion operation is used to add multiple sets. See the [related documentation](https://redis.io/commands/sunion) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.sUnion>
        <redisKey>{$ctx:redisKey}</redisKey>
    </redis.sUnion>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey"
    }
    ```

??? note "sUnionStore"
    The sUnionStore operation is used to add multiple sets and store the resulting set in a key. See the [related documentation](https://redis.io/commands/sunionstore) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisDstkey</td>
            <td>The name of the destination key.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.sUnionStore>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisDstkey>{$ctx:redisDstkey}</redisDstkey>
    </redis.sUnionStore>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisDstkey":"sampleValue"
    }
    ```

### Sorted Sets

??? note "zadd"
    The zadd operation adds one or more members to a sorted set, or update its score if a specified member already exists. See the [related documentation](https://redis.io/commands/zadd) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisScore</td>
            <td>The score of the sorted set.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisMembers</td>
            <td>The name of a member you want to add.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.zadd>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisScore>{$ctx:redisScore}</redisScore>
        <redisMember>{$ctx:redisMember}</redisMember>
    </redis.zadd>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisScore":"1.1",
        "redisMembers":"sampleMember"
    }
    ```

??? note "zCount"
    The zCount operation retrieves a count of members in a sorted set, with scores that are within the min and max values specified. See the [related documentation](https://redis.io/commands/zcount) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>redisKey</td>
            <td>The name of the key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisMin</td>
            <td>The minimum score value.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>redisMax</td>
            <td>The maximum score value.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <redis.zCount>
        <redisKey>{$ctx:redisKey}</redisKey>
        <redisMin>{$ctx:redisMin}</redisMin>
        <redisMax>{$ctx:redisMax}</redisMax>
    </redis.zCount>
    ```
    
    **Sample request**

    ```json
    {
        "redisKey":"sampleKey",
        "redisMin":"1.1",
        "redisMax":"2.2"
    }
    ```