#include "protheus.ch"

User Function teste()

    Local cAlias := "SA1"
    Private cCadastro := "Cadastro de Clientes"
    Private aRotina := {}

    AADD(aRotina,{"Pesquisar" ,"AxPesqui" ,0,1})
    AADD(aRotina,{"Visualizar" ,"AxVisual" ,0,2})
    AADD(aRotina,{"Incluir" ,"U_Inclui" ,0,3})
    AADD(aRotina,{"Alterar" ,"AxAltera" ,0,4})
    AADD(aRotina,{"Excluir" ,"AxDeleta" ,0,5})

    dbSelectArea(cAlias)
    dbSetOrder(1)
    mBrowse(6,1,22,75,cAlias)
Return Nil


User Function Inclui(cAlias, nReg, nOpc)

Local cTudoOk := "( Alert('OK'),.T.)"
Local nOpcao := 0

    nOpcao := AxInclui(cAlias,nReg,nOpc,,,,cTudoOk)
        If nOpcao == 1
            MsgInfo("Inclusão concluída com sucesso!")
        elseif nOpcao <> 1
            MsgInfo("Inclusão cancelada!")
        Endif
Return Nil
