public class HttpClient {
    public static HttpResponse doPatch(String url, Map<String,String> headers, Object body) {
        HttpClientConfig config = HttpClientConfig.builder().method(HttpClientConstants.HTTP_PATCH).url(url).headers(headers).body(body).build();

        return request(config);
    }

    public static Object doPatch(String url, Type classType, Map<String,String> headers, Object body) {
        HttpClientConfig config = HttpClientConfig.builder().method(HttpClientConstants.HTTP_PATCH).url(url).headers(headers).body(body).build();

        return request(config, classType);
    }

    public static HttpResponse doPut(String url, Map<String,String> headers, Object body) {
        HttpClientConfig config = HttpClientConfig.builder().method(HttpClientConstants.HTTP_PUT).url(url).headers(headers).body(body).build();

        return request(config);
    }

    public static Object doPut(String url, Type classType, Map<String,String> headers, Object body) {
        HttpClientConfig config = HttpClientConfig.builder().method(HttpClientConstants.HTTP_PUT).url(url).headers(headers).body(body).build();

        return request(config, classType);
    }

    public static HttpResponse doPost(String url, Map<String,String> headers, Object body) {
        HttpClientConfig config = HttpClientConfig.builder().method(HttpClientConstants.HTTP_POST).url(url).headers(headers).body(body).build();

        return request(config);
    }

    public static Object doPost(String url, Type classType, Map<String,String> headers, Object body) {
        HttpClientConfig config = HttpClientConfig.builder().method(HttpClientConstants.HTTP_POST).url(url).headers(headers).body(body).build();

        return request(config, classType);
    }

    public static HttpResponse doDelete(String url, Map<String,String> headers, Map<String,String> params) {
        HttpClientConfig config = HttpClientConfig.builder().method(HttpClientConstants.HTTP_DELETE).url(url).headers(headers).params(params).build();

        return request(config);
    }

    public static Object doDelete(String url, Type classType, Map<String,String> headers, Map<String,String> params) {
        HttpClientConfig config = HttpClientConfig.builder().method(HttpClientConstants.HTTP_DELETE).url(url).headers(headers).params(params).build();

        return request(config, classType);
    }

    public static HttpResponse doGet(String url, Map<String,String> headers, Map<String,String> params) {
        HttpClientConfig config = HttpClientConfig.builder().method(HttpClientConstants.HTTP_GET).url(url).headers(headers).params(params).build();

        return request(config);
    }

    public static Object doGet(String url, Type classType, Map<String,String> headers, Map<String,String> params) {
        HttpClientConfig config = HttpClientConfig.builder().method(HttpClientConstants.HTTP_GET).url(url).headers(headers).params(params).build();

        return request(config, classType);
    }

    public static Object request(HttpClientConfig config, Type classType) {
        HttpResponse response = request(config);
        Object retorno = jsonDeserializer(response.getBody(), classType);

        return retorno;
    }

    public static HttpResponse request(HttpClientConfig config) {
        Integer retries = 1;

        validateHttpClientConfig(config);

        HttpRequest request = buildHttpRequest(config);

        Http http = new Http();

        HttpResponse response = new HttpResponse();
        
        while (retries <= config.getRetries()) {
            try{
                System.debug(System.Label.PERFORMING_REQUEST_ATTEMPT + retries);
                response = http.send(request);

                validateHttpResponse(response);
            } catch (Exception e) {
                if(retries == config.getRetries()) {
                    System.debug(System.Label.REQUEST_ATTEMPTS_EXCEEDED);
                    throw new HttpClientException(e.getMessage());
                }
            } finally {
                retries++;
            }
        }
        return response;
    }

    private static HttpRequest buildHttpRequest(HttpClientConfig config) {
        HttpRequest request = new HttpRequest();
        setEndpoint(request, config);
        setHttpHeader(request, config);
        setBody(request, config);
        request.setMethod(config.getMethod().toUpperCase());
        request.setTimeout(config.getTimeout());

        return request;
    }

