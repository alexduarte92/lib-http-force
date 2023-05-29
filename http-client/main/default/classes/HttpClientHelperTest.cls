@isTest
public class HttpClientHelperTest {

    @isTest
    static void testHeadersHasContentTypeFormUrlEncoded() {
        Map<String,String> headers = new Map<String,String>{
            HttpClientHelper.HEADER_CONTENT_TYPE => HttpClientHelper.HEADER_URL_ENCODED
        };
        System.assertEquals(true, HttpClientHelper.headersHasContentTypeFormUrlEncoded(headers));
    }

    @isTest
    static void testValidAllowedHttpMethods() {
        HttpClientConfig config = HttpClientConfig.builder()
            .setUrl('https://www.example.com')
            .setMethod('POST')
            .build();
        System.assertEquals(true, HttpClientHelper.validAllowedHttpMethods(config));
    }

    @isTest
    static void testUrlIsBlank() {
        HttpClientConfig config = HttpClientConfig.builder()
            .setUrl('')
            .build();
        System.assertEquals(true, HttpClientHelper.urlIsBlank(config));
    }

    @isTest
    static void testBodyIsBlob() {
        HttpClientConfig config = HttpClientConfig.builder()
            .setBody(Blob.valueOf('test'))
            .build();
        System.assertEquals(true, HttpClientHelper.bodyIsBlob(config));
    }

    @isTest
    static void testBodyIsString() {
        HttpClientConfig config = HttpClientConfig.builder()
            .setBody('test')
            .build();
        System.assertEquals(true, HttpClientHelper.bodyIsString(config));
    }

    @isTest
    static void testBodyIsMapStringString() {
        Map<String,String> body = new Map<String,String>{
            'key1' => 'value1',
            'key2' => 'value2'
        };
        System.assertEquals(true, HttpClientHelper.objectIsMapStringString(body));
    }

    @isTest
    static void testBodyIsNull() {
        Object body = null;
        System.assertEquals(true, HttpClientHelper.objectIsNull(body));
    }

    @isTest
    static void testGetAllowedHttpMethods() {
        String allowedMethods = HttpClientHelper.getAllowedHttpMethods();
        System.assertEquals('GET, POST, PUT, PATCH, DELETE', allowedMethods);
    }
}