public class HttpClientException extends Exception {
    private HttpClientErrorHandlerResponse httpErrorResponse;

    public HttpClientException(String message, HttpClientErrorHandlerResponse httpErrorResponse) {
      this(message);
      this.httpErrorResponse = httpErrorResponse;
    }

    public HttpClientErrorHandlerResponse getHttpErrorResponse() {
      return this.httpErrorResponse;
    }
}