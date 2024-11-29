Local nMes     := Month(Date())
Local cPeriodo := ""
 
DO CASE
    CASE nMes <= 3
        cPeriodo := "Primeiro Trimestre"
    CASE nMes >= 4 .And. nMes <= 6
        cPeriodo := "Segundo Trimestre"
    CASE nMes >= 7 .And. nMes <= 9
        cPeriodo := "Terceiro Trimestre"
    OTHERWISE
        cPeriodo := "Quarto Trimestre"
ENDCASE

Return
