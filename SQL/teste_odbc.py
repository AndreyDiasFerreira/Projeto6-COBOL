import pyodbc

conn = pyodbc.connect(
    "DSN=BANCOCOBOL;"
)

cursor = conn.cursor()

cursor.execute("SELECT * FROM CLIENTES")

for linha in cursor.fetchall():
    print(linha)

conn.close()