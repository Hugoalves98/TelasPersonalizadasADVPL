#INCLUDE 'PROTHEUS.CH'
/*
----------------------------------------------------------
Tela para aprovar solicitação de autorização de remessa 
Autor: Hugo Rocha da Silva
Data: 08/07/2022
----------------------------------------------------------
*/
User Function aprovar()

local oDlg2
local nAltura := 385
local nLargura:= 454
local cTitulo := "Aprovar - Solicitação de Autorização de Remessa"
local oSay1
local oMGet1
local oBtn1
local oBtn2

DEFINE MSDIALOG oDlg2 TITLE cTitulo FROM 0,0 To nAltura,nLargura PIXEL

oSay1   := TSay():New( 010,010,{||"Observações"},oDlg2,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,208,016)
oMGet1  := TMultiGet():New( 024,010,,oDlg2,208,124,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )
oBtn1   := TButton():New( 165,010,"Aprovar",oDlg2,{||,oDlg2:End()},076,016,,,,.T.,,"",,,,.F. )
oBtn2   := TButton():New( 165,142,"Rejeitar",oDlg2,{||,oDlg2:End()},076,016,,,,.T.,,"",,,,.F. )

ACTIVATE DIALOG oDlg2 CENTER

Return    
