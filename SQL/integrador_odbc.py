import pyodbc
from datetime import date

conn = pyodbc.connect("DSN=BANCOCOBOL;")
cursor = conn.cursor()

cursor.execute("DELETE FROM ERROS_PROCESSAMENTO")
cursor.execute("DELETE FROM TRANSACOES")
cursor.execute("DELETE FROM CLIENTES")

# Carrega clientes
with open("DADOS/CLIENTES.TXT", "r", encoding="utf-8") as arquivo:
    for linha in arquivo:
        cli_id = int(linha[0:5])
        nome = linha[5:35].strip()
        saldo = int(linha[35:44])

        cursor.execute("""
            INSERT INTO CLIENTES
            (CLI_ID, CLI_NOME, CLI_SALDO, DT_ATUALIZACAO)
            VALUES (?, ?, ?, ?)
        """, cli_id, nome, saldo, date.today())

# Carrega transações
with open("DADOS/TRANSACOES.TXT", "r", encoding="utf-8") as arquivo:
    for linha in arquivo:
        cli_id = int(linha[0:5])
        trx_id = int(linha[5:10])
        tipo = linha[10:11]
        valor = int(linha[11:20])

        cursor.execute("""
            INSERT INTO TRANSACOES
            (TRX_ID, CLI_ID, TRX_TIPO, TRX_VALOR, DT_PROCESSAMENTO)
            VALUES (?, ?, ?, ?, ?)
        """, trx_id, cli_id, tipo, valor, date.today())

conn.commit()

print("INTEGRACAO ODBC FINALIZADA COM SUCESSO.")
print("CLIENTES E TRANSACOES ENVIADOS PARA O MYSQL.")

conn.close()