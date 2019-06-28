BEGIN
    ## carregar na RAM 
    LDI, R0,  10;
    STO, R0, END CAFÉ;
    STO, R0, END AÇUCAR;
    STO, R0, END LEITE;
    STO, R0, END CHOCOLATE;

    ## VERIFICA  O  NV DE INGREDIENTES
    LD, R0, END CAFÉ;
    JZ, R0, END REPOSIÇAO; 
    LD, R0, END AÇUCAR;
    JZ, R0, END REPOSIÇAO; 
    LD, R0, END LEITE;
    JZ, R0, END REPOSIÇAO; 
    LD, R0, END CHOCOLATE;
    JZ, R0, END REPOSIÇAO; 

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

    ## SELECIONAR CAFÉ
    CALL, hotwheels;

END;

hotwheels
    IN, R0, END preparo tipo
    
RET;