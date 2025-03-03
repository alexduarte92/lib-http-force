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

    Assert.areEqual(url, config.getUrl());
    Assert.areEqual(method, config.getMethod());
    Assert.areEqual(body, config.getBody());
    Assert.areEqual(sendBodyAsBlob, config.getSendBodyAsBlob());
    Assert.areEqual(timeout, config.getTimeout());
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

    HttpClientConfig config_new = HttpClientConfig.builder(config).build();

    Assert.areEqual(config_new.getUrl(), config.getUrl());
    Assert.areEqual(config_new.getMethod(), config.getMethod());
    Assert.areEqual(config_new.getBody(), config.getBody());
    Assert.areEqual(config_new.getSendBodyAsBlob(), config.getSendBodyAsBlob());
    Assert.areEqual(config_new.getTimeout(), config.getTimeout());
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

    Assert.areEqual('callout:CREDENTIALTESTE/path', config.getUrl());
    Assert.areEqual(
      'CREDENTIALTESTE',
      config.getNamedCredentialDeveloperName()
    );
    Assert.areEqual('/path', config.getNamedCredentialPath());
    Assert.areEqual(method, config.getMethod());
    Assert.areEqual(body, config.getBody());
    Assert.areEqual(sendBodyAsBlob, config.getSendBodyAsBlob());
    Assert.areEqual(timeout, config.getTimeout());
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

    config.request();
    config.request(Map<String, String>.class);
    Test.stopTest();
  }
}
