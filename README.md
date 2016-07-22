# PROJETO PCS2427 - 2016

## Instruções Gerais:
* Deseja-se construir um ambiente para simular dispositivos formais da classe dos autômatos.
* Simularemos autômatos finitos, autômatos de pilha estruturados e máquinas de Turing.
* Simulador deve ser dirigido por eventos.
* No ínicio do processamento, o programa simulador deve ler um arquivo .txt com o conjunto de regras.

### Rastros:
* O simulador deve fornecer como saída um rastro passo a passo do funcionamento do autômato.
* Esse rastro deve reportar cada variação ocorrida na configuração instantânea do autômato com destaque:
    * Estado
    * Símbolo do entrada utilizado
    * Submáquina
    * Ao topo da pilha
    * Informar a regra aplicada e seus efeitos
* Entradas:
    * Tipo de dispositivo a utilizar
    * O particular dispositivo a simular e as entradas a aplicar
    * Opção de rastreamento da operação (ligar/desligar)

### Testes
* Mínimo três autômatos de cada tipo, com complexidade progressiva.
* Diversos casos de teste para cada um desses autômatos ensaiados. Cobrindo todos os recuross das linguagens representadas por tais formalismos.
* Elaborar um relatório técnico completo para este projeto. Descrevendo:
    * Testes efetuados
    * Comentando saídaes geradas nesses testes
    * Analisando os resultados obtidos

## Autômato Finito

### Elementos a considerar
* Lista dos eventos a serem considerados
* Especificação dos constituintes da configuração do dispositivo que deve processar os eventos
* Categorização dos eventos de acordo com o tipo de tratamento que deve receber
* Especificação da mudança de configuração do dispositivo
* Especificação dos tratamentos a serem aplicados a cada categoria de evento

### Eventos a considerar
* Inicio do processamento
* Movimento do cabeçote para a direita
* Leitura de símbolo do alfabeto
* LEitura de uma marca de final da cadeira de entrada
* Atingir um estado final

### Configuração de um Autômato Finito
* M = (Q, sigma, delta, q0, F)
* Q -> Estado corrente
* sigma -> Conteúdo da fita apontado pelo cabeçote
* Configuração:
    * Q x sigma* x sigma x sigma* \#
    * sigma* -> Conteúdo da fita à esquerda e conteúdo da fita à direita
    * \# -> Marca de final da cadeira de entrada

### Categorias de eventos
* Leitura de dados na  fita
    * Leitura de Símbolo da cadeia presente na célula da fita, correntemente apontada pelo cabeçote.
    * Autômatos Finitos não gravam dados na fita
* Movimento do cabeçote
    * Movimento do cabeçote para a direita, após a leitura
    * Autômatos finitos não movem cabeçote para a esquerda
* Início e final do processamento
    * Partida inicial (estando o autômato no estado inicial)
    * Rejeição: Erro por não haver transição aplicável
    * Aceitação: Chegada a um estado final, como cabeçote apontando um marcador de final da cadeia de entrada.

### Mudança de Configuração
* Configuração:
    * Estado corrente
    * Conteúdo da fita
    * Posição do cabeçote sobre a fita
* Estímulo:
    * Símbolo de entrada apontado pelo cursor na fita
    * Movimento de cabeçote à direita
* Parada
    * Aceitação (estado final, cabeçote no final da cadeia de entrada)
    * Rejeição (inexistência de movimento viável)
    
### Passos de Transição
* delta(q1, a1) = q2 -> Consumo do símbolo a1
* delta(q1, a1) = q2 -> Se a1 = Vazio ocorre uma transição em vazio
* delta(q1,a1) não está definido, e neste caso há uma rejeição da cadeia entrada pelo autômato
* No caso de q2 ser um estado final, se a2 for o marcador de final de cadeia de entrada, e portanto u2=Vazio, então ocorre aceitação da cadeia de entrada

## Máquina de Turing

### Configuração
* Estado corrente da máquina
* Posição do cabeçote sobre a fita
* Conteúdo da fita
    * Cadeia à esquerda do cursor
    * Símbolo apontado pelo cursor
    * Cadeira à direita do cursor
    * Marca de final da cadeia de entrada

### Notação
* (q, w, a, u) pode ser denotada por (q, w<u>a</u>u)

### Eventos a considerar
* Inicio do processamento
* Leitura de símbolo do alfabeto, presente na célula da fita apontada pelo cabeçote
* Gravação de símbolo do alfabeto na célula da fita apontada pelo cabeçote
* Movimento do cabeçote para a esquerda (L)
* Movimento do cabeçote para a direita (R)
* Tentativa de recuar para antes do início da fita
* Atingir o estado de Halt (fim da computação)

### Categorias de Eventos
* Leitura e Gravação de dados na fita
    * Leitura de símbolo da cadeia
    * Gravação de símbolo na posição do cursor
* Movimento do cabeçote
    * Cabeçote para a esquerda
    * Cabeçote para a direita
* Início e final do processamento
    * Partida inicial
    * Erro por não haver transição aplicável
    * Chegada ao estado de halt
    * Bloqueio por tentativa de mover aquém do início da fita

## Geral

### Leitura e Gravação de dados na fita
* Leitura de Símbolo
    * Atualiza o símbolo corrente
* Gravação de Símbolo
    * Remove o símbolo apontado pelo cabeçote
    * Insere o símbolo a ser gravado
    * Atualiza o símbolo corrente

### Movimento do Cabeçote
* Para direita
    * Concatenar o símbolo corrente à direita do conteúdo da fita à esquerda do cabeçote
    * Destacar o primeiro símbolo da cadeia presente na fita à direita do cabeçote e posicionar o cabeçote sobre ele
    * Se a cadeia à direita do cabeçote estiver vazia, avançar para a direita uma célula em branco
    * Caso contrário, atualizar a cadeia à direita do cabeçote removendo-lhe o primeiro símbolo
* Para esquerda
    * Se a cadeia estiver vazia, terminar o processamento bloqueando a máquina

### Início e final do processamento
* Partida Inicial
    * Posicionar o autômato no estado inicial
    * Preencher a fita de trabalho com a cadeia a analisar
    * Acionar pela primeira vez a execução de uma regra
* Ausência de transição viável
    * Parada por erro
* Chegada ao estado de Halt
    * Verificar o conteúdo da fita, e aplicar a convenção adotada para avaliar se cadeia foi aceita ou não
* Tentativa de recuar à esquerda do início da fita
    * Bloqueio da máquina de Turing por movimento proibido