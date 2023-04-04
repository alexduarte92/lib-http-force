global class HttpClientErrorHandlerResponse {
    private String responseBody;
    private Integer statusCode;
    private String status;
    
    global HttpClientErrorHandlerResponse(String responseBody, Integer statusCode, String status) {
        this.responseBody = responseBody;
        this.statusCode = statusCode;
        this.status = status;
    }
    
    public String getResponseBody() {
        return this.responseBody;
    }
    
    public Integer getStatusCode() {
        return this.statusCode;
    }
    
    public String getStatus() {
        return this.status;
    }
}