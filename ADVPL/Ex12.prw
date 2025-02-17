//Bibliotecas
#Include 'Protheus.ch'
#Include 'FWMVCDef.ch'
 
//Vari�veis Est�ticas
Static cTitulo := "SA1"

/*
LINKS PARA EX: https://tdn.totvs.com/display/public/framework/Exemplos+MVC // https://www.youtube.com/watch?v=56nn-mJUme4
*/
 
/*
ModelDef: Contem a constru��o e a defini��o do Model, lembrando que o Modelo de dados (Model) cont�m as regras de neg�cio;

ViewDef: Contem a constru��o e defini��o da View, ou seja, ser� a constru��o da interface;

MenuDef: Contem a defini��o das opera��es dispon�veis para o modelo de dados (Model).
*/
 
User Function teste()
    Local aArea   := GetArea()
    Local oBrowse
    Local cFunBkp := FunName()
     
    SetFunName("teste")
     
    //Inst�nciando FWMBrowse - Somente com dicion�rio de dados
    oBrowse := FWMBrowse():New()
     
    //Setando a tabela de cadastro de Autor/Interprete
    oBrowse:SetAlias("SA1")
 
    //Setando a descri��o da rotina
    oBrowse:SetDescription(cTitulo)
     
    //Legendas
    oBrowse:AddLegend( "SA1->A1_COD <= '000005'", "GREEN",    "Menor ou igual a 5" )
    oBrowse:AddLegend( "SA1->A1_COD >  '000005'", "RED",    "Maior que 5" )
     
    //Filtrando
    //oBrowse:SetFilterDefault("SA1->A1_COD >= '000000' .And. SA1->A1_COD <= 'ZZZZZZ'")
     
    //Ativa a Browse
    oBrowse:Activate()
     
    SetFunName(cFunBkp)
    RestArea(aArea)
Return Nil
 
/*---------------------------------------------------------------------*
 | Func:  MenuDef                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  31/07/2016                                                   |
 | Desc:  Cria��o do menu MVC                                          |
 *---------------------------------------------------------------------*/
 
Static Function MenuDef()
    Local aRot := {}
     
    //Adicionando op��es
    ADD OPTION aRot TITLE 'Visualizar' ACTION 'VIEWDEF.teste' OPERATION MODEL_OPERATION_VIEW   ACCESS 0 //OPERATION 1
    ADD OPTION aRot TITLE 'Legenda'    ACTION 'u_zMod1Leg'      OPERATION 6                      ACCESS 0 //OPERATION X
    ADD OPTION aRot TITLE 'Incluir'    ACTION 'VIEWDEF.teste' OPERATION MODEL_OPERATION_INSERT ACCESS 0 //OPERATION 3
    ADD OPTION aRot TITLE 'Alterar'    ACTION 'VIEWDEF.teste' OPERATION MODEL_OPERATION_UPDATE ACCESS 0 //OPERATION 4
    ADD OPTION aRot TITLE 'Excluir'    ACTION 'VIEWDEF.teste' OPERATION MODEL_OPERATION_DELETE ACCESS 0 //OPERATION 5
 
Return aRot
 
/*---------------------------------------------------------------------*
 | Func:  ModelDef                                                     |
 | Autor: Daniel Atilio                                                |
 | Data:  31/07/2016                                                   |
 | Desc:  Cria��o do modelo de dados MVC                               |
 *---------------------------------------------------------------------*/
 
