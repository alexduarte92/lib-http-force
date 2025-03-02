@isTest
public class HttpClientTest {
    @isTest
    static void testRequestWithHttpClientConfigValid() {
        String url = 'https://jsonplaceholder.typicode.com/posts';
        String method = 'POST';
        Map<String, String> headers = new Map<String, String>{'Content-Type' => 'application/json'};
        Map<String, String> params = new Map<String, String>{'userId' => '1', 'title' => 'test title', 'body' => 'test body'};
        String body = '{"userId": 1, "title": "test title", "body": "test body"}';
        Boolean sendBodyAsBlob = false;
        Integer timeout = 5000;
        
        HttpClientMock mock = new HttpClientMock(200, 'OK', body, null);

        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        HttpClientConfig config = HttpClientConfig.builder()
            .url(url)
            .method(method)
            .headers(headers)
            .addHeader('SF-Header', 'true')
            .params(params)
            .addParam('paramTest', 'paramTest')
            .body(body)
            .sendBodyAsBlob(sendBodyAsBlob)
            .timeout(timeout)
            .retries(2)
            .build();
        
        HttpClient.request(config);
        Test.stopTest();
    }

    @isTest
    static void testRequestWithHttpClientConfigParamNull() {
        String url = 'https://jsonplaceholder.typicode.com/posts';
        String method = 'GET';
        Map<String, String> headers = new Map<String, String>{'Content-Type' => 'application/json'};
        String body = '{"userId": 1, "title": "test title", "body": "test body"}';
        Boolean sendBodyAsBlob = false;
        Integer timeout = 5000;
        
        HttpClientMock mock = new HttpClientMock(200, 'OK', body, null);

        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        HttpClientConfig config = HttpClientConfig.builder()
            .url(url)
            .method(method)
            .headers(headers)
            .sendBodyAsBlob(sendBodyAsBlob)
            .timeout(timeout)
            .build();
        
        HttpClient.request(config);
        Test.stopTest();
    }

    @isTest
    static void testRequestWithHttpClientConfigWithMethodInvalid() {
        String url = 'https://jsonplaceholder.typicode.com/posts';
        String method = 'GET2';
        Map<String, String> headers = new Map<String, String>{'Content-Type' => 'application/json'};
        Map<String, String> params = new Map<String, String>{'userId' => '1', 'title' => 'test title', 'body' => 'test body'};
        String body = '{"userId": 1, "title": "test title", "body": "test body"}';
        Boolean sendBodyAsBlob = false;
        Integer timeout = 5000;
        
        HttpClientMock mock = new HttpClientMock(200, 'OK', body, null);

        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        HttpClientConfig config = HttpClientConfig.builder()
            .url(url)
            .method(method)
            .headers(headers)
            .params(params)
            .body(body)
            .sendBodyAsBlob(sendBodyAsBlob)
            .timeout(timeout)
            .build();
        
        try {
            HttpClient.request(config);
            Assert.fail();
        } catch (HttpClientException e) {
            System.debug(e.getMessage());
            System.debug(e.getHttpErrorResponse().getResponse());
        }
        Test.stopTest();
    }

    @isTest
    static void testRequestWithHttpClientConfigWithUrlNull() {
        String url = 'https://jsonplaceholder.typicode.com/posts';
        String method = 'POST';
        Map<String, String> headers = new Map<String, String>{'Content-Type' => 'application/json'};
        Map<String, String> params = new Map<String, String>{'userId' => '1', 'title' => 'test title', 'body' => 'test body'};
        String body = '{"userId": 1, "title": "test title", "body": "test body"}';
        Boolean sendBodyAsBlob = false;
        Integer timeout = 5000;
        
        HttpClientMock mock = new HttpClientMock(200, 'OK', body, null);

        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        HttpClientConfig config = HttpClientConfig.builder()
            .url(null)
            .method(method)
            .headers(headers)
            .params(params)
            .body(body)
            .sendBodyAsBlob(sendBodyAsBlob)
            .timeout(timeout)
            .build();
        try {
            HttpClient.request(config);
            Assert.fail();
        } catch (HttpClientException e) {
            System.debug(e.getMessage());
        }
        Test.stopTest();
    }

