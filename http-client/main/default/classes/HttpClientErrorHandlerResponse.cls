global class HttpClientErrorHandlerResponse {
    private String responseBody;
    private Integer statusCode;
    private String status;
    private HttpResponse response;

    global HttpClientErrorHandlerResponse() {
        this.responseBody = '';
        this.statusCode = 0;
        this.status = '';
        this.response = null;
    }

    global HttpClientErrorHandlerResponse(HttpResponse response) {
        this.responseBody = response.getBody();
        this.statusCode = response.getStatusCode();
        this.status = response.getStatus();
        this.response = response;
    }
    
    global String getResponseBody() {
        return this.responseBody;
    }
    
    global Integer getStatusCode() {
        return this.statusCode;
    }
    
    global String getStatus() {
        return this.status;
    }

    global HttpResponse getResponse() {
        return this.response;
    }
}