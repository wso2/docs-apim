/*
 * Copyright (c) 2020, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 *
 */

package org.wso2.service.hospital;

import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;
import org.json.simple.parser.JSONParser;
import org.wso2.msf4j.Microservice;

/**
 * This is the Microservice resource class.
 * See <a href="https://github.com/wso2/msf4j#getting-started">https://github.com/wso2/msf4j#getting-started</a>
 * for the usage of annotations.
 */
public class HospitalService implements Microservice {

    public JSONObject getGrandOakDoctor(String doctorType) {

        JSONObject jsonPayload = null;
        String responsePayload = null;
        JSONParser parser = new JSONParser();

        if (doctorType.equalsIgnoreCase("Ophthalmologist")) {
            responsePayload = "{\n" +
                    "                \"doctors\": {\n" +
                    "                    \"doctor\": [\n" +
                    "                    {\n" +
                    "                        \"name\": \"John Mathew\",\n" +
                    "                        \"time\": \"03:30 PM\",\n" +
                    "                        \"hospital\": \"Grand Oak\"\n" +
                    "                    },\n" +
                    "                    {\n" +
                    "                        \"name\": \"Allan Silvester\",\n" +
                    "                        \"time\": \"04:30 PM\",\n" +
                    "                        \"hospital\": \"Grand Oak\"\n" +
                    "                    }\n" +
                    "                    ]\n" +
                    "                }\n" +
                    "            }";
        } else if (doctorType.equalsIgnoreCase("Physician")) {
            responsePayload = "{\n" +
                    "                \"doctors\": {\n" +
                    "                    \"doctor\": [\n" +
                    "                    {\n" +
                    "                        \"name\": \"Shane Martin\",\n" +
                    "                        \"time\": \"07:30 AM\",\n" +
                    "                        \"hospital\": \"Grand Oak\"\n" +
                    "                    },\n" +
                    "                    {\n" +
                    "                        \"name\": \"Geln Ivan\",\n" +
                    "                        \"time\": \"08:30 AM\",\n" +
                    "                        \"hospital\": \"Grand Oak\"\n" +
                    "                    }\n" +
                    "                    ]\n" +
                    "                }\n" +
                    "            }";
        } else if (doctorType.equalsIgnoreCase("Pediatrician")) {
            responsePayload = "{\n" +
                    "                \"doctors\": {\n" +
                    "                    \"doctor\": [\n" +
                    "                    {\n" +
                    "                        \"name\": \"Bob Watson\",\n" +
                    "                        \"time\": \"05:30 PM\",\n" +
                    "                        \"hospital\": \"Grand Oak\"\n" +
                    "                    },\n" +
                    "                    {\n" +
                    "                        \"name\": \"Paul Johnson\",\n" +
                    "                        \"time\": \"07:30 AM\",\n" +
                    "                        \"hospital\": \"Grand Oak\"\n" +
                    "                    }\n" +
                    "                    ]\n" +
                    "                }\n" +
                    "            }";

        }
        try {
            if (responsePayload != null) {
                jsonPayload = (JSONObject) parser.parse(responsePayload);
            }
        } catch (ParseException e) {
            throw new RuntimeException("Error parsing response.", e);
        }
        return jsonPayload;
    }

    public JSONObject getPineValleyDoctor(String doctorType) {

        JSONObject jsonPayload = null;
        String responsePayload = null;
        JSONParser parser = new JSONParser();

        if (doctorType.equalsIgnoreCase("Ophthalmologist")) {
            responsePayload = "{\n" +
                    "                    \"doctors\": {\n" +
                    "                        \"doctor\": [\n" +
                    "                        {\n" +
                    "                            \"name\": \"John Mathew\",\n" +
                    "                            \"time\": \"07:30 AM\",\n" +
                    "                            \"hospital\": \"pineValley\"\n" +
                    "                        },\n" +
                    "                        {\n" +
                    "                            \"name\": \"Roma Katherine\",\n" +
                    "                            \"time\": \"04:30 PM\",\n" +
                    "                            \"hospital\": \"pineValley\"\n" +
                    "                        }\n" +
                    "                        ]\n" +
                    "                    }\n" +
                    "                }";
        } else if (doctorType.equalsIgnoreCase("Physician")) {
            responsePayload = "{\n" +
                    "                    \"doctors\": {\n" +
                    "                        \"doctor\": [\n" +
                    "                        {\n" +
                    "                            \"name\": \"Geln Ivan\",\n" +
                    "                            \"time\": \"05:30 PM\",\n" +
                    "                            \"hospital\": \"pineValley\"\n" +
                    "                        },\n" +
                    "                        {\n" +
                    "                            \"name\": \"Daniel Lewis\",\n" +
                    "                            \"time\": \"05:30 PM\",\n" +
                    "                            \"hospital\": \"pineValley\"\n" +
                    "                        }\n" +
                    "                        ]\n" +
                    "                    }\n" +
                    "                }";
        } else if (doctorType.equalsIgnoreCase("Pediatrician")) {
            responsePayload = "{\n" +
                    "                    \"doctors\": {\n" +
                    "                        \"doctor\": [\n" +
                    "                        {\n" +
                    "                            \"name\": \"Bob Watson\",\n" +
                    "                            \"time\": \"07:30 AM\",\n" +
                    "                            \"hospital\": \"pineValley\"\n" +
                    "                        },\n" +
                    "                        {\n" +
                    "                            \"name\": \"Wilson Mcdonald\",\n" +
                    "                            \"time\": \"07:30 AM\",\n" +
                    "                            \"hospital\": \"pineValley\"\n" +
                    "                        }\n" +
                    "                        ]\n" +
                    "                    }\n" +
                    "                }";
        }

        try {
            if (responsePayload != null) {
                jsonPayload = (JSONObject) parser.parse(responsePayload);
            }
        } catch (ParseException e) {
            throw new RuntimeException("Error parsing response.", e);
        }
        return jsonPayload;
    }
}
