@isTest
public class HttpClientConfigTest {
    
    @isTest
    static void testHttpClientConfigBuilder() {
        String url = 'https://jsonplaceholder.typicode.com/posts';
        String method = 'POST';
        Map<String, String> headers = new Map<String, String>{'Content-Type' => 'application/json'};
        Map<String, String> params = new Map<String, String>{'userId' => '1', 'title' => 'test title', 'body' => 'test body'};
        String body = '{"userId": 1, "title": "test title", "body": "test body"}';
        Boolean sendBodyAsBlob = false;
        Integer timeout = 5000;
        
        HttpClientConfig config = HttpClientConfig.builder()
            .setUrl(url)
            .setMethod(method)
            .setHeaders(headers)
            .addHeader('Authorization', 'Basic oipajsidasidad==')
            .setParams(params)
            .addParam('teste', 'teste1')
            .setBody(body)
            .setSendBodyAsBlob(sendBodyAsBlob)
            .setTimeout(timeout)
            .build();
        
        System.assertEquals(url, config.getUrl());
        System.assertEquals(method, config.getMethod());
        System.assertEquals(body, config.getBody());
        System.assertEquals(sendBodyAsBlob, config.getSendBodyAsBlob());
        System.assertEquals(timeout, config.getTimeout());
    }

    @isTest
    static void testHttpClientConfigBuilderFromAnotherConfig() {
        String url = 'https://jsonplaceholder.typicode.com/posts';
        String method = 'POST';
        Map<String, String> headers = new Map<String, String>{'Content-Type' => 'application/json'};
        Map<String, String> params = new Map<String, String>{'userId' => '1', 'title' => 'test title', 'body' => 'test body'};
        String body = '{"userId": 1, "title": "test title", "body": "test body"}';
        Boolean sendBodyAsBlob = false;
        Integer timeout = 5000;
        
        HttpClientConfig config = HttpClientConfig.builder()
            .setUrl(url)
            .setMethod(method)
            .setHeaders(headers)
            .addHeader('Authorization', 'Basic oipajsidasidad==')
            .setParams(params)
            .addParam('teste', 'teste1')
            .setBody(body)
            .setSendBodyAsBlob(sendBodyAsBlob)
            .setTimeout(timeout)
            .build();
        
        HttpClientConfig config_new = HttpClientConfig.builder(config).build();

        System.assertEquals(config_new.getUrl(), config.getUrl());
        System.assertEquals(config_new.getMethod(), config.getMethod());
        System.assertEquals(config_new.getBody(), config.getBody());
        System.assertEquals(config_new.getSendBodyAsBlob(), config.getSendBodyAsBlob());
        System.assertEquals(config_new.getTimeout(), config.getTimeout());
    }

    @isTest
    static void testHttpClientConfigBuilderWithNamedCredential() {
        String method = 'POST';
        Map<String, String> headers = new Map<String, String>{'Content-Type' => 'application/json'};
        Map<String, String> params = new Map<String, String>{'userId' => '1', 'title' => 'test title', 'body' => 'test body'};
        String body = '{"userId": 1, "title": "test title", "body": "test body"}';
        Boolean sendBodyAsBlob = false;
        Integer timeout = 5000;

        HttpClientConfig config = HttpClientConfig.builder()
            .setUrl('CREDENTIALTESTE', '/path')
            .setMethod(method)
            .setHeaders(headers)
            .addHeader('Authorization', 'Basic oipajsidasidad==')
            .setParams(params)
            .addParam('teste', 'teste1')
            .setBody(body)
            .setSendBodyAsBlob(sendBodyAsBlob)
            .setTimeout(timeout)
            .build();
        
        System.assertEquals('callout:CREDENTIALTESTE/path', config.getUrl());
        System.assertEquals('CREDENTIALTESTE', config.getNamedCredentialDeveloperName());
        System.assertEquals('/path', config.getNamedCredentialPath());
        System.assertEquals(method, config.getMethod());
        System.assertEquals(body, config.getBody());
        System.assertEquals(sendBodyAsBlob, config.getSendBodyAsBlob());
        System.assertEquals(timeout, config.getTimeout());
    }

    @isTest
    static void testRequestWithHttpClientConfigValid() {
        String url = 'https://jsonplaceholder.typicode.com/posts';
        String method = 'POST';
        Map<String, String> headers = new Map<String, String>{'Content-Type' => 'application/json'};
        Map<String, String> params = new Map<String, String>{'userId' => '1', 'title' => 'test title', 'body' => 'test body'};
        Map<String,String> body = new Map<String,String>{'Test' => 'Test'};
        Boolean sendBodyAsBlob = false;
        Integer timeout = 5000;

        HttpClientTest.HttpClientMock mock = new HttpClientTest.HttpClientMock(200, 'OK', JSON.serialize(body), null);

        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        HttpClientConfig config = HttpClientConfig.builder()
            .setUrl(url)
            .setMethod(method)
            .setHeaders(headers)
            .setParams(params)
            .setBody(JSON.serialize(body))
            .setSendBodyAsBlob(sendBodyAsBlob)
            .setTimeout(timeout)
            .build();
        
        config.request();
        config.request(Map<String,String>.class);
        Test.stopTest();
    }
}