import ballerina/runtime;

string errorMsg = "%s failure for the user %s at %s service";

public type CustomFilter object {

    public function filterResponse(http:Response response, http:FilterContext context) returns boolean {
        if (response.statusCode == 403) { // this means back end authorization failure
            string userName = "unknown";
            runtime:Principal? testPrincipal = runtime:getInvocationContext()?.principal;
            if (testPrincipal is runtime:Principal) {
                userName = <string> testPrincipal?.userId;
            }           
            response.setTextPayload(io:sprintf(errorMsg, "Authorization", userName, "downstream"));
        } else {
            response.setTextPayload("Authentication failure for the user at upsream service.");
        }
        return true;
    }
};

CustomFilter customFilter = new();



