global class HttpClientHelper {
    @TestVisible
    private static final List<String> ALLOWED_HTTP_METHODS = new List<String>{'GET', 'POST', 'PUT', 'PATCH', 'DELETE'};
    @TestVisible
    private static final String HEADER_CONTENT_TYPE = 'Content-Type';
    @TestVisible
    private static final String HEADER_URL_ENCODED = 'application/x-www-form-urlencoded';

    global static Boolean headersHasContentTypeFormUrlEncoded(Map<String,String> headers) {
        Boolean isUrlEncoded = false;
        for (String key : headers.keySet()) {
            if (key.equalsIgnoreCase(HEADER_CONTENT_TYPE)) {
                if(headers.get(key).equalsIgnoreCase(HEADER_URL_ENCODED))
                isUrlEncoded = true;
                break;
            }
        }

        return isUrlEncoded;
    }

    global static Boolean validAllowedHttpMethods(HttpClientConfig httpClientConfig) {
        return ALLOWED_HTTP_METHODS.contains(httpClientConfig.getMethod().toUpperCase());
    }

    global static Boolean urlIsBlank(HttpClientConfig httpClientConfig) {
        return String.isBlank(httpClientConfig.getUrl());
    }

    global static Boolean bodyIsBlob(HttpClientConfig httpClientConfig) {
        return httpClientConfig.getBody() instanceof Blob;
    }

    global static Boolean bodyIsString(HttpClientConfig httpClientConfig) {
        return httpClientConfig.getBody() instanceof String;
    }

    global static Boolean objectIsMapStringString(Object body) {
        return body instanceof Map<String,String>;
    }

    global static Boolean objectIsNull(Object body) {
        return body == null;
    }

    global static String getAllowedHttpMethods() {
        return String.join(ALLOWED_HTTP_METHODS, ', ');
    }
}