Static Function ModelDef()
    //Cria��o do objeto do modelo de dados
    Local oModel := Nil
     
    //Cria��o da estrutura de dados utilizada na interface
    Local oStSA1 := FWFormStruct(1, "SA1")
     
    //Editando caracter�sticas do dicion�rio
    oStSA1:SetProperty('A1_COD',   MODEL_FIELD_WHEN,    FwBuildFeature(STRUCT_FEATURE_WHEN,    '.F.'))                                 //Modo de Edi��o
    oStSA1:SetProperty('A1_COD',   MODEL_FIELD_INIT,    FwBuildFeature(STRUCT_FEATURE_INIPAD,  'GetSXENum("SA1", "A1_COD")'))         //Ini Padr�o
    oStSA1:SetProperty('A1_NOME',  MODEL_FIELD_VALID,   FwBuildFeature(STRUCT_FEATURE_VALID,   'Iif(Empty(M->A1_NOME), .F., .T.)'))   //Valida��o de Campo
    oStSA1:SetProperty('A1_NOME',  MODEL_FIELD_OBRIGAT, Iif(RetCodUsr()!='000000', .T., .F.) )                                         //Campo Obrigat�rio
     
    //Instanciando o modelo, n�o � recomendado colocar nome da user function (por causa do u_), respeitando 10 caracteres
    oModel := MPFormModel():New("testeM",/*bPre*/, /*bPos*/,/*bCommit*/,/*bCancel*/) 
     
    //Atribuindo formul�rios para o modelo
    oModel:AddFields("FORMSA1",/*cOwner*/,oStSA1)
     
    //Setando a chave prim�ria da rotina
    oModel:SetPrimaryKey({'SA1_FILIAL','A1_COD'})
     
    //Adicionando descri��o ao modelo
    oModel:SetDescription("Modelo de Dados do Cadastro "+cTitulo)
     
    //Setando a descri��o do formul�rio
    oModel:GetModel("FORMSA1"):SetDescription("Formul�rio do Cadastro "+cTitulo)
Return oModel
 
/*---------------------------------------------------------------------*
 | Func:  ViewDef                                                      |
 | Autor: Daniel Atilio                                                |
 | Data:  31/07/2016                                                   |
 | Desc:  Cria��o da vis�o MVC                                         |
 *---------------------------------------------------------------------*/
 
Static Function ViewDef()
    Local aStruSA1    := SA1->(DbStruct())
     
    //Cria��o do objeto do modelo de dados da Interface do Cadastro de Autor/Interprete
    Local oModel := FWLoadModel("teste")
     
    //Cria��o da estrutura de dados utilizada na interface do cadastro de Autor
    Local oStSA1 := FWFormStruct(2, "SA1")  //pode se usar um terceiro par�metro para filtrar os campos exibidos { |cCampo| cCampo $ 'SSA1_NOME|SSA1_DTAFAL|'}
     
    //Criando oView como nulo
    Local oView := Nil
 
    //Criando a view que ser� o retorno da fun��o e setando o modelo da rotina
    oView := FWFormView():New()
    oView:SetModel(oModel)
     
    //Atribuindo formul�rios para interface
    oView:AddField("VIEW_SA1", oStSA1, "FORMSA1")
     
    //Criando um container com nome tela com 100%
    oView:CreateHorizontalBox("TELA",100)
     
    //Colocando t�tulo do formul�rio
    oView:EnableTitleView('VIEW_SA1', 'Dados - '+cTitulo )  
     
    //For�a o fechamento da janela na confirma��o
    oView:SetCloseOnOk({||.T.})
     
    //O formul�rio da interface ser� colocado dentro do container
    oView:SetOwnerView("VIEW_SA1","TELA")

    oView:CreateHorizontalBox( 'TELA' , 100 )
     
    /*
    //Tratativa para remover campos da visualiza��o
    For nAtual := 1 To Len(aStruSA1)
        cCampoAux := Alltrim(aStruSA1[nAtual][01])
         
        //Se o campo atual n�o estiver nos que forem considerados
        If Alltrim(cCampoAux) $ "A1_COD;"
            oStSA1:RemoveField(cCampoAux)
        EndIf
    Next
    */
Return oView
 
/*/{Protheus.doc} zMod1Leg
Fun��o para mostrar a legenda
@author Atilio
@since 31/07/2016
@version 1.0
    @example
    u_zMod1Leg()
/*/
 
User Function zMod1Leg()
    Local aLegenda := {}
     
    //Monta as cores
    AADD(aLegenda,{"BR_VERDE",        "Menor ou igual a 5"  })
    AADD(aLegenda,{"BR_VERMELHO",    "Maior que 5"})
     
    BrwLegenda(cTitulo, "Status", aLegenda)
Return
