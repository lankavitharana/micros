import ballerina/http;

@http:ServiceConfig {
    basePath: "/pass"
}
service passthrough on secureEp {
    @http:ResourceConfig {
        methods: ["GET"],
        path: "/jwt"
    }
    resource function jwt(http:Caller caller, http:Request request) {
        var resp = checkpanic downstreamJwtEp->get("/getPrice");
        checkpanic caller->respond(resp);
    }

    @http:ResourceConfig {
        methods: ["GET"],
        path: "/basic"
    }
    resource function basic(http:Caller caller, http:Request request) {
        var resp = checkpanic downstreamBasicEp->get("/getPrice");
        checkpanic caller->respond(resp);
    }
}



