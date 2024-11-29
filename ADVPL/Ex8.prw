Local nCnt
Local nSomaPar := 0

For nCnt := 0 To 100 Step 2
nSomaPar += nCnt
Next

Alert( "A soma dos 100 primeiros números pares é: " + ;
       cValToChar(nSomaPar) )
Return
