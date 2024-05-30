global class HttpClientException extends Exception {
    private HttpClientErrorHandlerResponse httpErrorResponse = new HttpClientErrorHandlerResponse();
    
    global HttpClientException(String message, HttpClientErrorHandlerResponse httpErrorResponse) {
      this(message);
      this.httpErrorResponse = httpErrorResponse;
    }

    global HttpClientErrorHandlerResponse getHttpErrorResponse() {
      return this.httpErrorResponse;
    }
}