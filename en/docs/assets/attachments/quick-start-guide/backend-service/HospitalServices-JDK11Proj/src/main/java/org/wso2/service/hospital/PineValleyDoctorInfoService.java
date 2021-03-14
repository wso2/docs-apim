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

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Path("/pineValley")
public class PineValleyDoctorInfoService extends HospitalService {

    @POST
    @Consumes("application/json")
    @Path("/doctors")
    public Response getDoctorRecord(DoctorTypeBean doctorTypeBean) {

        JSONObject doctorByType = super.getPineValleyDoctor(doctorTypeBean.getDoctorType());
        if (doctorByType.isEmpty()) {
            String msg = "No matching service found for path : /pineValley/doctors/" + doctorTypeBean.getDoctorType();
            return Response.status(Response.Status.OK).entity(msg).type(MediaType.APPLICATION_JSON).build();
        }
        return Response.status(Response.Status.OK).entity(doctorByType).type(MediaType.APPLICATION_JSON).build();
    }
}
