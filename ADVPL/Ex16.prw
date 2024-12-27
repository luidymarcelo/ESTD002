#include "protheus.ch"

User Function VldAlt(cAlias,nReg,nOpc)
    Local lRet := .T.
    Local aArea := GetArea()
    Local nOpcao:= 0

    nOpcao := AxAltera(cAlias,nReg,nOpc)

    If nOpcao == 1
        MsgInfo("Alteração concluída com sucesso!")
    Endif
        RestArea(aArea)
Return lRet


User Function VldExc(cAlias,nReg,nOpc)
    Local lRet := .T.
    Local aArea := GetArea()
    Local nOpcao := 0

    nOpcao := AxExclui(cAlias,nReg,nOpc)
    If nOpcao == 1
        MsgInfo("Exclusão concluída com sucesso!")
    Endif
        RestArea(aArea)
Return lRet