    @isTest
    static void testRequestWithHttpClientConfigWithBodyInvalid() {
        String url = 'https://jsonplaceholder.typicode.com/posts';
        String method = 'POST';
        Map<String, String> headers = new Map<String, String>{'Content-Type' => 'application/x-www-form-urlencoded'};
        Map<String, String> params = new Map<String, String>{'userId' => '1', 'title' => 'test title', 'body' => 'test body'};
        String body = '{"userId": 1, "title": "test title", "body": "test body"}';
        Boolean sendBodyAsBlob = false;
        Integer timeout = 5000;
        
        HttpClientMock mock = new HttpClientMock(200, 'OK', body, null);

        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        HttpClientConfig config = HttpClientConfig.builder()
            .url(url)
            .method(method)
            .headers(headers)
            .params(params)
            .body(body)
            .sendBodyAsBlob(sendBodyAsBlob)
            .timeout(timeout)
            .build();
        
        try {
            HttpClient.request(config);
            Assert.fail();
        } catch (HttpClientException e) {
            System.debug(e.getMessage());
        }
        Test.stopTest();
    }

    @isTest
    static void testRequestWithHttpClientConfigWithUrlEncodedBodyValid() {
        String url = 'https://jsonplaceholder.typicode.com/posts';
        String method = 'POST';
        Map<String, String> headers = new Map<String, String>{'Content-Type' => 'application/x-www-form-urlencoded'};
        Map<String, String> params = new Map<String, String>{'userId' => '1', 'title' => 'test title', 'body' => 'test body'};
        Map<String,String> body = new Map<String,String>{'Test' => 'Test'};
        Boolean sendBodyAsBlob = false;
        Integer timeout = 5000;
        
        HttpClientMock mock = new HttpClientMock(200, 'OK', JSON.serialize(body), null);

        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        HttpClientConfig config = HttpClientConfig.builder()
            .url(url)
            .method(method)
            .headers(headers)
            .params(params)
            .body(body)
            .sendBodyAsBlob(sendBodyAsBlob)
            .timeout(timeout)
            .build();
        
        try {
            HttpClient.request(config);
        } catch (HttpClientException e) {
            System.debug(e.getMessage());
        }
        Test.stopTest();
    }

    @isTest
    static void testRequestWithHttpClientConfigBodyAsBlobValid() {
        String url = 'https://jsonplaceholder.typicode.com/posts';
        String method = 'POST';
        Map<String, String> headers = new Map<String, String>{'Content-Type' => 'application/json'};
        Map<String, String> params = new Map<String, String>{'userId' => '1', 'title' => 'test title', 'body' => 'test body'};
        String body = '{"userId": 1, "title": "test title", "body": "test body"}';
        Boolean sendBodyAsBlob = false;
        Integer timeout = 5000;
        
        HttpClientMock mock = new HttpClientMock(200, 'OK', body, null);

        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        HttpClientConfig config = HttpClientConfig.builder()
            .url(url)
            .method(method)
            .headers(headers)
            .params(params)
            .body(Blob.valueOf(body))
            .sendBodyAsBlob(sendBodyAsBlob)
            .timeout(timeout)
            .build();
        
        HttpClient.request(config);
        Test.stopTest();
    }

    @isTest
    static void testRequestWithHttpClientConfigSendBodyAsBlobValid() {
        String url = 'https://jsonplaceholder.typicode.com/posts';
        String method = 'POST';
        Map<String, String> headers = new Map<String, String>{'Content-Type' => 'application/json'};
        Map<String, String> params = new Map<String, String>{'userId' => '1', 'title' => 'test title', 'body' => 'test body'};
        String body = '{"userId": 1, "title": "test title", "body": "test body"}';
        Boolean sendBodyAsBlob = true;
        Integer timeout = 5000;
        
        HttpClientMock mock = new HttpClientMock(200, 'OK', body, null);

        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        HttpClientConfig config = HttpClientConfig.builder()
            .url(url)
            .method(method)
            .headers(headers)
            .params(params)
            .body(body)
            .sendBodyAsBlob(sendBodyAsBlob)
            .timeout(timeout)
            .build();
        
        HttpClient.request(config);
        Test.stopTest();
    }

    @isTest
    static void testRequestWithHttpClientConfigWithBodyValid() {
        String url = 'https://jsonplaceholder.typicode.com/posts';
        String method = 'POST';
        Map<String, String> headers = new Map<String, String>{'Content-Type' => 'application/json'};
        Map<String, String> params = new Map<String, String>{'userId' => '1', 'title' => 'test title', 'body' => 'test body'};
        Map<String,String> body = new Map<String,String>{'Test' => 'Test'};
        Boolean sendBodyAsBlob = false;
        Integer timeout = 5000;
        
        HttpClientMock mock = new HttpClientMock(200, 'OK', JSON.serialize(body), null);

        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        HttpClientConfig config = HttpClientConfig.builder()
            .url(url)
            .method(method)
            .headers(headers)
            .params(params)
            .body(body)
            .sendBodyAsBlob(sendBodyAsBlob)
            .timeout(timeout)
            .build();
        
        try {
            HttpClient.request(config);
        } catch (HttpClientException e) {
            System.debug(e.getMessage());
        }
        Test.stopTest();
    }

