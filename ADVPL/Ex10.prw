#INCLUDE "protheus.ch"
#INCLUDE "apwebsrv.ch"

/* ===============================================================================
WSDL Location    http://srverp01:8002/SERVERTIME.apw?WSDL
Gerado em        27/11/24 13:01:25
Observaï¿½ï¿½es      Cï¿½digo-Fonte gerado por ADVPL WSDL Client 1.120703
                 Alteraï¿½ï¿½es neste arquivo podem causar funcionamento incorreto
                 e serï¿½o perdidas caso o cï¿½digo-fonte seja gerado novamente.
=============================================================================== */

User Function _DZRMMHP ; Return  // "dummy" function - Internal Use 

/* -------------------------------------------------------------------------------
WSDL Service WSSERVERTIME
------------------------------------------------------------------------------- */

/*
Este código o IDE gera, informando os includes obrigatórias para o Client do WebService executar. Foi criada uma 
função User Function _DZRMMHP aleatória para esse fonte, cujo nome poderá ser alterado pelo usuário 
posteriormente.
*/

WSCLIENT WSSERVERTIME

	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD RESET
	WSMETHOD CLONE
	WSMETHOD GETSERVERTIME

	WSDATA   _URL                      AS String
	WSDATA   _HEADOUT                  AS Array of String
	WSDATA   _COOKIES                  AS Array of String
	WSDATA   cPARMETRO                 AS string
	WSDATA   cGETSERVERTIMERESULT      AS string

ENDWSCLIENT

WSMETHOD NEW WSCLIENT WSSERVERTIME

/*
Essa parte inicializa a criação do client do WebService. Podemos notar que o nome do cliente do WebService 
SERVERTTIME é parecido com o nome do Client WSSERVERTTIME.
Vejamos que foram criados 4 métodos que não existiam no próprio WebService.
WSMETHOD NEW
WSMETHOD INIT
WSMETHOD RESET
WSMETHOD CLONE
O método criado pelo IDE NEW.
Trata-se de um processo de criação do objeto WebService para repassar todo o conteúdo do WebService gerado para 
uma variável definida pelo usuário. 
*/

::Init()
If !FindFunction("XMLCHILDEX")
	UserException("O Cï¿½digo-Fonte Client atual requer os executï¿½veis do Protheus Build [7.00.210324P-20240718] ou superior. Atualize o Protheus ou gere o Cï¿½digo-Fonte novamente utilizando o Build atual.")
EndIf
Return Self

/*
Pode, analisando o próprio método, chamar outro método gerado pelo IDE INIT. 
Trata-se de um processo de criação do objeto WebService para disponibilizar a criação ou chamada de outros serviços 
disponível no repositório para complementar o WebService do cliente.
*/

WSMETHOD INIT WSCLIENT WSSERVERTIME
Return

WSMETHOD RESET WSCLIENT WSSERVERTIME
	::cPARMETRO          := NIL 
	::cGETSERVERTIMERESULT := NIL 
	::Init()
Return

/*
Analisamos agora o Method RESET. 
Trata-se de um processo de limpeza de variáveis do WebService para que você possa utilizá-lo novamente sem estar 
com as informações executadas anteriormente.
*/

WSMETHOD CLONE WSCLIENT WSSERVERTIME
Local oClone := WSSERVERTIME():New()
	oClone:_URL          := ::_URL 
	oClone:cPARMETRO     := ::cPARMETRO
	oClone:cGETSERVERTIMERESULT := ::cGETSERVERTIMERESULT
Return oClone

/*
Analisaremos agora o método CLONE.
Tratamento de gerar uma nova variável com o Objeto criado do WebService. Duplica a informação dos dados do 
WebService. 
*/

// WSDL Method GETSERVERTIME of Service WSSERVERTIME

WSMETHOD GETSERVERTIME WSSEND cPARMETRO WSRECEIVE cGETSERVERTIMERESULT WSCLIENT WSSERVERTIME
Local cSoap := "" , oXmlRet

/*
Analisaremos agora o método GETSERVERTTIME. 
Tratamento de executar o service disponível pelo WebService e retornar o processo executado por ele, retornando na 
variável cGETSERVERTTIMERESULT.
*/

BEGIN WSMETHOD

cSoap += '<GETSERVERTIME xmlns="http://srverp01:8002/">'
cSoap += WSSoapValue("PARMETRO", ::cPARMETRO, cPARMETRO , "string", .T. , .F., 0 , NIL, .F.,.F.) 
cSoap += "</GETSERVERTIME>"

oXmlRet := SvcSoapCall(Self,cSoap,; 
	"http://srverp01:8002/GETSERVERTIME",; 
	"DOCUMENT","http://srverp01:8002/",,"1.031217",; 
	"http://srverp01:8002/SERVERTIME.apw")

::Init()
::cGETSERVERTIMERESULT :=  WSAdvValue( oXmlRet,"_GETSERVERTIMERESPONSE:_GETSERVERTIMERESULT:TEXT","string",NIL,NIL,NIL,NIL,NIL,NIL) 

END WSMETHOD

oXmlRet := NIL
Return .T.

/*
O código fonte utiliza uma função chamada WSSoapValue. Esta função executa toda a estrutura do XML para dentro 
do WebService, criando as suas respectivas tags que o método solicitado exige. 
Logo abaixo é apresentada outra função: WSADVVALUE, que retorna o valor que o WebService está disponibilizando.
Devemos compilar o código fonte gerado pelo DevStudio e podemos fazer tratamentos de notificações no Método com 
a função SetSoapFault.
*/
