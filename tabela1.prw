#include "protheus.ch"

User Function tabgt() //Nome da funçao

Local aTitulo := "Consulta de saldo"
Local aaCampos  	:= {"CODIGO"} //Variável contendo o campo editável no Grid
Local aBotoes	:= {}         //Variável onde será incluido o botão para a legenda   
Local cGet1 := Space(4) //  ANO
Local cGet5 := Space(2) //  MES
Local cGet3 := Space(40)  // Centro de custo
Local nGet1 := Space(40) // Iniciativa
Local nGet2 := 0 // Valor Plane
Local nGet3 := 0 // Saldo iniciativa
Local lHasButton := .T.
local oPanel
Local oSay1
Local oSay2
Local oSay3
Local oSay4
Local oSay5
Local oSay6
Local oSay7
local oGet1
local oGet3
local oGet5
local oGet6
local oGet7
Local aItemsLt := {"Dólar", "Euro"}
Local nCombo01, oCBox1
Local aItemsLista := {"Tipo1", "Tipo2"}
Local nCombo02, oCBox2
Private oLista                    //Declarando o objeto do browser
Private aCabecalho  := {}         //Variavel que montará o aHeader do grid
Private aColsEx 	:= {}         //Variável que receberá os dados
Private aSize  := {}
Private aInfo  := {}
Private aObj   := {}
Private aPObj  := {}

// Será utilizado três áreas na janela
// 1ª - Enchoice, sendo 80 pontos pixel
// 2ª - MsGetDados, o que sobrar em pontos pixel é para este objeto
// 3ª - Rodapé que é a própria janela, sendo 15 pontos pixel
AADD( aObj, { 100, 080, .T., .F. })
AADD( aObj, { 100, 100, .T., .T. })
AADD( aObj, { 100, 015, .T., .F. })
// Retorna a área útil das janelas Protheus
aSize := MsAdvSize()
// Cálculo automático da dimensões dos objetos (altura/largura) em pixel
aInfo := { aSize[1], aSize[2], aSize[3], aSize[4], 3, 3 }
aPObj := MsObjSize( aInfo, aObj )

DEFINE MSDIALOG oDlg TITLE aTitulo FROM aSize[7],aSize[1] TO aSize[6],aSize[5] OF oMainWnd PIXEL

oTFont := TFont():New('Courier new',,16,.T.)
oPanel := tPanel():New(025,00,"",oDlg,oTFont,.T.,,CLR_WHITE,CLR_WHITE,400,200)
oSay1 := TSay():New( 010, 10,{||'Ano'},oPanel,,oTFont,,,,.T.,CLR_BLACK,CLR_GRAY,200,20)   
oGet1 := TGet():New( 010, 75, { | u | If( PCount() == 0, cGet1, cGet1 := u ) },oPanel, 060, 010, "!@",, 0, 16777215,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F. ,,"cGet1",,,,lHasButton)           
oSay1 := TSay():New( 025, 10,{||'Mês'},oPanel,,oTFont,,,,.T.,CLR_BLACK,CLR_GRAY,200,20)   
oGet1 := TGet():New( 025, 75, { | u | If( PCount() == 0, cGet5, cGet5 := u ) },oPanel, 060, 010, "!@",, 0, 16777215,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F. ,,"cGet5",,,,lHasButton)           
oSay2  := TSay():New( 040, 10,{||'Tipo'},oPanel,,oTFont,,,,.T.,CLR_BLACK,CLR_WHITE,200,20)   
oCBox2 := TComboBox():New(40, 75,{|u| If(PCount()>0,nCombo02:=u,nCombo02)},aItemsLista,072,012,oPanel,,,,CLR_BLACK,CLR_WHITE,.T.,oTFont,"",,,,,,,nCombo02)

