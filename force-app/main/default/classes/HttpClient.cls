global class HttpClient {

    global static Object doPatch(String url, Type classType, Map<String,String> headers, Object body) {
        HttpClientConfig config = HttpClientConfig.builder().setMethod('PATCH').setUrl(url).setHeaders(headers).setBody(body).build();

        return request(config, classType);
    }

    global static Object doPut(String url, Type classType, Map<String,String> headers, Object body) {
        HttpClientConfig config = HttpClientConfig.builder().setMethod('PUT').setUrl(url).setHeaders(headers).setBody(body).build();

        return request(config, classType);
    }

    global static Object doPost(String url, Type classType, Map<String,String> headers, Object body) {
        HttpClientConfig config = HttpClientConfig.builder().setMethod('POST').setUrl(url).setHeaders(headers).setBody(body).build();

        return request(config, classType);
    }

    global static Object doDelete(String url, Type classType, Map<String,String> headers, Map<String,String> params) {
        HttpClientConfig config = HttpClientConfig.builder().setMethod('DELETE').setUrl(url).setHeaders(headers).setParams(params).build();

        return request(config, classType);
    }

    global static Object doGet(String url, Type classType, Map<String,String> headers, Map<String,String> params) {
        HttpClientConfig config = HttpClientConfig.builder().setMethod('GET').setUrl(url).setHeaders(headers).setParams(params).build();

        return request(config, classType);
    }

    global static Object request(HttpClientConfig config, Type classType) {
        HttpResponse response = request(config);
        Object retorno = jsonDeserializer(response.getBody(), classType);

        return retorno;
    }

    global static HttpResponse request(HttpClientConfig config) {
        validateHttpClientConfig(config);

        HttpRequest request = new HttpRequest();
        setEndpoint(request, config);
        setHttpHeader(request, config);
        setBody(request, config);
        request.setMethod(config.getMethod().toUpperCase());
        request.setTimeout(config.getTimeout());

        Http http = new Http();

        HttpResponse response = http.send(request);

        validateHttpResponse(response);
        
        return response;
    }

    @TestVisible
    private static Object jsonDeserializer(String objectToDeserialize, Type classType) {
        Object objectReturn;

        try {
            objectReturn = JSON.deserialize(objectToDeserialize,classType);
        } catch (Exception e) {
            throw new JSONException('Erro ao realizar deserialize do JSON. Erro: ' + e.getMessage());
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
            request.setHeader('Content-Length', '0');
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
            throw new HttpClientException('Erro ao realizar a chamada', new HttpClientErrorHandlerResponse(response));
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
            throw new HttpClientException('Método não permitido, permitidos: ' + httpClientHelper.getAllowedHttpMethods());
        }
    }

    @TestVisible
    private static void validateUrlIsBlank(HttpClientConfig config){
        if(HttpClientHelper.urlIsBlank(config)) {
            throw new HttpClientException('URL não deve ser nula ou vazia!');
        }
    }

    @TestVisible
    private static void validateDataObjectForUrlEncoded(HttpClientConfig config) {
        if(HttpClientHelper.objectIsNull(config.getBody()) || !HttpClientHelper.headersHasContentTypeFormUrlEncoded(config.getHeaders())) {
            return;
        }

        if(!HttpClientHelper.objectIsMapStringString(config.getBody())){
            throw new HttpClientException('Para requisição x-www-form-urlencoded o body deve ser do tipo Map<String,String>!');
        }
    }

    @TestVisible
    private static String paramsToQueryString(Map<String, String> params) {    
        List<String> elements = new List<String>();
        for (String key : params.keySet()) {
            elements.add(EncodingUtil.urlEncode(key, 'UTF-8') + '=' + EncodingUtil.urlEncode(params.get(key), 'UTF-8'));
        }
    
        return String.join(elements, '&');
    }
}
