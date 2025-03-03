@isTest
public class HttpClientHelperTest {
  @isTest
  static void testHeadersHasContentTypeFormUrlEncoded() {
    Map<String, String> headers = new Map<String, String>{
      HttpClientConstants.HEADER_CONTENT_TYPE => HttpClientConstants.HEADER_URL_ENCODED
    };
    Assert.areEqual(
      true,
      HttpClientHelper.headersHasContentTypeFormUrlEncoded(headers)
    );
  }

  @isTest
  static void testValidAllowedHttpMethods() {
    HttpClientConfig config = HttpClientConfig.builder()
      .url('https://www.example.com')
      .method('POST')
      .build();
    Assert.areEqual(true, HttpClientHelper.validAllowedHttpMethods(config));
  }

  @isTest
  static void testUrlIsBlank() {
    HttpClientConfig config = HttpClientConfig.builder().url('').build();
    Assert.areEqual(true, HttpClientHelper.urlIsBlank(config));
  }

  @isTest
  static void testBodyIsBlob() {
    HttpClientConfig config = HttpClientConfig.builder()
      .body(Blob.valueOf('test'))
      .build();
    Assert.areEqual(true, HttpClientHelper.bodyIsBlob(config));
  }

  @isTest
  static void testBodyIsString() {
    HttpClientConfig config = HttpClientConfig.builder().body('test').build();
    Assert.areEqual(true, HttpClientHelper.bodyIsString(config));
  }

  @isTest
  static void testBodyIsMapStringString() {
    Map<String, String> body = new Map<String, String>{
      'key1' => 'value1',
      'key2' => 'value2'
    };
    Assert.areEqual(true, HttpClientHelper.objectIsMapStringString(body));
  }

  @isTest
  static void testBodyIsNull() {
    Object body = null;
    Assert.areEqual(true, HttpClientHelper.objectIsNull(body));
  }

  @isTest
  static void testGetAllowedHttpMethods() {
    String allowedMethods = HttpClientConstants.getAllowedHttpMethodsAsString();
    Assert.areEqual('GET, POST, PUT, PATCH, DELETE', allowedMethods);
  }

  @isTest
  static void testBodyIsBlobNot() {
    HttpClientConfig config = HttpClientConfig.builder().body('test').build();
    Assert.areEqual(false, HttpClientHelper.bodyIsBlob(config));
  }
}
