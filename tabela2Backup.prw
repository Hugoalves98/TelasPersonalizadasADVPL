#include "protheus.ch"

User Function gt1() //Nome da funçao

    Local aaCampos  	:= {"CODIGO"} //Variável contendo o campo editável no Grid
    Local aBotoes	:= {}         //Variável onde será incluido o botão para a legenda   
    Local dGet1 := Date() // Variavel do tipo caracter
    Local cGet2 := "Tipo               " // Variavel do tipo caracter
    Local cGet3 := "Centro de custo    " // Variavel do tipo caracter
    Local cGet4 := "Tipo da moeda      " // Variavel do tipo caracter
    Local nGet1 := 0 // Variável do tipo numérica 
    Local nGet2 := 0 
    Local nGet3 := 0 
    Local lHasButton := .T.
    local oPanel
  
    Private oLista                    //Declarando o objeto do browser
    Private aCabecalho  := {}         //Variavel que montará o aHeader do grid
    Private aColsEx 	:= {}         //Variável que receberá os dados

    //Declarando os objetos de cores para usar na coluna de status do grid
  
    Private oVerde  	:= LoadBitmap( GetResources(), "BR_VERDE")
    Private oAzul  	    := LoadBitmap( GetResources(), "BR_AZUL")
    Private oVermelho	:= LoadBitmap( GetResources(), "BR_VERMELHO")
    Private oAmarelo	:= LoadBitmap( GetResources(), "BR_AMARELO")
 
    DEFINE MSDIALOG oDlg TITLE "Consulta de saldo" FROM 000, 000  TO 400, 700  PIXEL

        oTFont := TFont():New('Courier new',,16,.T.)
        oPanel:= tPanel():New(025,00,"",oDlg,oTFont,.T.,,CLR_WHITE,CLR_WHITE,400,80)

        oSay1:= TSay():New( 010,010,{||'Ano'},oPanel,,oTFont,,,,.T.,CLR_BLACK,CLR_GRAY,200,20)   
        oGet1 := TGet():New( 035, 065, { | u | If( PCount() == 0, dGet1, dGet1 := u ) },oDlg, 060, 010, "@D",, 0, 16777215,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F. ,,"dGet1",,,,lHasButton)           
        
        oSay2:= TSay():New( 027,010,{||'Tipo'},oPanel,,oTFont,,,,.T.,CLR_BLACK,CLR_WHITE,200,20)   
        oGet2 := TGet():New( 050, 065, { | u | If( PCount() == 0, cGet2, cGet2 := u ) },oDlg, 060, 010, "!@",, 0, 16777215,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F. ,,"cGet2",,,,lHasButton)   
        
        oSay3:= TSay():New( 042,010,{||'Centro de custo'},oPanel,,oTFont,,,,.T.,CLR_BLACK,CLR_WHITE,200,20)     
        oGet3 := TGet():New( 065, 065, { | u | If( PCount() == 0, cGet3, cGet3 := u ) },oDlg, 060, 010, "!@",, 0, 16777215,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F. ,,"cGet3",,,,lHasButton)   
        
        oSay4:= TSay():New( 055,010,{||'Tipo da moeda'},oPanel,,oTFont,,,,.T.,CLR_BLACK,CLR_WHITE,200,20)     
        oGet4 := TGet():New( 080, 065, { | u | If( PCount() == 0, cGet4, cGet4 := u ) },oDlg, 060, 010, "!@",, 0, 16777215,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F. ,,"cGet4",,,,lHasButton)   
  
        oSay5:= TSay():New( 010,127,{||'Iniciativa'},oPanel,,oTFont,,,,.T.,CLR_BLACK,CLR_BLACK,200,20)     
        oGet5 := TGet():New( 035, 185, { | u | If( PCount() == 0, nGet1, nGet1 := u ) },oDlg, 060, 010, "@E 99999999.99",, 0, 16777215,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F. ,,"nGet1",,,,lHasButton)   

        oSay6:= TSay():New( 027,127,{||'Valor plan'},oPanel,,oTFont,,,,.T.,CLR_BLACK,CLR_BLACK,200,20)     
        oGet6 := TGet():New( 050, 185, { | u | If( PCount() == 0, nGet2, nGet2 := u ) },oDlg, 060, 010, "@E 99999999.99",, 0, 16777215,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F. ,,"nGet2",,,,lHasButton)   

        oSay7:= TSay():New( 042,127,{||'Saldo iniciativa'},oPanel,,oTFont,,,,.T.,CLR_BLACK,CLR_BLACK,200,20)     
        oGet7 := TGet():New( 065, 185, { | u | If( PCount() == 0, nGet3, nGet3 := u ) },oDlg, 060, 010, "@E 99999999.99",, 0, 16777215,,.F.,,.T.,,.F.,,.F.,.F.,,.F.,.F. ,,"nGet3",,,,lHasButton)   

        //chamar a função que cria a estrutura do aHeader
        CriaCabec()
 
        //Monta o browser com inclusão, remoção e atualização
        oLista := MsNewGetDados():New(  105, 00, 190, 775, GD_INSERT+GD_DELETE+GD_UPDATE, "AllwaysTrue", "AllwaysTrue", "AllwaysTrue", aaCampos,1, 999, "AllwaysTrue", "", "AllwaysTrue", oDlg, aCabecalho, aColsEx)        
 
        //Carregar os itens que irão compor o conteudo do grid
        Carregar()        
 
        //Ao abrir a janela o cursor está posicionado no meu objeto
        oLista:oBrowse:SetFocus()
 
        //Crio o menu que irá aparece no botão Ações relacionadas
        aadd(aBotoes,{"NG_ICO_LEGENDA", {||Legenda()},"Legenda","Legenda"})
        
        // Barra de 
        EnchoiceBar(oDlg, {|| oDlg:End() }, {|| oDlg:End() },,aBotoes)
 
    ACTIVATE MSDIALOG oDlg CENTERED
