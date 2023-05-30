global class HttpClientConstants {
    public static final List<String> ALLOWED_HTTP_METHODS = new List<String>{'GET', 'POST', 'PUT', 'PATCH', 'DELETE'};
    public static final String HEADER_CONTENT_TYPE = 'Content-Type';
    public static final String HEADER_URL_ENCODED = 'application/x-www-form-urlencoded';
    
    global static String getAllowedHttpMethodsAsString() {
        return String.join(ALLOWED_HTTP_METHODS, ', ');
    }
}