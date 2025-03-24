#include 'protheus.ch'  // Inclusão da biblioteca Protheus

user function TcBrowse_EX()
   // Definindo variáveis
   Local oOK := LoadBitmap(GetResources(),'br_verde')   // Ícone verde
   Local oNO := LoadBitmap(GetResources(),'br_vermelho') // Ícone vermelho
   Local aList := {} // Vetor com elementos do Browse
   Local nX

   // Criação de dados de exemplo para o vetor aList
   for nX := 1 to 100
      aListAux := {.T., strzero(nX,10), 'Descrição do Produto ' + strzero(nX,3), 1000.22 + nX}
      aadd(aList, aListAux)  // Adiciona o elemento ao vetor
   next

   // Criação da janela de diálogo (MSDialog)
   DEFINE MSDIALOG oDlg FROM 0,0 TO 520,600 PIXEL TITLE 'Exemplo da TCBrowse'

   // Definindo fonte para o Browse
   Define Font oFont Name 'Courier New' Size 0, -12

   // Criação do objeto Browse (TCBrowse)
   oList := TCBrowse():New( 01 , 01, 300, 200,,'','Codigo','Descrição','Valor',{20,50,50,50},oDlg,,,,,{||},,oFont,,,,,.F.,,.T.,,.F.,,, )

   // Seta o vetor de dados a ser utilizado no Browse
   oList:SetArray(aList)

   // Monta a linha a ser exibida no Browse (condição de exibição dos ícones)
   oList:bLine := {|| 
      { 
         If(aList[oList:nAt,01], oOK, oNO), ;  // Ícone verde ou vermelho
         aList[oList:nAt,02],   // Código
         aList[oList:nAt,03],   // Descrição
         Transform(aList[oList:nAT,04], '@E 99,999,999,999.99')  // Valor formatado
      } 
   }

   // Evento de DuploClique (Troca o valor do primeiro elemento do vetor)
   oList:bLDblClick := {|| 
      aList[oList:nAt][1] := !aList[oList:nAt][1],  // Altera o valor booleano do primeiro elemento
      oList:DrawSelect()  // Redesenha a seleção
   }

   // Criação dos botões para navegar no Browse
   oBtn := TButton():New( 210, 001, 'GoUp()', oDlg, {|| oList:GoUp() }, 40, 010,,,.F.,.T.,.F.,,.F.,,,.F. )
   oBtn := TButton():New( 220, 001, 'GoDown()', oDlg, {|| oList:GoDown() }, 40, 010,,,.F.,.T.,.F.,,.F.,,,.F. )
   oBtn := TButton():New( 230, 001, 'GoTop()', oDlg, {|| oList:GoTop() }, 40, 010,,,.F.,.T.,.F.,,.F.,,,.F. )
   oBtn := TButton():New( 240, 001, 'GoBottom()', oDlg, {|| oList:GoBottom() }, 40, 010,,,.F.,.T.,.F.,,.F.,,,.F. )

   // Criação dos botões de alerta para exibir informações do Browse
   oBtn := TButton():New( 210, 060, 'nAt (Linha selecionada)', oDlg, {|| Alert(oList:nAt) }, 90, 010,,,.F.,.T.,.F.,,.F.,,,.F. )
   oBtn := TButton():New( 220, 060, 'nRowCount (Nr de linhas visíveis)', oDlg, {|| Alert(oList:nRowCount()) }, 90, 010,,,.F.,.T.,.F.,,.F.,,,.F. )
   oBtn := TButton():New( 230, 060, 'nLen (Número total de linhas)', oDlg, {|| Alert(oList:nLen) }, 90, 010,,,.F.,.T.,.F.,,.F.,,,.F. )
   oBtn := TButton():New( 240, 060, 'lEditCell (Edita a célula)', oDlg, {|| lEditCell(@aList, oList, '@!', 3) }, 90, 010,,,.F.,.T.,.F.,,.F.,,,.F. )

   // Ativa a janela de diálogo no centro da tela
   ACTIVATE MSDIALOG oDlg CENTERED

return
