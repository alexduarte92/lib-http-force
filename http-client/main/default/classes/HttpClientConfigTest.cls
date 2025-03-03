@isTest
public class HttpClientConfigTest {
  @isTest
  static void testHttpClientConfigBuilder() {
    String url = 'https://jsonplaceholder.typicode.com/posts';
    String method = 'POST';
    Map<String, String> headers = new Map<String, String>{
      'Content-Type' => 'application/json'
    };
    Map<String, String> params = new Map<String, String>{
      'userId' => '1',
      'title' => 'test title',
      'body' => 'test body'
    };
    String body = '{"userId": 1, "title": "test title", "body": "test body"}';
    Boolean sendBodyAsBlob = false;
    Integer timeout = 5000;

    HttpClientConfig config = HttpClientConfig.builder()
      .url(url)
      .method(method)
      .headers(headers)
      .addHeader('Authorization', 'Basic oipajsidasidad==')
      .params(params)
      .addParam('teste', 'teste1')
      .body(body)
      .sendBodyAsBlob(sendBodyAsBlob)
      .timeout(timeout)
      .build();

    Assert.areEqual(url, config.getUrl(), 'URL does not match.');
    Assert.areEqual(method, config.getMethod(), 'Method does not match.');
    Assert.areEqual(body, config.getBody(), 'Body does not match.');
    Assert.areEqual(sendBodyAsBlob, config.getSendBodyAsBlob(), 'Send body as blob does not match.');
    Assert.areEqual(timeout, config.getTimeout(), 'Timeout does not match.');
  }

  @isTest
  static void testHttpClientConfigBuilderFromAnotherConfig() {
    String url = 'https://jsonplaceholder.typicode.com/posts';
    String method = 'POST';
    Map<String, String> headers = new Map<String, String>{
      'Content-Type' => 'application/json'
    };
    Map<String, String> params = new Map<String, String>{
      'userId' => '1',
      'title' => 'test title',
      'body' => 'test body'
    };
    String body = '{"userId": 1, "title": "test title", "body": "test body"}';
    Boolean sendBodyAsBlob = false;
    Integer timeout = 5000;

    HttpClientConfig config = HttpClientConfig.builder()
      .url(url)
      .method(method)
      .headers(headers)
      .addHeader('Authorization', 'Basic oipajsidasidad==')
      .params(params)
      .addParam('teste', 'teste1')
      .body(body)
      .sendBodyAsBlob(sendBodyAsBlob)
      .timeout(timeout)
      .build();

    final HttpClientConfig configNew = HttpClientConfig.builder(config).build();

    Assert.areEqual(configNew.getUrl(), config.getUrl(),'URL does not match.');
    Assert.areEqual(configNew.getMethod(), config.getMethod(),'Method does not match.');
    Assert.areEqual(configNew.getBody(), config.getBody(),'Body does not match.');
    Assert.areEqual(configNew.getSendBodyAsBlob(), config.getSendBodyAsBlob(),'Send body as blob does not match.');
    Assert.areEqual(configNew.getTimeout(), config.getTimeout(),'Timeout does not match.');
  }

  @isTest
  static void testHttpClientConfigBuilderWithNamedCredential() {
    String method = 'POST';
    Map<String, String> headers = new Map<String, String>{
      'Content-Type' => 'application/json'
    };
    Map<String, String> params = new Map<String, String>{
      'userId' => '1',
      'title' => 'test title',
      'body' => 'test body'
    };
    String body = '{"userId": 1, "title": "test title", "body": "test body"}';
    Boolean sendBodyAsBlob = false;
    Integer timeout = 5000;

    HttpClientConfig config = HttpClientConfig.builder()
      .namedCredential('CREDENTIALTESTE', '/path')
      .method(method)
      .headers(headers)
      .addHeader('Authorization', 'Basic oipajsidasidad==')
      .params(params)
      .addParam('teste', 'teste1')
      .body(body)
      .sendBodyAsBlob(sendBodyAsBlob)
      .timeout(timeout)
      .build();

    Assert.areEqual('callout:CREDENTIALTESTE/path', config.getUrl(),'URL does not match.');
    Assert.areEqual(
      'CREDENTIALTESTE',
      config.getNamedCredentialDeveloperName(),
      'Named Credential Developer Name does not match.'
    );
    Assert.areEqual('/path', config.getNamedCredentialPath(),'Named Credential Path does not match.');
    Assert.areEqual(method, config.getMethod(),'Method does not match.');
    Assert.areEqual(body, config.getBody(),'Body does not match.');
    Assert.areEqual(sendBodyAsBlob, config.getSendBodyAsBlob(),'Send body as blob does not match.');
    Assert.areEqual(timeout, config.getTimeout(),'Timeout does not match.');
  }

  @isTest
  static void testRequestWithHttpClientConfigValid() {
    String url = 'https://jsonplaceholder.typicode.com/posts';
    String method = 'POST';
    Map<String, String> headers = new Map<String, String>{
      'Content-Type' => 'application/json'
    };
    Map<String, String> params = new Map<String, String>{
      'userId' => '1',
      'title' => 'test title',
      'body' => 'test body'
    };
    Map<String, String> body = new Map<String, String>{ 'Test' => 'Test' };
    Boolean sendBodyAsBlob = false;
    Integer timeout = 5000;

    HttpClientTest.HttpClientMock mock = new HttpClientTest.HttpClientMock(
      200,
      'OK',
      JSON.serialize(body),
      null
    );

    Test.setMock(HttpCalloutMock.class, mock);
    Test.startTest();
    HttpClientConfig config = HttpClientConfig.builder()
      .url(url)
      .method(method)
      .headers(headers)
      .params(params)
      .body(JSON.serialize(body))
      .sendBodyAsBlob(sendBodyAsBlob)
      .timeout(timeout)
      .build();

    HttpResponse httpResponse = config.request();
    Map<String, String> httpMapResponse = (Map<String, String>) config.request(Map<String, String>.class);
    Test.stopTest();

    Assert.isNotNull(httpResponse,'Response is null.');
    Assert.areEqual(config.getBody(), httpResponse.getBody(), 'Body does not match.');
    Assert.isNotNull(httpMapResponse, 'Response is null');
    Assert.areEqual(httpMapResponse, body, 'Body does not match.');
  }
}
