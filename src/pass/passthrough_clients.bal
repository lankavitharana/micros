string url = "https://localhost:9091/back";

jwt:OutboundJwtAuthProvider jwtAuthProvider = new({
    issuer: "ballerina",
    audience: ["ballerina.io"],
    keyStoreConfig: {
        keyAlias: "ballerina",
        keyPassword: "ballerina",
        keyStore: {
            path: "${ballerina.home}/bre/security/ballerinaKeystore.p12",
            password: "ballerina"
        }
    }
});

http:BearerAuthHandler jwtAuthHandler = new(jwtAuthProvider);

http:Client downstreamJwtEp = new(url, {
    auth: {
        authHandler: jwtAuthHandler
    },
    secureSocket: {
        trustStore: {
            path: "${ballerina.home}/bre/security/ballerinaTruststore.p12",
            password: "ballerina"
        }
    }
});



auth:OutboundBasicAuthProvider basicAuthProvider = new();

http:BasicAuthHandler basicAuthHandler = new(basicAuthProvider);


http:Client downstreamBasicEp = new(url, {
    auth: {
        authHandler: basicAuthHandler
    },
    secureSocket: {
        trustStore: {
            path: "${ballerina.home}/bre/security/ballerinaTruststore.p12",
            password: "ballerina"
        }
    }
});




