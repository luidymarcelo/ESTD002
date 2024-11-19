#include "protheus.ch"

/*
AxCadastro realiza uma consulta na tabela do banco ou alias como mencionado no programa e cria uma interface para exclusão ou alteração de registros.
*/

User Function teste3()

Local cAlias := "SA2"
Local cTitulo := "Cadastro de Fornecedores"
Local cVldExc := ".T."
Local cVldAlt := ".T."
dbSelectArea(cAlias)
dbSetOrder(1)
AxCadastro(cAlias,cTitulo,cVldExc,cVldAlt)

Return