Return

Static Function CriaCabec()
    Aadd(aCabecalho, {;
                  "",;//X3Titulo()
                  "IMAGEM",;  //X3_CAMPO
                  "@BMP",;		//X3_PICTURE
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
Return

Static Function Carregar()

    Local aProdutos := {}
    Local i := 0
 
    aadd(aProdutos,{"000001","PRODUTO 1","UN","","moto","h"})
    aadd(aProdutos,{"000002","PRODUTO 2","UN","","moto","h"})
    aadd(aProdutos,{"000003","PRODUTO 3","PC","","moto","h"})
    aadd(aProdutos,{"000004","PRODUTO 4","MT","","moto","h"})
    aadd(aProdutos,{"000005","PRODUTO 5","PC","","moto","h"})
    aadd(aProdutos,{"000006","PRODUTO 6",""  ,"","moto","h"})
 
    For i := 1 to len(aProdutos)
 
        if(aProdutos[i,3]=="UN")
            aadd(aColsEx,{oVerde,StrZero(i,3),aProdutos[i,3],aProdutos[i,1],aProdutos[i,2],.F.})
        Elseif(aProdutos[i,3]=="PC")
            aadd(aColsEx,{oAzul,StrZero(i,3),aProdutos[i,3],aProdutos[i,1],aProdutos[i,2],.F.})
        Elseif(aProdutos[i,3]=="MT")
            aadd(aColsEx,{oVermelho,StrZero(i,3),aProdutos[i,3],aProdutos[i,1],aProdutos[i,2],.F.})
        Else
            aadd(aColsEx,{oAmarelo,StrZero(i,3),aProdutos[i,3],aProdutos[i,1],aProdutos[i,2],.F.})
        Endif
        
    Next
 
    //Setar array do aCols do Objeto.
    oLista:SetArray(aColsEx,.T.)
 
    //Atualizo as informações no grid
    oLista:Refresh()
Return

Static function Legenda()
    Local aLegenda := {}
    AADD(aLegenda,{"BR_AMARELO"     ,"   Tipo não definido" })
    AADD(aLegenda,{"BR_AZUL"    	,"   Tipo PC" })
    AADD(aLegenda,{"BR_VERDE"    	,"   Tipo UN" })
    AADD(aLegenda,{"BR_VERMELHO" 	,"   Tipo MT" })
 
    BrwLegenda("Legenda", "Legenda", aLegenda)
Return Nil