    @isTest
    static void testRequestWithHttpClientConfigWithBodyNull() {
        String url = 'https://jsonplaceholder.typicode.com/posts';
        String method = 'POST';
        Map<String, String> headers = new Map<String, String>{'Content-Type' => 'application/json'};
        Map<String, String> params = new Map<String, String>{'userId' => '1', 'title' => 'test title', 'body' => 'test body'};
        Map<String,String> body = new Map<String,String>{'Test' => 'Test'};
        Boolean sendBodyAsBlob = false;
        Integer timeout = 5000;
        
        HttpClientMock mock = new HttpClientMock(200, 'OK', JSON.serialize(body), null);

        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        HttpClientConfig config = HttpClientConfig.builder()
            .url(url)
            .method(method)
            .headers(headers)
            .params(params)
            .body(null)
            .sendBodyAsBlob(sendBodyAsBlob)
            .timeout(timeout)
            .build();
        
        try {
            HttpClient.request(config);
        } catch (HttpClientException e) {
            System.debug(e.getMessage());
        }
        Test.stopTest();
    }

    @isTest
    static void testRequestWithHttpClientConfigValidHttpCode400() {
        String url = 'https://jsonplaceholder.typicode.com/posts';
        String method = 'POST';
        Map<String, String> headers = new Map<String, String>{'Content-Type' => 'application/json'};
        Map<String, String> params = new Map<String, String>{'userId' => '1', 'title' => 'test title', 'body' => 'test body'};
        Map<String,String> body = new Map<String,String>{'Test' => 'Test'};
        Boolean sendBodyAsBlob = false;
        Integer timeout = 5000;
        
        HttpClientMock mock = new HttpClientMock(400, 'Bad Request', JSON.serialize(body), null);

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
            .retries(3)
            .build();
        
            try {
                HttpClient.request(config);
                Assert.fail();
            } catch (HttpClientException e) {
                System.debug(e.getMessage());
                System.debug(e.getHttpErrorResponse());
                System.debug(e.getHttpErrorResponse().getResponseBody());
                System.debug(e.getHttpErrorResponse().getStatus());
                System.debug(e.getHttpErrorResponse().getStatusCode());
            }
        Test.stopTest();
    }

    @isTest
    static void testRequestTypeWithHttpClientConfigValid() {
        String url = 'https://jsonplaceholder.typicode.com/posts';
        String method = 'POST';
        Map<String, String> headers = new Map<String, String>{'Content-Type' => 'application/json'};
        Map<String, String> params = new Map<String, String>{'userId' => '1', 'title' => 'test title', 'body' => 'test body'};
        Map<String,String> body = new Map<String,String>{'Test' => 'Test'};
        Boolean sendBodyAsBlob = false;
        Integer timeout = 5000;
        
        HttpClientMock mock = new HttpClientMock(200, 'OK', JSON.serialize(body), null);

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
        
        Map<String,String> response = (Map<String,String>) HttpClient.request(config,Map<String,String>.class);
        Test.stopTest();
    }

    @isTest
    static void testRequestTypeWithHttpClientConfigJsonInvalid() {
        String url = 'https://jsonplaceholder.typicode.com/posts';
        String method = 'POST';
        Map<String, String> headers = new Map<String, String>{'Content-Type' => 'application/json'};
        Map<String, String> params = new Map<String, String>{'userId' => '1', 'title' => 'test title', 'body' => 'test body'};
        Map<String,String> body = new Map<String,String>{'Test' => 'Test'};
        Boolean sendBodyAsBlob = false;
        Integer timeout = 5000;
        
        HttpClientMock mock = new HttpClientMock(200, 'OK', JSON.serialize(body.keySet()), null);

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
        
            try{
                Map<String,String> response = (Map<String,String>) HttpClient.request(config,Map<String,String>.class);
                Assert.fail();
            } catch (JSONException e) {
                System.debug(e.getMessage());
            }
        Test.stopTest();
    }

