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
}