public class HttpClientConfig {
    private final String url;
    private final String method;
    private final Map<String, String> headers;
    private final Map<String, String> params;
    private final Object body;
    private final Boolean sendBodyAsBlob;
    private final Integer timeout;
    private final String namedCredentialDeveloperName;
    private final String namedCredentialPath;
    private final Integer retries;

    private HttpClientConfig(Builder builder) {
        this.url = builder.url;
        this.method = builder.method;
        this.headers = builder.headers;
        this.params = builder.params;
        this.body = builder.body;
        this.sendBodyAsBlob = builder.sendBodyAsBlob;
        this.timeout = builder.timeout;
        this.namedCredentialDeveloperName = builder.namedCredentialDeveloperName;
        this.namedCredentialPath = builder.namedCredentialPath;
        this.retries = builder.retries;
    }

    public String getUrl() { return this.url; }
    public String getMethod() { return this.method; }
    public Map<String, String> getHeaders() { return this.headers; }
    public Map<String, String> getParams() { return this.params; }
    public Object getBody() { return this.body; }
    public Boolean getSendBodyAsBlob() { return this.sendBodyAsBlob; }
    public Integer getTimeout() { return this.timeout; }
    public String getNamedCredentialDeveloperName() { return this.namedCredentialDeveloperName; }
    public String getNamedCredentialPath() { return this.namedCredentialPath; }
    public Integer getRetries() { return this.retries; }

    public HttpResponse request() {
        return HttpClient.request(this);
    }

    public Object request(Type classType) {
        return HttpClient.request(this, classType);
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
        private Map<String, String> headers = new Map<String, String>();
        private Map<String, String> params = new Map<String, String>();
        private Object body;
        private Boolean sendBodyAsBlob = false;
        private Integer timeout = 12000;
        private String namedCredentialDeveloperName;
        private String namedCredentialPath;
        private Integer retries = 1;

        public Builder() {}

        public Builder(HttpClientConfig config) {
            this.url = config.getUrl();
            this.method = config.getMethod();
            this.headers = new Map<String, String>(config.getHeaders());
            this.params = new Map<String, String>(config.getParams());
            this.body = config.getBody();
            this.sendBodyAsBlob = config.getSendBodyAsBlob();
            this.timeout = config.getTimeout();
            this.namedCredentialDeveloperName = config.getNamedCredentialDeveloperName();
            this.namedCredentialPath = config.getNamedCredentialPath();
            this.retries = config.getRetries();
        }

        public Builder url(String url) {
            this.url = url;
            return this;
        }

        public Builder namedCredential(String namedCredential, String namedCredentialPath) {
            this.namedCredentialDeveloperName = namedCredential;
            this.namedCredentialPath = namedCredentialPath;
            this.url = 'callout:' + this.namedCredentialDeveloperName + this.namedCredentialPath;
            return this;
        }

        public Builder namedCredential(NamedCredential namedCredential, String namedCredentialPath) {
            this.namedCredential(namedCredential.DeveloperName, namedCredentialPath);
            return this;
        }

        public Builder method(String method) {
            this.method = method;
            return this;
        }

        public Builder headers(Map<String, String> headers) {
            this.headers.putAll(headers);
            return this;
        }

        public Builder addHeader(String key, String value) {
            this.headers.put(key, value);
            return this;
        }

        public Builder params(Map<String, String> params) {
            this.params.putAll(params);
            return this;
        }

        public Builder addParam(String key, String value) {
            this.params.put(key, value);
            return this;
        }

        public Builder body(Object body) {
            this.body = body;
            return this;
        }

        public Builder sendBodyAsBlob(Boolean sendBodyAsBlob) {
            this.sendBodyAsBlob = sendBodyAsBlob;
            return this;
        }

        public Builder timeout(Integer timeout) {
            this.timeout = timeout;
            return this;
        }

        public Builder retries(Integer retries) {
            this.retries = retries;
            return this;
        }

        public HttpClientConfig build() {
            return new HttpClientConfig(this);
        }
    }
}
