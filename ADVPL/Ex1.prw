#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"

/*
Fonte simples onde cria janela de interface visual em linguagem
*/

User Function teste()

/* ADVPL */

DEFINE      MSDIALOG og TITLE   "Janela em sintaxe ADVPL" FROM 000,000 TO 400,600 PIXEL
ACTIVATE    MSDIALOG og CENTERED
Local oDlgConf := TDialog():New(180,180,015,650,'Confirmação de acesso',,,,,CLR_BLACK,CLR_WHITE,,,.T.)
/* CLIPPER */

@ 0,0 TO 400,600 DIALOG oDlg TITLE "Janela em sintaxe Clipper" 
ACTIVATE DIALOG oDlg CENTERED

Return
