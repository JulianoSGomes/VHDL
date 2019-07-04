.PROG
    SETR, INT, 0; ##instancia interrupçoes

BEGIN
    ## carregar na RAM 
    LDI, R0,  10;
    STO, R0, 0; ##CAFE
    STO, R0, 1; ##ACUCAR
    STO, R0, 2; ##LEITE
    STO, R0, 3; ##CHOCOLATE
    
    ## Carrgar combinações de cafe tabela...
    
    LDI, R0, 4;      
    STO, R0,  10;
    LDI, R0, 5;      
    STO, R0,  11;
    LDI, R0, 6;
    STO, R0,  12;
    LDI, R0, 7;
    STO, R0,  13;
    LDI, R0, 8;
    STO, R0,  14;
    LDI, R0, 9;
    STO, R0,  15;
    LDI, R0, 10;
    STO, R0,  16;
    LDI, R0, 11;
    STO, R0,  17;
    LDI, R0, 16;
    STO, R0,  18;
    LDI, R0, 17;
    STO, R0,  19;
    LDI, R0, 18;
    STO, R0,  20;
    LDI, R0, 19;
    STO, R0,  21;
   


    ## VERIFICA  O  NV DE INGREDIENTES
    LD, R0, 0;
    JZ, R0, 37; 
    LD, R0, 1;
    JZ, R0, 37; 
    LD, R0, 2;
    JZ, R0, 37; 
    LD, R0, 3;
    JZ, R0, 37; 

    CALL, parar_cafeteira;

    ## VERIFICA O NV DE  AGUA
    IN, R1, END Nivel água; ## entrada do processador
    LDI, R2, 0;
    CMP, R3, R1, R2; 
    JE, R3, END LED AGUA; ## endereço ROM 
    
    ## VERIFICA A TMP DE  AGUA
    IN, R1, END temp água;
    LDI, R2, 0;
    CMP, R3, R1, R2; 
    JE, R3, END LED  temp AGUA;

    ## SELECIONAR CAFE
    CALL, tipo_cafe;

    END;

empty
    IN, R0, 
RET;

tipo_cafe
    IN, R0, END preparo tipo
RET;


.INT0
## NAO USAR CALL no  int
##Jump apenas para endereço de  interrupçao relacionado


    IN, R3, 10;
    JI,  515
RETI;

parar_cafeteira
    NOP;
RET;