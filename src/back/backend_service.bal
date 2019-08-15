

@http:ServiceConfig {
    basePath: "/back"
}
service backEndService on secureEp {
    @http:ResourceConfig {
        methods: ["GET"],
        path: "/getPrice"
    }
    resource function getPrice(http:Caller caller, http:Request request) {
        http:Response resp = new();
        resp.setTextPayload("Price - Rs 99.98");
        checkpanic caller->respond(resp);
    }
}
