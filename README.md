# Salesforce HTTP Client

A classe `HttpClientConfig` é usada para configurar as solicitações HTTP. Ela fornece uma maneira fácil de definir o URL, o método HTTP, os cabeçalhos, os parâmetros e o corpo da solicitação. Também permite que os usuários definam algumas opções de configuração adicionais, como enviar o corpo como blob e definir um tempo limite para a solicitação.

A classe `HttpClientHelper` contém vários métodos auxiliares que são usados pela classe principal para validar as informações da solicitação. Por exemplo, há métodos para verificar se o método HTTP é permitido, se o URL está em branco e se o corpo da solicitação está inválido.

A classe `HttpClient` é a principal, faz o uso das outras classes para executar solicitações HTTP. Ele contém métodos para executar solicitações HTTP síncronas e assíncronas, com e sem autenticação. A classe também fornece métodos auxiliares para manipular as respostas HTTP recebidas.

Por fim, a classe `HttpClientException` é usada para representar exceções que ocorrem durante as solicitações HTTP. Ele contém uma referência a uma instância de `HttpClientErrorHandlerResponse`, que pode ser usada para examinar os detalhes da resposta HTTP que causaram a exceção.
