.PROG
    SETR, INT, 0;
    SETR, INT, 1;

BEGIN
    LDI, R0, 10;
    STO, R0, 0;     #cafe 
    STO, R0, 1;     #acucar
    STO, R0, 2;     #leite
    STO, R0, 3;     #chocolate
    
    LDI, R0, 5;      
    STO, R0,  10;   #guarda valor inicial de timer    

    CALL, CPUSLEEP;
   
   //verifica  suprimentos
    LD, R0, 0;      
    JZ, R0, 25; 
    LD, R0, 1;
    JZ, R0, 25; 
    LD, R0, 2;
    JZ, R0, 25; 
    LD, R0, 3;
    JZ, R0, 25; 
    
    IN, R0, 2; 
    JZ, R0, 7; 
    STO, R0, 11;

    CALL, TIPOCAFE;
   
    LD, R0, 10;
    OUT, R0, 0; #timer  tempo  
    LDI, R1, 0;
    OUT, R1, 1; #display 7 seg U8
    IN, R0, 1;
    JZ, R0, 20; #linha  anterior(espera resposta do timer)
    LDI, R0, 5;
    OUT, R0, 0; #timer tempo
    LDI, R1, 1;
    OUT, R1, 1; #display 7 seg Done 
    IN, R0, 1;
    JZ, R0, 25; #linha  anterior(espera resposta do timer)
    
    JI, 0;#nao sei

    CALL, REPOSICAO;
    JI, 0; #nao  sei

NOP;
END

.INT0
RETI;

.INT1
RETI;

.INT2
RETI;

CPUSLEEP     //fake sleep
    NOP;
    JI, 0; 
RET;

TIPOCAFE
//Verifica Tamanho
    LD, R0, 11;
    LDI, R1, 2;
    AND, R2, R1, R0;
    CMP, R3, R2, R1;7
    JE, R2, 0;    //jump TAMANH
    JI, 0;t
    CALL, TAMANHO;
    //verifica a açucar
    LDI, R1, 1;
    AND, R2, R1, R0;
    CMP, R3, R2, R1;
    JE, R2, 0;    //JUMP AÇUCAR
    JI, 0;
    LDI, R1, 4;   //moca
    AND, R2, R0, R1;
    CMP, R3, R2, R1;
    JE, R2, 0;   //jump moca
    LDI, R1, 8;  // cafe com leite
    AND, R2, R0, R1;
    CMP, R3, R2, R1;
    JE, R2, 0;   // jump caafe com  leite
    LDI, R1, 16;  //cafe preto
    AND, R2, R1, R0;
    CMP, R3, R2, R1;
    JE, R2, 0; //jump cafe preto
    JI,0;
    NOP;
    CALL, MOCHA;
    CALL, CAFELEITE;
    CALL, CAFEPRETO;
    CALL, ACUCAR;
    NOP;
RET;


MOCHA
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

CAFELEITE
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

CAFEPRETO
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

REPOSICAO
    LDI, R1, 1;
    OUT, R1, 4;
    IN, R1, 0;
    JZ, R1, 0;
    LDI, R1, 0;
    OUT, R1, 4;
RET;

