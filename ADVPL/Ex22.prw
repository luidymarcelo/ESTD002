#INCLUDE "PROTHEUS.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "FONT.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TBICONN.CH"
#include "fileio.ch"

USER FUNCTION LogSerasa(nCgc)

    local cQuery := ""
    local aDados := {}
    local oBrowse := nil
    Local aRet    := {}
    Local aRet1   := {}
    Local nRegAtu := 0
    Local x       := 0
    Local _cAlias := GetNextAlias()

    DEFINE DIALOG oDlg TITLE "Log do Cliente Serasa" FROM 180, 180 TO 550, 700 PIXEL           
    
    cQuery := "SELECT ZS_STATUS, ZS_DESCRI, ZS_END, ZS_DATE "
    cQuery += " FROM  "+RetSQLName("SZS")+" SZS "
    cQuery += " WHERE  SZS.D_E_L_E_T_  = ' ' and SZS.ZS_CGC = '"+nCgc+"' ORDER BY SZS.R_E_C_N_O_ "

    cQuery := ChangeQuery(cQuery)

	dbUseArea(.T.,"TOPCONN",TCGenQry(,,cQuery),_cAlias,.T.,.T.)

	(_cAlias)->(dbgotop())

	aRet1   := Array(Fcount())
	nRegAtu := 1

	While !(_cAlias)->(Eof())

		For x:=1 To Fcount()
			aRet1[x] := FieldGet(x)
		Next
		Aadd(aRet,aclone(aRet1))

		(_cAlias)->(dbSkip())
		nRegAtu += 1
	Enddo

	If Select(_cAlias) <> 0
		(_cAlias)->(dbCloseArea())
	EndIf

	// Cria array com dados
	for x:=1 to len(aRet)
		aAdd( aDados,{aRet[x,1], aRet[x,2], aRet[x,3], aRet[x,4]})
	Next X

	if len(aDados) == 0
		Alert("Sem dados")
		return
	else
		// Cria browse
		oBrowse := MsBrGetDBase():new(0,0,260,150,,,,oDlg,,,,,{ || DoShellExecute(aDados[oBrowse:nAt, 3]) },,,,,,, .F., "", .T.,, .F.,,, )

		// Define vetor para a browse
		oBrowse:setArray( aDados )

		// Cria colunas do browse
		oBrowse:addColumn( TCColumn():new( "Status", { || aDados[oBrowse:nAt, 1] },,,, "LEFT",, .F., .F.,,,, .F. ) )
		oBrowse:addColumn( TCColumn():new( "Retorno", { || aDados[oBrowse:nAt, 2] },,,, "LEFT",, .F., .F.,,,, .F. ) )
		oBrowse:addColumn( TCColumn():new( "Local PDF", { || aDados[oBrowse:nAt, 3] },,,, "LEFT",, .F., .F.,,,, .F. ) )
		oBrowse:addColumn( TCColumn():new( "Data de Consulta", { || aDados[oBrowse:nAt, 4] },,,, "LEFT",, .F., .F.,,,, .F. ) )
		oBrowse:Refresh()

		// Cria Botões com métodos básicos
		TButton():new( 160, 080, "Ok",            oDlg, { || oBrowse:goUp(), oBrowse:setFocus() }, 40, 010,,, .F., .T., .F.,, .F.,,, .F. )

		ACTIVATE DIALOG oDlg CENTERED
	endif

return

/*/{Protheus.doc} DoShellExecute
	Recebe o índice da aDados contendo o caminho do PDF.
	@author    Luidy Marcelo Neres de Oliveira.
	@since     24/03/2025
/*/

STATIC FUNCTION DoShellExecute(cEnd)
    IF File(cEnd)
        ShellExecute("Open", cEnd, "", "", 1)
    ELSE
        ALERT("Arquivo não encontrado: " + cEnd)
    ENDIF
return
