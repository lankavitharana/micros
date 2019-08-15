import ballerina/http;
import ballerina/jwt;
import ballerina/auth;


listener http:Listener secureEp = new(9091, {
    auth: {
        authHandlers: [jwtAuthHandler, basicAuthHandler] ,
        scopes: ["write", "update"] 
    },
    secureSocket: {
        keyStore: {
            path: "${ballerina.home}/bre/security/ballerinaKeystore.p12",
            password: "ballerina"
        } 
    } 
});

jwt:InboundJwtAuthProvider jwtAuthProvider = new({
    issuer: "ballerina",
    audience: ["ballerina.io"],
    clockSkewInSeconds: 0,
    trustStoreConfig: {
        trustStore: {
            path: "${ballerina.home}/bre/security/ballerinaTruststore.p12",
            password: "ballerina"
        },
        certificateAlias: "ballerina"
    }
});

http:BearerAuthHandler jwtAuthHandler = new(jwtAuthProvider);

auth:InboundBasicAuthProvider basicAuthProvider = new();
http:BasicAuthHandler basicAuthHandler = new(basicAuthProvider);