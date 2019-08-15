import ballerina/http;
import ballerina/jwt;
import ballerina/auth;

listener http:Listener secureEp = new(9090, {
    auth: {
        authHandlers: [customAuthHandler],
        position: 1
    },
    filters: [customFilter],
    secureSocket: {
        keyStore: {
            path: "${ballerina.home}/bre/security/ballerinaKeystore.p12",
            password: "ballerina"
        } 
    } 
});

auth:InboundBasicAuthProvider inboundBasicAuthProvider = new();
InboundCustomAuthHandler customAuthHandler = new(inboundBasicAuthProvider);