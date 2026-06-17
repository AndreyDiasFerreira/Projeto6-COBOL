       IDENTIFICATION DIVISION.
       PROGRAM-ID. PROJ6MOV.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARQ-CLIENTES ASSIGN TO "C:\COBOL\CLIENTES.TXT"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT ARQ-TRANS ASSIGN TO "C:\COBOL\TRANSACOES.TXT"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT ARQ-SAIDA ASSIGN TO "C:\COBOL\SAIDA.TXT"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT ARQ-ERROS ASSIGN TO "C:\COBOL\ERROS.TXT"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.

       FD ARQ-CLIENTES.
       01 REG-CLIENTE.
           05 CLI-ID        PIC 9(05).
           05 CLI-NOME      PIC X(30).
           05 CLI-SALDO     PIC 9(09).

       FD ARQ-TRANS.
       01 REG-TRANS.
           05 TRX-CLI-ID    PIC 9(05).
           05 TRX-ID        PIC 9(05).
           05 TRX-TIPO      PIC X(01).
           05 TRX-VALOR     PIC 9(09).

       FD ARQ-SAIDA.
       01 REG-SAIDA         PIC X(120).

       FD ARQ-ERROS.
       01 REG-ERRO          PIC X(120).

       WORKING-STORAGE SECTION.
       01 WS-FIM-CLI        PIC X VALUE "N".
       01 WS-FIM-TRX        PIC X VALUE "N".
       01 WS-ACHOU          PIC X VALUE "N".
       01 WS-I              PIC 9(03) VALUE ZERO.
       01 WS-QTD-CLI        PIC 9(03) VALUE ZERO.

       01 WS-TOTAL-LIDOS    PIC 9(05) VALUE ZERO.
       01 WS-TOTAL-OK       PIC 9(05) VALUE ZERO.
       01 WS-TOTAL-ERRO     PIC 9(05) VALUE ZERO.

       01 TAB-CLIENTES.
           05 TB-CLIENTE OCCURS 100 TIMES.
              10 TB-ID       PIC 9(05).
              10 TB-NOME     PIC X(30).
              10 TB-SALDO    PIC 9(09).

       PROCEDURE DIVISION.

       INICIO.
           OPEN INPUT ARQ-CLIENTES
           OPEN INPUT ARQ-TRANS
           OPEN OUTPUT ARQ-SAIDA
           OPEN OUTPUT ARQ-ERROS

           PERFORM CARREGAR-CLIENTES
           PERFORM PROCESSAR-TRANSACOES
           PERFORM EXIBIR-RESUMO

           CLOSE ARQ-CLIENTES
           CLOSE ARQ-TRANS
           CLOSE ARQ-SAIDA
           CLOSE ARQ-ERROS

           STOP RUN.

       CARREGAR-CLIENTES.
           PERFORM UNTIL WS-FIM-CLI = "S"
               READ ARQ-CLIENTES
                   AT END
                       MOVE "S" TO WS-FIM-CLI
                   NOT AT END
                       ADD 1 TO WS-QTD-CLI
                       MOVE CLI-ID    TO TB-ID(WS-QTD-CLI)
                       MOVE CLI-NOME  TO TB-NOME(WS-QTD-CLI)
                       MOVE CLI-SALDO TO TB-SALDO(WS-QTD-CLI)
               END-READ
           END-PERFORM.

       PROCESSAR-TRANSACOES.
           PERFORM UNTIL WS-FIM-TRX = "S"
               READ ARQ-TRANS
                   AT END
                       MOVE "S" TO WS-FIM-TRX
                   NOT AT END
                       ADD 1 TO WS-TOTAL-LIDOS
                       PERFORM LOCALIZAR-CLIENTE
                       PERFORM VALIDAR-E-PROCESSAR
               END-READ
           END-PERFORM.

       LOCALIZAR-CLIENTE.
           MOVE "N" TO WS-ACHOU
           PERFORM VARYING WS-I FROM 1 BY 1
               UNTIL WS-I > WS-QTD-CLI OR WS-ACHOU = "S"
               IF TB-ID(WS-I) = TRX-CLI-ID
                   MOVE "S" TO WS-ACHOU
               END-IF
           END-PERFORM.

       VALIDAR-E-PROCESSAR.
           IF WS-ACHOU = "N"
               ADD 1 TO WS-TOTAL-ERRO
               STRING "ERRO - CLIENTE INEXISTENTE - CLI_ID: "
                      TRX-CLI-ID
                      DELIMITED BY SIZE INTO REG-ERRO
               WRITE REG-ERRO
           ELSE
               IF TRX-TIPO NOT = "C" AND TRX-TIPO NOT = "D"
                   ADD 1 TO WS-TOTAL-ERRO
                   STRING "ERRO - TIPO INVALIDO - CLI_ID: "
                          TRX-CLI-ID
                          DELIMITED BY SIZE INTO REG-ERRO
                   WRITE REG-ERRO
               ELSE
                   IF TRX-VALOR = ZERO
                       ADD 1 TO WS-TOTAL-ERRO
                       STRING "ERRO - VALOR ZERADO - CLI_ID: "
                              TRX-CLI-ID
                              DELIMITED BY SIZE INTO REG-ERRO
                       WRITE REG-ERRO
                   ELSE
                       IF TRX-TIPO = "D"
                           ADD TRX-VALOR TO TB-SALDO(WS-I)
                           ADD 1 TO WS-TOTAL-OK
                           STRING "OK - DEPOSITO - CLI_ID: "
                                  TRX-CLI-ID
                                  " VALOR: "
                                  TRX-VALOR
                                  DELIMITED BY SIZE INTO REG-SAIDA
                           WRITE REG-SAIDA
                       ELSE
                           IF TB-SALDO(WS-I) >= TRX-VALOR
                               SUBTRACT TRX-VALOR FROM TB-SALDO(WS-I)
                               ADD 1 TO WS-TOTAL-OK
                               STRING "OK - SAQUE - CLI_ID: "
                                      TRX-CLI-ID
                                      " VALOR: "
                                      TRX-VALOR
                                      DELIMITED BY SIZE INTO REG-SAIDA
                               WRITE REG-SAIDA
                           ELSE
                               ADD 1 TO WS-TOTAL-ERRO
                               MOVE SPACES TO REG-ERRO
                               STRING "ERRO - SALDO INSUFICIENTE - ID: "
                                      DELIMITED BY SIZE
                                      TRX-CLI-ID
                                      DELIMITED BY SIZE
                                      INTO REG-ERRO
                               WRITE REG-ERRO
                           END-IF
                       END-IF
                   END-IF
               END-IF
           END-IF.

       EXIBIR-RESUMO.
           DISPLAY "PROCESSAMENTO FINALIZADO."
           DISPLAY "TOTAL TRANSACOES LIDAS......: " WS-TOTAL-LIDOS
           DISPLAY "TOTAL PROCESSADAS COM SUCESSO: " WS-TOTAL-OK
           DISPLAY "TOTAL COM ERRO..............: " WS-TOTAL-ERRO.