    @isTest
    static void testDoPostValid() {
        String url = 'https://jsonplaceholder.typicode.com/posts';
        String method = 'POST';
        Map<String, String> headers = new Map<String, String>{'Content-Type' => 'application/json'};
        Map<String, String> params = new Map<String, String>{'userId' => '1', 'title' => 'test title', 'body' => 'test body'};
        Map<String,String> body = new Map<String,String>{'Test' => 'Test'};
        Boolean sendBodyAsBlob = false;
        Integer timeout = 5000;
        
        HttpClientMock mock = new HttpClientMock(200, 'OK', JSON.serialize(body), null);

        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
                Map<String,String> response = (Map<String,String>) HttpClient.doPost(url, Map<String,String>.class, headers, body);
                HttpResponse responseHttp = HttpClient.doPost(url, headers, body);
        Test.stopTest();
    }

    @isTest
    static void testDoPutValid() {
        String url = 'https://jsonplaceholder.typicode.com/posts';
        String method = 'PUT';
        Map<String, String> headers = new Map<String, String>{'Content-Type' => 'application/json'};
        Map<String, String> params = new Map<String, String>{'userId' => '1', 'title' => 'test title', 'body' => 'test body'};
        Map<String,String> body = new Map<String,String>{'Test' => 'Test'};
        Boolean sendBodyAsBlob = false;
        Integer timeout = 5000;
        
        HttpClientMock mock = new HttpClientMock(200, 'OK', JSON.serialize(body), null);

        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
                Map<String,String> response = (Map<String,String>) HttpClient.doPut(url, Map<String,String>.class, headers, body);
                HttpResponse responseHttp = HttpClient.doPut(url, headers, body);
        Test.stopTest();
    }

    @isTest
    static void testDoPatchValid() {
        String url = 'https://jsonplaceholder.typicode.com/posts';
        String method = 'PATCH';
        Map<String, String> headers = new Map<String, String>{'Content-Type' => 'application/json'};
        Map<String, String> params = new Map<String, String>{'userId' => '1', 'title' => 'test title', 'body' => 'test body'};
        Map<String,String> body = new Map<String,String>{'Test' => 'Test'};
        Boolean sendBodyAsBlob = false;
        Integer timeout = 5000;
        
        HttpClientMock mock = new HttpClientMock(200, 'OK', JSON.serialize(body), null);

        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
                Map<String,String> response = (Map<String,String>) HttpClient.doPatch(url, Map<String,String>.class, headers, body);
                HttpResponse responseHttp = HttpClient.doPatch(url, headers, body);
        Test.stopTest();
    }

    @isTest
    static void testDoGetValid() {
        String url = 'https://jsonplaceholder.typicode.com/posts';
        String method = 'GET';
        Map<String, String> headers = new Map<String, String>{'Content-Type' => 'application/json'};
        Map<String, String> params = new Map<String, String>{'userId' => '1', 'title' => 'test title', 'body' => 'test body'};
        String body = '{"userId": 1, "title": "test title", "body": "test body"}';
        Boolean sendBodyAsBlob = false;
        Integer timeout = 5000;
        
        HttpClientMock mock = new HttpClientMock(200, 'OK', body, null);

        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
            Map<String,String> response = (Map<String,String>) HttpClient.doGet(url, Map<String,String>.class, headers, params);
            HttpResponse responseHttp = HttpClient.doGet(url, headers, params);
        Test.stopTest();
    }

    @isTest
    static void testDoDeleteValid() {
        String url = 'https://jsonplaceholder.typicode.com/posts';
        String method = 'DELETE';
        Map<String, String> headers = new Map<String, String>{'Content-Type' => 'application/json'};
        Map<String, String> params = new Map<String, String>{'userId' => '1', 'title' => 'test title', 'body' => 'test body'};
        String body = '{"userId": 1, "title": "test title", "body": "test body"}';
        Boolean sendBodyAsBlob = false;
        Integer timeout = 5000;
        
        HttpClientMock mock = new HttpClientMock(200, 'OK', body, null);

        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
            Map<String,String> response = (Map<String,String>) HttpClient.doDelete(url, Map<String,String>.class, headers, params);
            HttpResponse responseHttp = HttpClient.doDelete(url, headers, params);
        Test.stopTest();
    }

    public class HttpClientMock implements HttpCalloutMock{
        private Integer code;
        private String status;
        private String body;
        private Map<String, String> responseHeaders;
        
        public HttpClientMock(Integer code, String status, String body,
                                  Map<String, String> responseHeaders) {
            this.code = code;
            this.status = status;
            this.body = body;
            this.responseHeaders = responseHeaders;
        }
        
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(this.code);
            res.setStatus(status);
            
            if (this.responseHeaders != null) {
                for (String key : this.responseHeaders.keySet()) {
                    res.setHeader(key, this.responseHeaders.get(key));
                }
            }
            
            res.setBody(this.body);
            return res;
        }
        
    }
}