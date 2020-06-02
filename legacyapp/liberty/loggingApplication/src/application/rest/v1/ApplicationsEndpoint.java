/*
 * Copyright 2020 IBM Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package application.rest.v1;

import java.lang.management.ManagementFactory;
import java.util.Set;

import javax.management.MBeanServer;
import javax.management.ObjectName;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.eclipse.microprofile.openapi.annotations.Operation;
import org.eclipse.microprofile.openapi.annotations.tags.Tag;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonPrimitive;

@Path("/applications")
@Tag(name = "applications", description="Sample Liberty Application Applications API")
public class ApplicationsEndpoint {
	
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Operation(
            summary = "Retrieve the list of applications and their status from the Liberty server.",
            description = "Returns the list of applications and their status from the Liberty server."
            )
    public Response applications() {
    	final AppResponse response = new AppResponse();
    	try {
    		final MBeanServer mb = ManagementFactory.getPlatformMBeanServer();
    		String objectName = "WebSphere:service=com.ibm.websphere.application.ApplicationMBean,name=*";
    		Set<ObjectName> nameSet = mb.queryNames(new ObjectName(objectName), null);
    		nameSet.forEach(v -> {
    			String name = v.getKeyProperty("name");
    			try {
    				String state = mb.getAttribute(v, "State").toString();
    				String pid = mb.getAttribute(v, "Pid").toString();
    				response.add(name, state, pid);
    			}
    			catch (Exception e) {}
    		});
    	}
    	catch (Exception e) {}
    	return Response.ok(response.getJSON()).build();
    }
    
    static final class AppResponse {
        private final JsonObject o;
        private final JsonArray applications;
        public AppResponse() {
            o = new JsonObject();
            o.add("applications", applications = new JsonArray());
        }
        public void add(final String name, final String state, final String pid) {
            final JsonObject tuple = new JsonObject();
            tuple.add("name", new JsonPrimitive(name));
            tuple.add("state", new JsonPrimitive(state));
            tuple.add("pid", new JsonPrimitive(pid));
            applications.add(tuple);
        }
        public String getJSON() {
            return o.toString();
        }
    }
}