    @TestVisible
    private static Object jsonDeserializer(String objectToDeserialize, Type classType) {
        Object objectReturn;

        try {
            objectReturn = JSON.deserialize(objectToDeserialize,classType);
        } catch (Exception e) {
            throw new JSONException(System.Label.ERROR_DESERIALIZING_JSON + e.getMessage());
        }

        return objectReturn;
    }

    @TestVisible
    private static void setHttpHeader(HttpRequest request, HttpClientConfig config) {
        for(String key : config.getHeaders().keySet()) {
            request.setHeader(key, config.getHeaders().get(key));
        }
    }
    
    @TestVisible
    private static void setEndpoint(HttpRequest request, HttpClientConfig config) {
        String endpoint = config.getUrl();
        if(config.getParams().isEmpty() != null && !config.getParams().isEmpty()){
            endpoint += '?' + paramsToQueryString(config.getParams());
        }

        request.setEndpoint(endpoint);
    }

    @TestVisible
    private static void setBody(HttpRequest request, HttpClientConfig config) {
        if(HttpClientHelper.objectIsNull(config.getBody())) {
            request.setHeader(HttpClientConstants.HEADER_CONTENT_LENGTH, '0');
            return;
        }

        if(HttpClientHelper.headersHasContentTypeFormUrlEncoded(config.getHeaders())){
            request.setBody(paramsToQueryString((Map<String,String>) config.getBody()));
        } else if( HttpClientHelper.bodyIsBlob(config) ) {
            request.setBodyAsBlob((Blob) config.getBody());
        } else if(config.getSendBodyAsBlob()){
            Blob body = HttpClientHelper.bodyIsString(config) ? Blob.valueOf((String) config.getBody()) : Blob.valueOf(JSON.serialize(config.getBody()));
            request.setBodyAsBlob(body);
        } else if(HttpClientHelper.bodyIsString(config)) {
            request.setBody((String) config.getBody());
        } else {
            request.setBody(JSON.serialize(config.getBody()));
        }
    }

    @TestVisible
    private static void validateHttpResponse(HttpResponse response) {
        if(response.getStatusCode() > 299) {
            throw new HttpClientException(System.Label.ERROR_MAKING_REQUEST, new HttpClientErrorHandlerResponse(response));
        }
    }

    @TestVisible
    private static void validateHttpClientConfig(HttpClientConfig config) {
        validateAllowedHttpMethods(config);
        validateUrlIsBlank(config);
        validateDataObjectForUrlEncoded(config);
    }

    @TestVisible
    private static void validateAllowedHttpMethods(HttpClientConfig config){
        if(!HttpClientHelper.validAllowedHttpMethods(config)) {
            throw new HttpClientException(System.Label.HTTP_METHOD_NOT_ALLOWED + HttpClientConstants.getAllowedHttpMethodsAsString());
        }
    }

    @TestVisible
    private static void validateUrlIsBlank(HttpClientConfig config){
        if(HttpClientHelper.urlIsBlank(config)) {
            throw new HttpClientException(System.Label.URL_MUST_NOT_BE_NULL_OR_EMPTY);
        }
    }

    @TestVisible
    private static void validateDataObjectForUrlEncoded(HttpClientConfig config) {
        if(HttpClientHelper.objectIsNull(config.getBody()) || !HttpClientHelper.headersHasContentTypeFormUrlEncoded(config.getHeaders())) {
            return;
        }

        if(!HttpClientHelper.objectIsMapStringString(config.getBody())){
            throw new HttpClientException(System.Label.URL_ENCODED_CONTENT_TYPE_REQUIREMENT);
        }
    }

    @TestVisible
    private static String paramsToQueryString(Map<String, String> params) {    
        List<String> elements = new List<String>();
        for (String key : params.keySet()) {
            elements.add(EncodingUtil.urlEncode(key, HttpClientConstants.UTF8) + '=' + EncodingUtil.urlEncode(params.get(key), HttpClientConstants.UTF8));
        }
    
        return String.join(elements, '&');
    }
}