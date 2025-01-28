//Bibliotecas
#Include "TOTVS.ch"
#Include "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#Include 'Tbiconn.ch'
  
//Posições do Array
Static nPosCod := 1 //Coluna A no Excel
Static nPosBitol := 2 //Coluna B no Excel
  
/*/{Protheus.doc} xReadCsv
	Função para importar informações do fornecedor via csv.
	@author    Luidy Marcelo Neres de Oliveira
	@since     30/10/2025
/*/

/*

Este fonte importa dados em CSV para tabela SB1 atualmente o fonte há como foco coletar os dados sem precisar de cabeçalho.

Fonte executa alterações do campo B1_ZBITOLA contendo o indíce do código produto, o mesmo gera log...

*/
  
User Function xReadCsv()
    Local aArea     := GetArea()
    Private cArqOri := ""
  
    //Mostra o Prompt para selecionar arquivos
    cArqOri := tFileDialog( "CSV files (*.csv) ", 'Seleção de Arquivos', , , .F., )
      
    //Se tiver o arquivo de origem
    If ! Empty(cArqOri)
          
        //Somente se existir o arquivo e for com a extensão CSV
        If File(cArqOri) .And. Upper(SubStr(cArqOri, RAt('.', cArqOri) + 1, 3)) == 'CSV'
            Processa({|| fImporta() }, "Importando...")
        Else
            MsgStop("Arquivo e/ou extensão inválida!", "Atenção")
        EndIf
    EndIf

    RestArea(aArea)
Return
  
/*-------------------------------------------------------------------------------*
 | Func:  fImporta                                                               |
 | Desc:  Função que importa os dados                                            |
 *-------------------------------------------------------------------------------*/
  
Static Function fImporta()
    Local aArea      := GetArea()
    Local cArqLog    := "zImpCSV_" + dToS(Date()) + "_" + StrTran(Time(), ':', '-') + ".log"
    Local nTotLinhas := 0
    Local cLinAtu    := ""
    Local nLinhaAtu  := 0
    Local aLinha     := {}
    Local oArquivo
    Local aLinhas
    Local cCodProd   := ""
    Local cBitola   := ""
    Private cDirLog    := GetTempPath() + "x_importacao\"
    Private cLog       := ""

    PREPARE ENVIRONMENT EMPRESA '01' FILIAL '0101' USER 'Administrador' PASSWORD 'tvsita2024' TABLES 'SB1' MODULO "FAT"

    //Se a pasta de log não existir, cria ela
    If ! ExistDir(cDirLog)
        MakeDir(cDirLog)
    EndIf
  
    //Definindo o arquivo a ser lido
    oArquivo := FWFileReader():New(cArqOri)
      
    //Se o arquivo pode ser aberto
    If (oArquivo:Open())
  
        //Se não for fim do arquivo
        If ! (oArquivo:EoF())
  
            //Definindo o tamanho da régua
            aLinhas := oArquivo:GetAllLines()
            nTotLinhas := Len(aLinhas)
            ProcRegua(nTotLinhas)
              
            //Método GoTop não funciona (dependendo da versão da LIB), deve fechar e abrir novamente o arquivo
            oArquivo:Close()
            oArquivo := FWFileReader():New(cArqOri)
            oArquivo:Open()
  
            //Enquanto tiver linhas
            While (oArquivo:HasLine())
  
                //Incrementa na tela a mensagem
                nLinhaAtu++
                IncProc("Analisando linha " + cValToChar(nLinhaAtu) + " de " + cValToChar(nTotLinhas) + "...")
                  
                //Pegando a linha atual e transformando em array
                cLinAtu := oArquivo:GetLine()
                aLinha  := StrTokArr(cLinAtu, ";")
                  
                //Se não for o cabeçalho (encontrar o texto "Código" na linha atual)
                If ! "código" $ Lower(cLinAtu)
  
                    //Zera as variaveis
                    cCodProd   := aLinha[nPosCod]
                    cBitola   := aLinha[nPosBitol]

                    DbSelectArea("SB1")
                    SB1->(DbSetOrder(1)) // Filial + Código

                    //Se conseguir posicionar no fornecedor
                    If SB1->(DbSeek(FWxFilial("SB1") + cCodProd))              
                        cLog += "Linha " + cValToChar(nLinhaAtu) + ", PRODUTO [" + cCodProd + "] BITOLA [ " + cBitola + " ] DESCRIÇÃO - [ " + ALLTRIM(Upper(SB1->B1_DESC)) + " ] " +;
                            "a BITOLA foi alterada, antes: [" + Alltrim(SB1->B1_ZBITOLA) + "], agora: a bitola é " + Alltrim(cBitola) + " " + CRLF

                        //Realiza a alteração do fornecedor
                        RecLock("SB1", .F.)
                            SB1->B1_ZBITOLA  := cBitola
                        SB1->(MsUnlock())
                    Else
                        cLog += "- Lin" + cValToChar(nLinhaAtu) + ", fornecedor e loja [" + cCodProd + cBitola + "] não encontrados no Protheus;" + CRLF
                    EndIf

                Else
                    cLog += "- Lin" + cValToChar(nLinhaAtu) + ", linha não processada - cabeçalho;" + CRLF
                EndIf
                  
            EndDo
  
            //Se tiver log, mostra ele
            If ! Empty(cLog)
                cLog := "Processamento finalizado, abaixo as mensagens de log: " + CRLF + cLog
                MemoWrite(cDirLog + cArqLog, cLog)
                ShellExecute("OPEN", cArqLog, "", cDirLog, 1)
            EndIf
  
        Else
            MsgStop("Arquivo não tem conteúdo!", "Atenção")
        EndIf
  
        //Fecha o arquivo
        oArquivo:Close()
    Else
        MsgStop("Arquivo não pode ser aberto!", "Atenção")
    EndIf
  
    RestArea(aArea)
Return
