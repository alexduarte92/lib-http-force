global class HttpClientConfig {
    private String url;
    private String method;
    private Map<String,String> headers;
    private Map<String,String> params;
    private Object body;
    private Boolean sendBodyAsBlob;
    private Integer timeout;
    private String namedCredentialDeveloperName;
    private String namedCredentialPath;

    global String getUrl() {
        return this.url;
    }

    global String getMethod() {
        return this.method;
    }

    global Map<String,String> getHeaders() {
        return this.headers;
    }

    global Map<String,String> getParams() {
        return this.params;
    }

    global Object getBody() {
        return this.body;
    }

    global Boolean getSendBodyAsBlob() {
        return this.sendBodyAsBlob;
    }

    global Integer getTimeout() {
        return this.timeout;
    }

    global String getNamedCredentialDeveloperName() {
        return this.namedCredentialDeveloperName;
    }

    global String getNamedCredentialPath() {
        return this.namedCredentialPath;
    }

    global HttpResponse request() {
        return HttpClient.request(this);
    }

    global Object request(Type classType) {
        return HttpClient.request(this, classType);
    }

    global static Builder builder() {
        return new Builder();
    }

    global static Builder builder(HttpClientConfig config) {
        return new Builder(config);
    }

    global class Builder {
        private String url;
        private String method;
        private Map<String,String> headers;
        private Map<String,String> params;
        private Object body;
        private Boolean sendBodyAsBlob;
        private Integer timeout;
        private String namedCredentialDeveloperName;
        private String namedCredentialPath;

        global Builder(HttpClientConfig config) {
            this.fromHttpClientConfig(config);
        }

        global Builder() {
            this.headers = new Map<String,String>();
            this.params = new Map<String,String>();
            this.sendBodyAsBlob = false;
            this.method = 'GET';
            this.timeout = 12000;
        }

        global Builder setUrl(String url) {
            this.url = url;
            return this;
        }

        global Builder setUrl(NamedCredential namedCredential, String namedCredentialPath) {
            return this.setUrl(namedCredential.DeveloperName, namedCredentialPath);
        }

        global Builder setUrl(String namedCredentialDeveloperName, String namedCredentialPath) {
            this.namedCredentialDeveloperName = namedCredentialDeveloperName;
            this.namedCredentialPath = namedCredentialPath;
            return this.setUrl(String.format('callout:{0}{1}', new List<String>{this.namedCredentialDeveloperName, this.namedCredentialPath}));
        }

        global Builder setMethod(String method) {
            this.method = method;
            return this;
        }

        global Builder setHeaders(Map<String,String> headers) {
            this.headers.putAll(headers);
            return this;
        }

        global Builder addHeader(String key, String value) {
            this.headers.put(key, value);
            return this;
        }

        global Builder setParams(Map<String,String> params) {
            this.params.putAll(params);
            return this;
        }

        global Builder addParam(String key, String value) {
            this.params.put(key, value);
            return this;
        }

        global Builder setBody(Object body) {
            this.body = body;
            return this;
        }

        global Builder setSendBodyAsBlob(Boolean sendBodyAsBlob) {
            this.sendBodyAsBlob = sendBodyAsBlob;
            return this;
        }

        global Builder setTimeout(Integer timeout) {
            this.timeout = timeout;
            return this;
        }

        private void fromHttpClientConfig(HttpClientConfig config) {
            this.url = config.getUrl();
            this.method = config.getMethod();
            this.headers = config.getHeaders();
            this.params = config.getParams();
            this.body = config.getBody();
            this.sendBodyAsBlob = config.getSendBodyAsBlob();
            this.timeout = config.getTimeout();
            this.namedCredentialDeveloperName = config.getNamedCredentialDeveloperName();
            this.namedCredentialPath = config.getNamedCredentialPath();
        }

        global HttpClientConfig build() {
            HttpClientConfig config = new HttpClientConfig();
            config.url = this.url;
            config.method = this.method;
            config.headers = this.headers;
            config.params = this.params;
            config.body = this.body;
            config.sendBodyAsBlob = this.sendBodyAsBlob;
            config.timeout = this.timeout;
            config.namedCredentialDeveloperName = this.namedCredentialDeveloperName;
            config.namedCredentialPath = this.namedCredentialPath;
            return config;
        }
    }
}