oSay3 := TSay():New( 055, 010,{||'Centro de custo'},oPanel,,oTFont,,,,.T.,CLR_BLACK,CLR_WHITE,200,20)     
oGet3 := TGet():New( 055, 075, { | u | If( PCount() == 0, cGet3, cGet3 := u ) },oPanel, 0160, 010, "!@",, 0, 16777215,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F. ,"CTT","cGet3",,,,lHasButton)   
oGet3 := TGet():New( 055, 240, { | u | If( PCount() == 0, cGet3, cGet3 := u ) },oPanel, 0160, 010, "!@",,CLR_BLACK,CLR_GRAY,,.F.,,.T.,,.F.,,.F.,.F.,,.T.,.F. ,,"cGet3",,,,lHasButton)   

oSay4  := TSay():New( 070, 010,{||'Tipo da moeda'},oPanel,,oTFont,,,,.T.,CLR_BLACK,CLR_WHITE,200,20)    
oCBox1 := TComboBox():New(70, 75,{|u| If(PCount()>0,nCombo01:=u,nCombo01)},aItemsLt,072,012,oPanel,,,,CLR_BLACK,CLR_WHITE,.T.,oTFont,"",,,,,,,nCombo01)

oSay5 := TSay():New( 085,10,{||'Iniciativa'},oPanel,,oTFont,,,,.T.,CLR_BLACK,CLR_WHITE,200,20)     
oGet5 := TGet():New( 085, 75, { | u | If( PCount() == 0, nGet1, nGet1 := u ) },oPanel, 0160, 010, "!@",, 0, 16777215,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F. ,"CTT","nGet1",,,,lHasButton)   
oGet5 := TGet():New( 085, 240, { | u | If( PCount() == 0, nGet1, nGet1 := u ) },oPanel, 0160, 010, "!@",,CLR_BLACK,CLR_GRAY,,.F.,,.T.,,.F.,,.F.,.F.,,.T.,.F. ,,"nGet1",,,,lHasButton)   

oSay6 := TSay():New( 100, 10,{||'Valor plan'},oPanel,,oTFont,,,,.T.,CLR_BLACK,CLR_WHITE,200,20)     
oGet6 := TGet():New( 100, 75, { | u | If( PCount() == 0, nGet2, nGet2 := u ) },oPanel, 060, 010, "@E 99999999.99",, 0, 16777215,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F. ,,"nGet2",,,,lHasButton)   
oSay7 := TSay():New( 115, 10,{||'Saldo iniciativa'},oPanel,,oTFont,,,,.T.,CLR_BLACK,CLR_WHITE,200,20)     
oGet7 := TGet():New( 115, 75, { | u | If( PCount() == 0, nGet3, nGet3 := u ) },oPanel, 060, 010, "@E 99999999.99",, 0, 16777215,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F. ,,"nGet3",,,,lHasButton)   

//chamar a função que cria a estrutura do aHeader
CriaCabec()
//Monta o browser com inclusão, remoção e atualização
oLista := MsNewGetDados():New(  165, 00, 390, 775, GD_INSERT+GD_DELETE+GD_UPDATE, "AllwaysTrue", "AllwaysTrue", "AllwaysTrue", aaCampos,1, 999, "AllwaysTrue", "", "AllwaysTrue", oDlg, aCabecalho, aColsEx)        
//Carregar os itens que irão compor o conteudo do grid
Carregar()        
//Ao abrir a janela o cursor está posicionado no meu objeto
oLista:oBrowse:SetFocus()
// Barra de 
EnchoiceBar(oDlg, {|| oDlg:End() }, {|| oDlg:End() },,aBotoes)

ACTIVATE MSDIALOG oDlg CENTERED
Return

Static Function CriaCabec()

Aadd(aCabecalho, {;
              "DATA",;//X3Titulo()
              "IMAGEM",;  //X3_CAMPO
              "@!",;		//X3_PICTURE
              3,;			//X3_TAMANHO
              0,;			//X3_DECIMAL
              ".F.",;			//X3_VALID
              "",;			//X3_USADO
              "C",;			//X3_TIPO
              "",; 			//X3_F3
              "V",;			//X3_CONTEXT
              "",;			//X3_CBOX
              "",;			//X3_RELACAO
              "",;			//X3_WHEN
              "V"})			//
