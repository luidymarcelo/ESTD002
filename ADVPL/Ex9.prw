#include "Protheus.ch"
#include "ApWebSRV.ch"
#include "TbiConn.ch"

WSSERVICE SERVERTIME Description "VEJA O HORARIO"

WSDATA Horário AS String
WSDATA Parâmetro AS String
//String Dado AdvPL do tipo string.
//Date Dado AdvPL do tipo data.
//Integer Dado AdvPL do tipo numérico (apenas números inteiros).
//Float Dado AdvPL do tipo numérico (pode conter números inteiros
//e não-inteiros).
//Boolean Dado AdvPL do tipo booleano (lógico).
//Base64Binary Dado AdvPL do tipo string binária, aceitando todos //os caracteres da tabela ASCII, de CHAR(0) A CHR(255)
WSMETHOD GetServerTime Description "METHOD DE VISUALIZAÇÃO DO HORARIO"
ENDWSSERVICE
WSMETHOD GetServerTime WSRECEIVE Parâmetro WSSEND Horário WSSERVICE SERVERTIME
::Horário:= TIME()
Return .T.
