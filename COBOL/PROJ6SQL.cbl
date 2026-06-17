       IDENTIFICATION DIVISION.
       PROGRAM-ID. PROJ6SQL.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01  SQL-RETURN              PIC S9(9) COMP-5.
       01  SQL-OK                  PIC S9(9) COMP-5 VALUE 0.
       01  SQL-INFO                PIC S9(9) COMP-5 VALUE 1.

       01  SQL-HANDLE-ENV          PIC S9(9) COMP-5 VALUE 1.
       01  SQL-HANDLE-DBC          PIC S9(9) COMP-5 VALUE 2.
       01  SQL-HANDLE-STMT         PIC S9(9) COMP-5 VALUE 3.

       01  SQL-ATTR-ODBC-VERSION   PIC S9(9) COMP-5 VALUE 200.
       01  SQL-OV-ODBC3            PIC S9(9) COMP-5 VALUE 3.

       01  SQL-NTS                 PIC S9(9) COMP-5 VALUE -3.
       01  SQL-NOPROMPT            PIC S9(9) COMP-5 VALUE 0.

       01  HENV                    USAGE POINTER.
       01  HDBC                    USAGE POINTER.
       01  HSTMT                   USAGE POINTER.
       01  NULL-PTR                USAGE POINTER.

       01  CONN-STR                PIC X(100).
       01  OUT-STR                 PIC X(200).
       01  OUT-LEN                 PIC S9(4) COMP-5.

       01  SQL-CMD                 PIC X(500).

       PROCEDURE DIVISION.

       INICIO.
           DISPLAY "INICIANDO TESTE COBOL + ODBC + MYSQL...".

           SET NULL-PTR TO NULL.

           CALL "SQLAllocHandle"
               USING BY VALUE SQL-HANDLE-ENV
                     BY VALUE NULL-PTR
                     BY REFERENCE HENV
               RETURNING SQL-RETURN.

           PERFORM TESTAR-RETORNO.

           CALL "SQLSetEnvAttr"
               USING BY VALUE HENV
                     BY VALUE SQL-ATTR-ODBC-VERSION
                     BY VALUE SQL-OV-ODBC3
                     BY VALUE 0
               RETURNING SQL-RETURN.

           PERFORM TESTAR-RETORNO.

           CALL "SQLAllocHandle"
               USING BY VALUE SQL-HANDLE-DBC
                     BY VALUE HENV
                     BY REFERENCE HDBC
               RETURNING SQL-RETURN.

           PERFORM TESTAR-RETORNO.

           MOVE SPACES TO CONN-STR.

           STRING "DSN=BANCOCOBOL;"
               DELIMITED BY SIZE
               INTO CONN-STR
           END-STRING.

           CALL "SQLDriverConnectA"
               USING BY VALUE HDBC
                     BY VALUE NULL-PTR
                     BY REFERENCE CONN-STR
                     BY VALUE SQL-NTS
                     BY REFERENCE OUT-STR
                     BY VALUE 200
                     BY REFERENCE OUT-LEN
                     BY VALUE SQL-NOPROMPT
               RETURNING SQL-RETURN.

           PERFORM TESTAR-RETORNO.

           DISPLAY "CONEXAO ODBC REALIZADA COM SUCESSO.".

           CALL "SQLAllocHandle"
               USING BY VALUE SQL-HANDLE-STMT
                     BY VALUE HDBC
                     BY REFERENCE HSTMT
               RETURNING SQL-RETURN.

           PERFORM TESTAR-RETORNO.

           MOVE SPACES TO SQL-CMD.

           STRING "INSERT INTO ERROS_PROCESSAMENTO "
                  "(CLI_ID, DESCRICAO_ERRO, DT_OCORRENCIA) "
                  "VALUES (999, 'TESTE COBOL ODBC DIRETO', NOW())"
               DELIMITED BY SIZE
               INTO SQL-CMD
           END-STRING.

           CALL "SQLExecDirectA"
               USING BY VALUE HSTMT
                     BY REFERENCE SQL-CMD
                     BY VALUE SQL-NTS
               RETURNING SQL-RETURN.

           PERFORM TESTAR-RETORNO.

           DISPLAY "INSERT REALIZADO DIRETAMENTE PELO COBOL.".

           CALL "SQLFreeHandle"
               USING BY VALUE SQL-HANDLE-STMT
                     BY VALUE HSTMT
               RETURNING SQL-RETURN.

           CALL "SQLDisconnect"
               USING BY VALUE HDBC
               RETURNING SQL-RETURN.

           CALL "SQLFreeHandle"
               USING BY VALUE SQL-HANDLE-DBC
                     BY VALUE HDBC
               RETURNING SQL-RETURN.

           CALL "SQLFreeHandle"
               USING BY VALUE SQL-HANDLE-ENV
                     BY VALUE HENV
               RETURNING SQL-RETURN.

           DISPLAY "TESTE FINALIZADO.".

           STOP RUN.

       TESTAR-RETORNO.
           IF SQL-RETURN NOT = SQL-OK
              AND SQL-RETURN NOT = SQL-INFO
               DISPLAY "ERRO ODBC. CODIGO: " SQL-RETURN
               STOP RUN
           END-IF.
