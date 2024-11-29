#Include "TOTVS.ch"

User Function zExe192()
    Local aArea     := FWGetArea()
    Local aTexto    := {}
    Local aBotoes   := {}
    Local nContinua := 0
    Local cTitulo   := "Processamento de Dados"
 
    //Monta o texto que será exibido na tela
    aAdd(aTexto, "Essa é uma rotina para processamento de informações")
    aAdd(aTexto, "--")
    aAdd(aTexto, "A primeira linha do arquivo deve conter o nome dos campos")
    aAdd(aTexto, "ex.: B1_COD;B1_TIPO;B1_DESC;B1_GRUPO;")
    aAdd(aTexto, "")
    aAdd(aTexto, "As demais linhas devem conter o conteúdo que será importado")
    aAdd(aTexto, "ex.: 00001;PA;Banana;G001;")
    aAdd(aTexto, "")
    aAdd(aTexto, "Para prosseguir com o processamento clique no botão Ok")
 
    //Monta os botões que serão exibidos
    aAdd(aBotoes, {1, .T., {|| nContinua := 1, FechaBatch()} })
    aAdd(aBotoes, {2, .T., {|| nContinua := 2, FechaBatch()} })    
    aAdd(aBotoes, {5, .T., {|| Pergunte("XTESTE", .T.)} })
 
    //Abre a tela
    FormBatch(cTitulo, aTexto, aBotoes) 
 
    //Se o usuário clicou no Confirmar
    If nContinua == 1
        //Aqui você aciona a sua função se o usuário clicou no botão confirmar
    EndIf

    /*
    1 Ok

    2 Cancelar

    3 Excluir

    4 Incluir

    5 Param
    */
    FWRestArea(aArea)
Return
