.PROG
    SETR, INT, 0; 
    SETR, INT, 1;
BEGIN
    LDI, R0,  10;
    STO, R0, 0; 
    STO, R0, 1; 
    STO, R0, 2; 
    STO, R0, 3; 
    
    LDI, R0, 5;      
    STO, R0,  10;      
   

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
    OUT, R0, 2;  
    LDI, R1, 0;
    OUT, R1, 3; 
    IN, R0, 1;
    JZ, R0, END LINHA ANTERIOR;
    LDI, R1, 1;
    OUT, R1, 3; 
    JI, VERIFICAR INGREDIENTES;

    CALL, REPOSICAO;
    JI, VERIFICAR INGREDIENTES;

NOP;
END

EMPTY
    IN, R0, 
RET;

TIPOCAFE
    IN, R0, 2;
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

.INT0
    IN, R1, END Nivel água; 
    JZ, R1,  
RETI;


.INT1
    IN, R1, END Nivel água; 
    JZ, R1,  
RETI;


REPOSICAO
    LDI, R1, 1;
    OUT, R1, 4;
    IN, R1, endereço repo;
    JZ, R1, LINHA  DE CIMA;
    LDI, R1, 0;
    OUT, R1, 4;
RET;

