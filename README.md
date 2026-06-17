# 🚀 Projeto 6 – Processamento de Transações Bancárias com COBOL, ODBC e MySQL

![COBOL](https://img.shields.io/badge/COBOL-GnuCOBOL-blue)
![MySQL](https://img.shields.io/badge/MySQL-8.0-orange)
![ODBC](https://img.shields.io/badge/ODBC-Connector-green)
![Status](https://img.shields.io/badge/Status-Concluído-success)

---

## 👨‍💻 Autor

**Andrey Dias Ferreira**

Projeto desenvolvido para fins de preparação para atuação em ambientes Mainframe e processamento corporativo utilizando COBOL.

---

# 📋 Objetivo

Desenvolver um sistema de processamento de transações bancárias utilizando COBOL, realizando:

✅ Leitura de clientes

✅ Leitura de transações

✅ Processamento de movimentações

✅ Geração de arquivos de saída

✅ Registro de erros

✅ Integração com banco de dados MySQL via ODBC

---

# 🛠 Tecnologias Utilizadas

| Tecnologia | Utilização |
|------------|------------|
| COBOL (GnuCOBOL) | Processamento principal |
| OpenCobolIDE | Desenvolvimento |
| Python | Integração ODBC |
| PyODBC | Comunicação com banco |
| MySQL Server | Banco de dados |
| MySQL Workbench | Administração |
| ODBC Connector | Conexão |
| GitHub | Versionamento |
| JCL | Simulação Mainframe |

---

# 📁 Estrutura do Projeto

```text
Projeto6-COBOL-ODBC
│
├── COBOL
│   ├── PROJ6CLI.cbl
│   └── PROJ6MOV.cbl
│
├── DADOS
│   ├── CLIENTES.TXT
│   ├── TRANSACOES.TXT
│   ├── SAIDA.TXT
│   └── ERROS.TXT
│
├── SQL
│   ├── banco.sql
│   ├── teste_odbc.py
│   └── integrador_odbc.py
│
├── JCL
│   └── PROJ6.JCL
│
├── PRINTS
│   ├── ODBC_OK.png
│   ├── CLIENTES.png
│   ├── TRANSACOES.png
│   ├── ERROS.png
│   ├── PROJ6CLI.png
│   └── PROJ6MOV.png
│
└── README.md
```

---

# 🗄 Banco de Dados

## CLIENTES

```sql
CREATE TABLE CLIENTES (
    CLI_ID INTEGER NOT NULL,
    CLI_NOME VARCHAR(30),
    CLI_SALDO DECIMAL(9,0),
    DT_ATUALIZACAO DATE,
    PRIMARY KEY (CLI_ID)
);
```

## TRANSACOES

```sql
CREATE TABLE TRANSACOES (
    TRX_ID INTEGER NOT NULL,
    CLI_ID INTEGER NOT NULL,
    TRX_TIPO CHAR(1) NOT NULL,
    TRX_VALOR DECIMAL(9,0) NOT NULL,
    DT_PROCESSAMENTO DATE,
    PRIMARY KEY (TRX_ID)
);
```

## ERROS_PROCESSAMENTO

```sql
CREATE TABLE ERROS_PROCESSAMENTO (
    ID_ERRO INTEGER AUTO_INCREMENT,
    CLI_ID INTEGER,
    DESCRICAO_ERRO VARCHAR(100),
    DT_OCORRENCIA TIMESTAMP,
    PRIMARY KEY (ID_ERRO)
);
```

---

# 🔄 Fluxo do Sistema

```text
CLIENTES.TXT
      │
      ▼
PROJ6CLI.CBL
      │
      ▼
Leitura dos Clientes
      │
      ▼
TRANSACOES.TXT
      │
      ▼
PROJ6MOV.CBL
      │
      ├── SAIDA.TXT
      └── ERROS.TXT
      │
      ▼
integrador_odbc.py
      │
      ▼
ODBC
      │
      ▼
MySQL
```

---

# 📊 Resultados Obtidos

## Clientes Processados

| ID | Cliente | Saldo |
|----|----------|---------|
| 123 | JOAO SILVA | 10000 |
| 456 | MARIA SOUZA | 25000 |
| 789 | CARLOS PEREIRA | 5000 |

---

## Transações Processadas

| TRX_ID | CLI_ID | Tipo | Valor |
|---------|---------|------|---------|
| 10 | 123 | C | 500 |
| 20 | 123 | D | 200 |
| 30 | 456 | D | 1000 |
| 40 | 789 | D | 20000 |

---

# 📄 Arquivo SAIDA.TXT

```text
OK - SAQUE - CLI_ID: 00123 VALOR: 000000500
OK - DEPOSITO - CLI_ID: 00123 VALOR: 000000200
OK - DEPOSITO - CLI_ID: 00456 VALOR: 000001000
OK - DEPOSITO - CLI_ID: 00789 VALOR: 000020000
```

---

# 📄 Arquivo ERROS.TXT

```text
Nenhum erro encontrado.
```

---

# 🔌 Integração ODBC

Fonte de Dados configurada:

```text
BANCOCOBOL
```

Parâmetros:

```text
Servidor : localhost
Porta    : 3306
Banco    : projeto_cobol
Driver   : MySQL ODBC Connector 8.x
```

### Teste realizado com sucesso

✅ Conexão ODBC validada

✅ Leitura do banco funcionando

✅ Integração concluída

---

# 📸 Evidências

## Configuração ODBC

Adicione aqui:

```text
PRINTS/ODBC_OK.png
```

## Clientes carregados

```text
PRINTS/CLIENTES.png
```

## Transações processadas

```text
PRINTS/TRANSACOES.png
```

## Execução COBOL

```text
PRINTS/PROJ6CLI.png
PRINTS/PROJ6MOV.png
```

---

# 🖥 Simulação Mainframe

Também foi criado um JCL para treinamento e adaptação do projeto para ambientes Mainframe.

```jcl
//JOBNAME JOB ...
//STEP01 EXEC PGM=PROJ6CLI
//STEP02 EXEC PGM=PROJ6MOV
```

> Conforme orientação da disciplina, o JCL foi desenvolvido para fins de prática e não necessita ser executado.

---

# ✅ Conclusão

O projeto demonstra a integração entre:

- COBOL
- Processamento de Arquivos
- ODBC
- Banco de Dados MySQL
- Simulação Mainframe com JCL
- Versionamento GitHub

Representando um fluxo corporativo de processamento de transações bancárias semelhante ao encontrado em ambientes empresariais.

---

## 🎯 Status Final

| Item | Status |
|--------|---------|
| COBOL | ✅ |
| Processamento de Arquivos | ✅ |
| MySQL | ✅ |
| ODBC | ✅ |
| JCL | ✅ |
| GitHub | ✅ |
| Documentação | ✅ |

### ✔ Projeto Concluído