Aadd(aCabecalho, {;
              "Item",;//X3Titulo()
              "ITEM",;  //X3_CAMPO
              "@!",;		//X3_PICTURE
              5,;			//X3_TAMANHO
              0,;			//X3_DECIMAL
              "",;			//X3_VALID
              "",;			//X3_USADO
              "C",;			//X3_TIPO
              "",; 			//X3_F3
              "R",;			//X3_CONTEXT
              "",;			//X3_CBOX
              "",;			//X3_RELACAO
              ""})			//X3_WHEN
Aadd(aCabecalho, {;
              "Tipo",;//X3Titulo()
              "TIPO",;  //X3_CAMPO
              "@!",;		//X3_PICTURE
              5,;			//X3_TAMANHO
              0,;			//X3_DECIMAL
              "",;			//X3_VALID
              "",;			//X3_USADO
              "C",;			//X3_TIPO
              "",; 			//X3_F3
              "R",;			//X3_CONTEXT
              "",;			//X3_CBOX
              "",;			//X3_RELACAO
              ""})			//X3_WHEN
Aadd(aCabecalho, {;
              "Codigo",;	//X3Titulo()
              "CODIGO",;  	//X3_CAMPO
              "@!",;		//X3_PICTURE
              10,;			//X3_TAMANHO
              0,;			//X3_DECIMAL
              "",;			//X3_VALID
              "",;			//X3_USADO
              "C",;			//X3_TIPO
              "SB1",;		//X3_F3
              "R",;			//X3_CONTEXT
              "",;			//X3_CBOX
              "",;			//X3_RELACAO
              ""})			//X3_WHEN
Aadd(aCabecalho, {;
              "Cod do Prod",;	//X3Titulo()
              "CODIGO",;  	//X3_CAMPO
              "@!",;		//X3_PICTURE
              10,;			//X3_TAMANHO
              0,;			//X3_DECIMAL
              "",;			//X3_VALID
              "",;			//X3_USADO
              "C",;			//X3_TIPO
              "SB1",;		//X3_F3
              "R",;			//X3_CONTEXT
              "",;			//X3_CBOX
              "",;			//X3_RELACAO
              ""})			//X3_WHEN      
Aadd(aCabecalho, {;
              "Descricao",;	//X3Titulo()
              "DESCRICAO",;  	//X3_CAMPO
              "@!",;		//X3_PICTURE
              50,;			//X3_TAMANHO
              0,;			//X3_DECIMAL
              "",;			//X3_VALID
              "",;			//X3_USADO
              "C",;			//X3_TIPO
              "",;			//X3_F3
              "R",;			//X3_CONTEXT
              "",;			//X3_CBOX
              "",;			//X3_RELACAO
              ""})			//X3_WHEN
Aadd(aCabecalho, {;
              "Letra",;	//X3Titulo()
              "DESCRICAO",;  	//X3_CAMPO
              "@!",;		//X3_PICTURE
              50,;			//X3_TAMANHO
              0,;			//X3_DECIMAL
              "",;			//X3_VALID
              "",;			//X3_USADO
              "C",;			//X3_TIPO
              "",;			//X3_F3
              "R",;			//X3_CONTEXT
              "",;			//X3_CBOX
              "",;			//X3_RELACAO
              ""})			//X3_WHEN             
Return

Static Function Carregar()

Local aProdutos := {}
//Local i := 0

aadd(aProdutos,{"000001","PRODUTO 1","UN","","moto","h"})
aadd(aProdutos,{"000002","PRODUTO 2","UN","","moto","h"})
aadd(aProdutos,{"000003","PRODUTO 3","PC","","moto","h"})
aadd(aProdutos,{"000004","PRODUTO 4","MT","","moto","h"})
aadd(aProdutos,{"000005","PRODUTO 5","PC","","moto","h"})
aadd(aProdutos,{"000006","PRODUTO 6",""  ,"","moto","h"})

//Setar array do aCols do Objeto.
oLista:SetArray(aColsEx,.T.)

//Atualizo as informações no grid
oLista:Refresh()
Return

