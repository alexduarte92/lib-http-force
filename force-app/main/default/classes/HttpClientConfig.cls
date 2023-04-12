public class HttpClientConfig {
    private String url;
    private String method;
    private Map<String,String> headers;
    private Map<String,String> params;
    private Object body;
    private Boolean sendBodyAsBlob;
    private Integer timeout;

    public String getUrl() {
        return this.url;
    }

    public String getMethod() {
        return this.method;
    }

    public Map<String,String> getHeaders() {
        return this.headers;
    }

    public Map<String,String> getParams() {
        return this.params;
    }

    public Object getBody() {
        return this.body;
    }

    public Boolean getSendBodyAsBlob() {
        return this.sendBodyAsBlob;
    }

    public Integer getTimeout() {
        return this.timeout;
    }

    public static Builder builder() {
        return new Builder();
    }

    public static Builder builder(HttpClientConfig config) {
        return new Builder(config);
    }

    public class Builder {
        private String url;
        private String method;
        private Map<String,String> headers;
        private Map<String,String> params;
        private Object body;
        private Boolean sendBodyAsBlob;
        private Integer timeout;

        public Builder(HttpClientConfig config) {
            this.fromHttpClientConfig(config);
        }

        public Builder() {
            this.headers = new Map<String,String>();
            this.params = new Map<String,String>();
            this.sendBodyAsBlob = false;
            this.method = 'GET';
            this.timeout = 12000;
        }

        public Builder setUrl(String url) {
            this.url = url;
            return this;
        }

        public Builder setMethod(String method) {
            this.method = method;
            return this;
        }

        public Builder setHeaders(Map<String,String> headers) {
            this.headers.putAll(headers);
            return this;
        }

        public Builder addHeader(String key, String value) {
            this.headers.put(key, value);
            return this;
        }

        public Builder setParams(Map<String,String> params) {
            this.params.putAll(params);
            return this;
        }

        public Builder addParam(String key, String value) {
            this.params.put(key, value);
            return this;
        }

        public Builder setBody(Object body) {
            this.body = body;
            return this;
        }

        public Builder setSendBodyAsBlob(Boolean sendBodyAsBlob) {
            this.sendBodyAsBlob = sendBodyAsBlob;
            return this;
        }

        public Builder setTimeout(Integer timeout) {
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
        }

        public HttpClientConfig build() {
            HttpClientConfig config = new HttpClientConfig();
            config.url = this.url;
            config.method = this.method;
            config.headers = this.headers;
            config.params = this.params;
            config.body = this.body;
            config.sendBodyAsBlob = this.sendBodyAsBlob;
            config.timeout = this.timeout;
            return config;
        }
    }
}