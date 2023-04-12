public class HttpClientErrorHandlerResponse {
    private String responseBody;
    private Integer statusCode;
    private String status;
    private HttpResponse response;

    public HttpClientErrorHandlerResponse(HttpResponse response) {
        this.responseBody = response.getBody();
        this.statusCode = response.getStatusCode();
        this.status = response.getStatus();
        this.response = response;
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

    public HttpResponse getResponse() {
        return this.response;
    }
}