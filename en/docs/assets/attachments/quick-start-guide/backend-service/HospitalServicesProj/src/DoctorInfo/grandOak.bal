// Copyright (c) 2019 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;
import ballerina/log;

@http:ServiceConfig {
    basePath: "/grandOak"
}
service grandOakService on new http:Listener(9090) {

    @http:ResourceConfig {
        path: "/doctors/{doctorType}",
        methods: ["GET"]
    }
    resource function doctors(http:Caller caller, http:Request request, string doctorType) returns error? {

        json responsePayload = {};
        if (doctorType == "Ophthalmologist" || doctorType == "ophthalmologist") {
            responsePayload = {
                "doctors": {
                    "doctor": [
                    {
                        "name": "John Mathew",
                        "time": "03:30 PM",
                        "hospital": "Grand Oak"
                    },
                    {
                        "name": "Allan Silvester",
                        "time": "04:30 PM",
                        "hospital": "Grand Oak"
                    }
                    ]
                }
            };
        } else if (doctorType == "Physician" || doctorType == "physician") {
            responsePayload = {
                "doctors": {
                    "doctor": [
                    {
                        "name": "Shane Martin",
                        "time": "07:30 AM",
                        "hospital": "Grand Oak"
                    },
                    {
                        "name": "Geln Ivan",
                        "time": "08:30 AM",
                        "hospital": "Grand Oak"
                    }
                    ]
                }
            };
        } else if (doctorType == "Pediatrician" || doctorType == "pediatrician") {
            responsePayload = {
                "doctors": {
                    "doctor": [
                    {
                        "name": "Bob Watson",
                        "time": "05:30 PM",
                        "hospital": "Grand Oak"
                    },
                    {
                        "name": "Paul Johnson",
                        "time": "07:30 AM",
                        "hospital": "Grand Oak"
                    }
                    ]
                }
            };
        } else {
            handleError(caller, "Invalid doctor category");
            return;
        }
        http:Response response = new;
        response.setJsonPayload(responsePayload, "application/json");
        var result = caller->respond(response);
        // Logs the `error` in case of a failure.
        if (result is error) {
            log:printError("Error sending response", err = result);
        }
    }
}