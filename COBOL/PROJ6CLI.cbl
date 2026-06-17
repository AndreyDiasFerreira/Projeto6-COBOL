       IDENTIFICATION DIVISION.
       PROGRAM-ID. PROJ6CLI.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT ARQ-CLIENTES ASSIGN TO "C:\COBOL\CLIENTES.TXT"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD ARQ-CLIENTES.
       01 REG-CLIENTE.
           05 CLI-ID        PIC 9(05).
           05 CLI-NOME      PIC X(30).
           05 CLI-SALDO     PIC 9(09).

       WORKING-STORAGE SECTION.
       01 WS-FIM            PIC X VALUE "N".
       01 WS-TOTAL-LIDOS    PIC 9(05) VALUE ZERO.

       PROCEDURE DIVISION.

       INICIO.
           OPEN INPUT ARQ-CLIENTES

           PERFORM UNTIL WS-FIM = "S"
               READ ARQ-CLIENTES
                   AT END
                       MOVE "S" TO WS-FIM
                   NOT AT END
                       ADD 1 TO WS-TOTAL-LIDOS
                       DISPLAY "CLIENTE: " CLI-ID
                       DISPLAY "NOME...: " CLI-NOME
                       DISPLAY "SALDO..: " CLI-SALDO
                       DISPLAY "-----------------------------"
               END-READ
           END-PERFORM

           CLOSE ARQ-CLIENTES

           DISPLAY "TOTAL DE CLIENTES LIDOS: " WS-TOTAL-LIDOS

           STOP RUN.
