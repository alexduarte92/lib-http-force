global class HttpClientConstants {
    public static final String HEADER_CONTENT_TYPE = 'Content-Type';
    public static final String HEADER_CONTENT_LENGTH = 'Content-Length';
    public static final String HEADER_URL_ENCODED = 'application/x-www-form-urlencoded';
    public static final String UTF8 = 'UTF-8';
    public static final String HTTP_GET = 'GET';
    public static final String HTTP_POST = 'POST';
    public static final String HTTP_PUT = 'PUT';
    public static final String HTTP_PATCH = 'PATCH';
    public static final String HTTP_DELETE = 'DELETE';
    public static final List<String> ALLOWED_HTTP_METHODS = new List<String>{HTTP_GET, HTTP_POST, HTTP_PUT, HTTP_PATCH, HTTP_DELETE};
    
    global static String getAllowedHttpMethodsAsString() {
        return String.join(ALLOWED_HTTP_METHODS, ', ');
    }
}