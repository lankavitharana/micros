# Simple passthrouservice which invokes a microservice backend

Back end microservice is secured with jwt and basic auth both, passthrough service is secured only with Basic auth, 
and the passthrough service has two resources which invokes the back end service, (one use basic auth to invoke the back end 
and the other use jwt to invoke the back end.
