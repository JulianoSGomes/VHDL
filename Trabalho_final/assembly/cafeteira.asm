.PROG
    SETR, INT, 0;
    SETR, INT, 1;

BEGIN

    LDI, R0, 10;
    STO, R0, 0;     
    STO, R0, 1;     
    STO, R0, 2;     
    STO, R0, 3;     
    
    LDI, R0, 5;      
    STO, R0,  10;   

   
   
    LD, R0, 0;      
    JZ, R0, 34; 
    LD, R0, 1;
    JZ, R0, 34; 
    LD, R0, 2;
    JZ, R0, 34; 
    LD, R0, 3;
    JZ, R0, 34; 
    
    IN, R0, 2; 
    JZ, R0, 17; 
    STO, R0, 11;

    CALL, TIPOCAFE;
   
    LD, R0, 10;
    OUT, R0, 0; 

    LDI, R1, 0;
    OUT, R1, 1; 

    IN, R0, 3;
    JZ, R0, 20; 

    LDI, R0, 5;
    OUT, R0, 0; 

    LDI, R1, 1;
    OUT, R1, 1; 

    IN, R0, 3;
    JZ, R0, 25; 
    
    JI, 0;

    CALL, REPOSICAO;
    JI, 0; 

NOP;
END

.INT0
    IN, R0, 4;
    JZ, R0, 0;
RETI;

.INT1
    IN, R0, 5;
    JZ, R0, 0;
RETI;



CPUSLEEP     
    NOP;
    JI, 0; 
RET;

TIPOCAFE

    LD, R0, 11;
    LDI, R1, 2;
    AND, R2, R1, R0;
    CMP, R3, R2, R1;
    JE, R2, 6;    
    JI, 7;
    CALL, TAMANHO;
    
    LDI, R1, 1;
    AND, R2, R1, R0;
    CMP, R3, R2, R1;
    JE, R2, 29   

    LDI, R1, 4;   
    AND, R2, R0, R1;
    CMP, R3, R2, R1;
    JE, R2, 23;   

    LDI, R1, 8;  
    AND, R2, R0, R1;
    CMP, R3, R2, R1;
    JE, R2, 25;

    LDI, R1, 16;  
    AND, R2, R1, R0;
    CMP, R3, R2, R1;
    JE, R2, 27; 

    CALL, MOCHA; 
    JI, 31;
    CALL, CAFELEITE;
    JI, 31;
    CALL, CAFEPRETO;
    JI, 31;
    CALL, ACUCAR;
    JI, 11;
RET;


MOCHA
   LDI, R1, 1;
   LD, R0, 0;
   SUB, R2, R0, R1;
   STO, R2, 0;
   LD, R0, 2;
   SUB, R2, R0, R1;
   STO, R2, 2;
   LD, R0, 3;
   SUB, R2, R0, R1;
   STO, R2, 3;
   LD, R0, 10;
   LDI, R1, 3;
   ADD, R2, R0, R1;
   STO, R2, 10;
RET;

CAFELEITE
    LDI, R1, 1;
    LD, R0, 0;
    SUB, R2, R0, R1;
    STO, R2, 0;
    LD, R0,  2;
    SUB, R2, R0,  R1;
    STO, R2, 2;
    LD, R0, 10;
    LDI, R1, 2;
    ADD,  R2, R1, R0;
    STO,  R2, 10;
RET;

CAFEPRETO
    LDI, R1, 1;
    LD, R0, 0;
    SUB, R2, R0, R1;
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
    LD,  R0, 1;
    SUB, R2,  R0, R1;
    STO, R2,  1;
RET;

REPOSICAO
    LDI, R1, 1;
    OUT, R1, 4;  
    IN, R1, 0;
    JZ, R1, 0;
    LDI, R1, 0;
    OUT, R1, 4;
RET;
