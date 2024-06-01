public class HttpClientHelper {
    public static Boolean headersHasContentTypeFormUrlEncoded(Map<String,String> headers) {
        Boolean isUrlEncoded = false;
        for (String key : headers.keySet()) {
            if (key.equalsIgnoreCase(HttpClientConstants.HEADER_CONTENT_TYPE)) {
                if(headers.get(key).equalsIgnoreCase(HttpClientConstants.HEADER_URL_ENCODED)){
                    isUrlEncoded = true;
                    break;
                }
            }
        }

        return isUrlEncoded;
    }

    public static Boolean validAllowedHttpMethods(HttpClientConfig httpClientConfig) {
        return HttpClientConstants.ALLOWED_HTTP_METHODS.contains(httpClientConfig.getMethod().toUpperCase());
    }

    public static Boolean urlIsBlank(HttpClientConfig httpClientConfig) {
        return String.isBlank(httpClientConfig.getUrl());
    }

    public static Boolean bodyIsBlob(HttpClientConfig httpClientConfig) {
        return httpClientConfig.getBody() instanceof Blob;
    }

    public static Boolean bodyIsString(HttpClientConfig httpClientConfig) {
        return httpClientConfig.getBody() instanceof String;
    }

    public static Boolean objectIsMapStringString(Object body) {
        return body instanceof Map<String,String>;
    }

    public static Boolean objectIsNull(Object body) {
        return body == null;
    }
}