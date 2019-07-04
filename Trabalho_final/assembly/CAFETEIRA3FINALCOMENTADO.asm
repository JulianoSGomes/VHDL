.PROG
    SETR, INT, 0; 
    SETR, INT, 1;
BEGIN
    ## carregando os ingredientes
    LDI, R0,  10;
    STO, R0, 0; 
    STO, R0, 1; 
    STO, R0, 2; 
    STO, R0, 3; 
    

    ## INICIALIZANDO  CONTADOR DE TEMOI
    LDI, R0, 5;      
    STO, R0,  10;      
   


   ## verificando ingredientes
    LD, R0, 0;
    JZ, R0, 37; 
    LD, R0, 1;
    JZ, R0, 37; 
    LD, R0, 2;
    JZ, R0, 37; 
    LD, R0, 3;
    JZ, R0, 37; 
    
    CALL, TIPOCAFE;

    LD, R0, 10;
    OUT, R0, 2;  ##envia pro contador
    LDI, R1, 0;
    OUT, R1, 3; ##ENVIA PRO DIPLAY U8
    IN, R0, 1;
    JZ, R0, END LINHA ANTERIOR;
    LDI, R1, 1;
    OUT, R1, 3; ##ENVIA PRO DIPLAY U8
    JI, VERIFICAR INGREDIENTES;

    CALL, pararcafeteira;
    JI, VERIFICAR INGREDIENTES;

NOP;
END

EMPTY
    IN, R0, 
RET;

TIPOCAFE
    IN, R0, 2;
    ## tamanho de cafe
    LDI, R1, 2;
    AND, R2, R1, R0;
    CMP, R3, R2, R1;
    JE, R2, END TAMANHO;
    JI, acucar;
    CALL, TAMANHO
    LDI, R1, 1;
    AND, R2, R1, R0;
    CMP, R3, R2, R1;
    JE, R2, END ACUCAR;
    JI, qualcafe;
    CALL, ADDACUCAR;
    ## qual cafe
    LDI, R1, 4;
    AND, R2, R0, R1;
    CMP, R3, R2, R1
    JE, R2, END MOCHA;
    LDI, R1, 8;
    AND, R2, R0, R1;
    CMP, R3, R2, R1;
    JE, R2, END CAFELEITE;
    LDI, R1, 16;
    AND, R2, R1, R0;
    CMP, R3, R2, R1;
    JE, R2, END CAFEPRETO;
    JI, NOP;
    CALL, MOCA;
    CALL, CAFELEITE;
    CALL, CAFEPRETO;
    CALL, TAMANHO;
    CALL, ACUCAR;
    NOP;
RET;


MOCA
   LDI, R1, 1;
   LD, R0, 0;
   SUB, R2, R1, R0;
   STO, R2, 0;
   LD, R0, 2;
   SUB, R2, R1, R0;
   STO, R2, 2;
   LD, R0, 3;
   SUB, R2, R1, R0;
   STO, R2, 3;
   LD, R0, 10;
   LDI, R1, 3;
   ADD, R2, R0, R1;
   STO, R2, 10;
RET;

CAFELEITE;
    LDI, R1, 1;
    LD, R0, 0;
    SUB, R2, R1, R0;
    STO, R2, 0;
    LD, R0,  2;
    SUB, R2, R1,  R0;
    STO, R2, 2;
    LD, R0, 10;
    LDI, R1, 2;
    ADD,  R2, R1, R0;
    STO,  R2, 10;
RET;

CAFEPRETO;
    LDI, R1, 1;
    LD, R0, 0;
    SUB, R2, R1, R0;
    STO, R2, 0;
    LD, R0, 10;
    ADD,  R2, R1, R0;
    STO,  R2, 10;
RET;

TAMANHO
    LD, R0, 10;
    LDI, R1,  5;
    ADD, R2, R1, R0;
    STO, R2, 10;
RET;

ACUCAR
    LD, R0, 10;
    LDI, R1,  1;
    ADD, R2, R1, R0;
    STO, R2, 10;
RET;

## nível da água
.INT0
    IN, R1, END Nivel água; 
    LDI, R2, 0;
    CMP, R3, R1, R2; 
    JE, R3, END LED AGUA; 
RETI;


.INT1
    LDI, R2, 0;
    CMP, R3, R1, R2; 
    JE, R3, END LED  temp AGUA;
RETI;



pararcafeteira
    NOP;
RET;