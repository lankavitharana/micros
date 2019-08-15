import ballerina/auth;
import ballerina/internal;
import ballerina/log;

public const AUTHN_FAILED = "{ballerina/http}AuthenticationFailed";
public const string AUTH_SCHEME_BASIC = "X-Token ";

public type InboundCustomAuthHandler object {
    *http:InboundAuthHandler;

    public auth:InboundAuthProvider authProvider;

    public function __init(auth:InboundAuthProvider authProvider) {
        self.authProvider = authProvider;
    }

    public function canProcess(http:Request req) returns @tainted boolean {
        if (req.hasHeader(http:AUTH_HEADER)) {
            string headerValue = http:extractAuthorizationHeaderValue(req);
            return internal:hasPrefix(headerValue, AUTH_SCHEME_BASIC);
        }
        return false;
    }

    public function process(http:Request req) returns boolean|http:AuthenticationError {
        string headerValue = http:extractAuthorizationHeaderValue(req);
        string credential = headerValue.substring(7, headerValue.length());
        credential = credential.trim();
        var authProvider = self.authProvider;
        var authenticationResult = authProvider.authenticate(credential);
        if (authenticationResult is boolean) {
            return authenticationResult;
        } else {
            return prepareAuthenticationError("Failed to authenticate with basic auth hanndler.", authenticationResult);
        }
    }
};


// <Authentication/Authorization> failure for the user <x> at <upsream/downstream> service.
function prepareAuthenticationError(string message, error? err = ()) returns http:AuthenticationError {
    log:printDebug(function () returns string { return message; });
    if (err is error) {
        http:AuthenticationError preparedError = error(AUTHN_FAILED, message = message, cause = err);
        return preparedError;
    }
    http:AuthenticationError preparedError = error(AUTHN_FAILED, message = message);
    return preparedError;
}

