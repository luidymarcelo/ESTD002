LOCAL nPos := 0
LOCAL nReserva := 0
LOCAL nSoma := 0

SC6->(dbSetOrder(1))
SC6->(dbSeek(xFilial('SA2') + cFornec + cLoja + cProduto))

WHILE SC6->(FOUND()) .AND. SC6->C6_FILIAL == xFilial(“SC6”) .AND. SC6->C6_CLI == cFornec .AND. SC6->C6_LOJA == cLoja .AND. SC6->C6_COD == cProduto
    WHILE nPos < LEN(aAlmox) .AND. nReserva < nSacas
        nPos++
        nSoma := nReserva + aAlmox[nPos]
        IF nSoma <= nSacas
            nReserva := nSoma
        ELSE
            nReserva := nSacas
        ENDIF
    ENDDO
    SC6->(dbSkip())
ENDDO

RETURN nReserva
