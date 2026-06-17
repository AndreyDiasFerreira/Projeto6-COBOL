# Sistema de Contas Bancárias em COBOL com ODBC

Projeto desenvolvido por **Andrey Dias Ferreira** para fins acadêmicos e preparação para atuação em ambiente Mainframe.

## Objetivo

Este projeto implementa um sistema batch em COBOL para processamento de clientes e transações bancárias, conforme o Projeto 6 - Semana 8.

O sistema realiza:

- leitura de arquivo de clientes;
- leitura de arquivo de transações;
- validação das regras de negócio;
- atualização lógica de saldos em memória;
- geração de arquivo de saída com status dos registros;
- geração de arquivo de erros;
- criação de estrutura de banco de dados MySQL;
- configuração de conexão ODBC;
- criação de JCL de treinamento.

## Tecnologias utilizadas

- COBOL
- GnuCOBOL 2.0
- OpenCobolIDE 4.7.6
- MySQL 8.0
- MySQL Connector/ODBC
- Windows
- JCL para documentação e treinamento

## Estrutura do projeto

```text
PROJETO6-COBOL-ODBC/
│
├── COBOL/
│   ├── PROJ6CLI.cbl
│   └── PROJ6MOV.cbl
│
├── DADOS/
│   ├── CLIENTES.TXT
│   ├── TRANSACOES.TXT
│   ├── SAIDA.TXT
│   └── ERROS.TXT
│
├── SQL/
│   └── banco.sql
│
├── JCL/
│   └── PROJ6.jcl
│
└── PRINTS/
    ├── 01_ODBC_OK.jpg
    ├── 02_BANCO_E_TABELAS.png
    ├── 03_CLIENTES.png
    ├── 04_TRANSACOES.png
    ├── 05_PROJ6CLI_EXECUTANDO.png
    ├── 06_PROJ6MOV_EXECUTANDO.png
    ├── 07_SAIDA_TXT.png
    ├── 08_ERROS_TXT.png
    └── 09_ESTRUTURA_PROJETO.png
```

## Programas COBOL

### PROJ6CLI.cbl

Programa responsável por ler o arquivo `CLIENTES.TXT` e exibir os clientes processados.

### PROJ6MOV.cbl

Programa responsável por:

- carregar clientes em memória;
- ler o arquivo `TRANSACOES.TXT`;
- localizar o cliente;
- validar tipo da transação;
- validar valor zerado;
- validar saldo suficiente para saque;
- atualizar saldo em memória;
- gerar `SAIDA.TXT`;
- gerar `ERROS.TXT`.

## Arquivos de entrada

### CLIENTES.TXT

```text
00123JOAO SILVA                    000010000
00456MARIA SOUZA                   000025000
00789CARLOS PEREIRA                000005000
```

### TRANSACOES.TXT

```text
0012300010C000000500
0012300020D000000200
0045600030D000001000
0078900040D000020000
```

## Arquivos de saída

### SAIDA.TXT

Contém o status das transações processadas com sucesso.

### ERROS.TXT

Contém os erros encontrados durante o processamento. No cenário testado, o arquivo ficou vazio porque todas as transações foram processadas com sucesso.

## Banco de dados

O projeto original cita DB2, porém, conforme orientação recebida, foi utilizada uma execução via IDE com banco MySQL e conexão ODBC.

Banco criado:

```text
projeto_cobol
```

Tabelas criadas:

- CLIENTES
- TRANSACOES
- ERROS_PROCESSAMENTO

O script está disponível em:

```text
SQL/banco.sql
```

## ODBC

Foi configurado um DSN de sistema chamado:

```text
BANCOCOBOL
```

Configuração utilizada:

```text
Servidor: localhost
Porta: 3306
Banco: projeto_cobol
Usuário: root
Driver: MySQL ODBC Unicode Driver
```

A conexão foi testada com sucesso, conforme print disponível na pasta `PRINTS`.

## JCL

O arquivo `JCL/PROJ6.jcl` foi criado para treinamento e documentação, simulando uma execução em ambiente mainframe.

A execução real do projeto foi feita no OpenCobolIDE, conforme orientação recebida.

## Como executar

1. Criar a pasta `C:\COBOL`.
2. Copiar os arquivos de entrada para `C:\COBOL`.
3. Abrir `PROJ6CLI.cbl` no OpenCobolIDE.
4. Executar o programa.
5. Abrir `PROJ6MOV.cbl` no OpenCobolIDE.
6. Executar o programa.
7. Verificar os arquivos gerados:
   - `SAIDA.TXT`
   - `ERROS.TXT`

## Evidências

A pasta `PRINTS` contém as evidências de:

- conexão ODBC funcionando;
- banco MySQL criado;
- tabelas criadas;
- dados cadastrados;
- execução dos programas COBOL;
- arquivos de saída gerados;
- estrutura final do projeto.

## Observação

A integração direta entre COBOL e banco de dados via ODBC foi preparada no ambiente por meio da criação do DSN `BANCOCOBOL`. A execução principal do processamento foi realizada via arquivos, mantendo o comportamento batch solicitado no projeto.
