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

import java.io.File;
import java.io.FileReader;

import javax.ws.rs.DefaultValue;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.eclipse.microprofile.openapi.annotations.Operation;
import org.eclipse.microprofile.openapi.annotations.parameters.Parameter;
import org.eclipse.microprofile.openapi.annotations.tags.Tag;

@Path("/logging")
@Tag(name = "logs", description="Sample Liberty Application Logging API")
public class LoggingEndpoint {
	
    @GET
    @Produces(MediaType.TEXT_PLAIN)
    @Operation(
            summary = "Retrieve the log file for the Sample Liberty Application.",
            description = "Returns the log file for the Sample Liberty Application."
            )
    public Response logs(@DefaultValue("console") @QueryParam("name") @Parameter(description = "The namespace of the application") String name) {
    	String outputDir = System.getProperty("server.output.dir");
    	File file = new File(new File(outputDir), "logs" + File.separatorChar + name + ".log");
    	System.out.println("Retrieving " + file.toString() + ".");
    	String log;
    	try {
    		FileReader reader = new FileReader(file);
    		int ch;
    		StringBuilder builder = new StringBuilder();
    		while ((ch = reader.read()) != -1) {
    			builder.append((char) ch);
    		}
    		reader.close();
    		log = builder.toString();
    	}
    	catch (Exception e) {
    		log = file.toString() + " :: " + e;
    	}
    	return Response.ok(log).build();
    }
}
