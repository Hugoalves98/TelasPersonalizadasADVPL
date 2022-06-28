#INCLUDE 'TOTVS.CH'
#Include 'FWMVCDef.ch'

//ESSE FONTO S� T� ABRINDO O COD, MESMO EU COMENTANDO TUDO, MAS O PROBLEMA � QUE N�O VEM COM OS BOT�ES INCLUIR, ALTERAR...

// Exemplo de Modelo 1 para cadastro de ''Artistas''


//Vari�veis Est�ticas
Static cTitulo := "Artista"

/*
Exemplo de Modelo 1 para cadastro de Artistas
@return Nil, Fun��o n�o tem retorno
/*/
User Function zModel1()
	Local aArea   := GetArea()
	Local oBrowse
	Local cFunBkp := FunName()
	
	SetFunName("zModel1")
	
	//Inst�nciando FWMBrowse - Somente com dicion�rio de dados
	oBrowse := FWMBrowse():New()
	
	//Setando a tabela de cadastro de Autor/Interprete
	oBrowse:SetAlias("ZZ1")
	//Setando a descri��o da rotina
	oBrowse:SetDescription(cTitulo)
	
	//Legendas
	oBrowse:AddLegend( "ZZ1->ZZ1_COD <= '000005'", "GREEN",	"Menor ou igual a 5" )
	oBrowse:AddLegend( "ZZ1->ZZ1_COD >  '000005'", "RED",	"Maior que 5" )
	
	//Filtrando
	//oBrowse:SetFilterDefault("ZZ1->ZZ1_COD >= '000000' .And. ZZ1->ZZ1_COD <= 'ZZZZZZ'")
	
	//Ativa a Browse
	oBrowse:Activate()
	
	SetFunName(cFunBkp)
	RestArea(aArea)
Return Nil
/*
Desc:  Cria��o do menu MVC
*/
Static Function MenuDef()
	Local aRot := {}
	
	//Adicionando op��es
	ADD OPTION aRot TITLE 'Visualizar' ACTION 'VIEWDEF.zModel1' OPERATION MODEL_OPERATION_VIEW   ACCESS 0 //OPERATION 1
	ADD OPTION aRot TITLE 'Legenda'    ACTION 'u_zMod1Leg'      OPERATION 6                      ACCESS 0 //OPERATION X
	ADD OPTION aRot TITLE 'Incluir'    ACTION 'VIEWDEF.zModel1' OPERATION MODEL_OPERATION_INSERT ACCESS 0 //OPERATION 3
	ADD OPTION aRot TITLE 'Alterar'    ACTION 'VIEWDEF.zModel1' OPERATION MODEL_OPERATION_UPDATE ACCESS 0 //OPERATION 4
	ADD OPTION aRot TITLE 'Excluir'    ACTION 'VIEWDEF.zModel1' OPERATION MODEL_OPERATION_DELETE ACCESS 0 //OPERATION 5
Return aRot
/*
 Desc:  Cria��o do modelo de dados MVC    
*/
Static Function ModelDef()
	//Cria��o do objeto do modelo de dados
	Local oModel := Nil
	
	//Cria��o da estrutura de dados utilizada na interface
	Local oStZZ1 := FWFormStruct(1, "ZZ1")
	
	//Editando caracter�sticas do dicion�rio
	oStZZ1:SetProperty('ZZ1_COD',   MODEL_FIELD_WHEN,    FwBuildFeature(STRUCT_FEATURE_WHEN,    '.F.'))                                 //Modo de Edi��o
	oStZZ1:SetProperty('ZZ1_COD',   MODEL_FIELD_INIT,    FwBuildFeature(STRUCT_FEATURE_INIPAD,  'GetSXENum("ZZ1", "ZZ1_COD")'))         //Ini Padr�o
	oStZZ1:SetProperty('ZZ1_DESC',  MODEL_FIELD_VALID,   FwBuildFeature(STRUCT_FEATURE_VALID,   'Iif(Empty(M->ZZ1_DESC), .F., .T.)'))   //Valida��o de Campo
	oStZZ1:SetProperty('ZZ1_DESC',  MODEL_FIELD_OBRIGAT, Iif(RetCodUsr()!='000000', .T., .F.) )                                         //Campo Obrigat�rio
	
	//Instanciando o modelo, n�o � recomendado colocar nome da user function (por causa do u_), respeitando 10 caracteres
	oModel := MPFormModel():New("zModel1M",/*bPre*/, /*bPos*/,/*bCommit*/,/*bCancel*/) 
	
	//Atribuindo formul�rios para o modelo
	oModel:AddFields("FORMZZ1",/*cOwner*/,oStZZ1)
	
	//Setando a chave prim�ria da rotina
	oModel:SetPrimaryKey({'ZZ1_FILIAL','ZZ1_COD'})
	
	//Adicionando descri��o ao modelo
	oModel:SetDescription("Modelo de Dados do Cadastro "+cTitulo)
	
	//Setando a descri��o do formul�rio
	oModel:GetModel("FORMZZ1"):SetDescription("Formul�rio do Cadastro "+cTitulo)
Return oModel
/*
Desc:  Cria��o da vis�o MVC                             
*/
Static Function ViewDef()
	Local aStruZZ1	:= ZZ1->(DbStruct())
	
	//Cria��o do objeto do modelo de dados da Interface do Cadastro de Autor/Interprete
	Local oModel := FWLoadModel("zModel1")
	
	//Cria��o da estrutura de dados utilizada na interface do cadastro de Autor
	Local oStZZ1 := FWFormStruct(2, "ZZ1")  //pode se usar um terceiro par�metro para filtrar os campos exibidos { |cCampo| cCampo $ 'SZZ1_NOME|SZZ1_DTAFAL|'}
	
	//Criando oView como nulo
	Local oView := Nil
	//Criando a view que ser� o retorno da fun��o e setando o modelo da rotina
	oView := FWFormView():New()
	oView:SetModel(oModel)
	
	//Atribuindo formul�rios para interface
	oView:AddField("VIEW_ZZ1", oStZZ1, "FORMZZ1")
	
	//Criando um container com nome tela com 100%
	oView:CreateHorizontalBox("TELA",100)
	
	//Colocando t�tulo do formul�rio
	oView:EnableTitleView('VIEW_ZZ1', 'Dados - '+cTitulo )  
	
	//For�a o fechamento da janela na confirma��o
	oView:SetCloseOnOk({||.T.})
	
	//O formul�rio da interface ser� colocado dentro do container
	oView:SetOwnerView("VIEW_ZZ1","TELA")
	
	/*
	//Tratativa para remover campos da visualiza��o
	For nAtual := 1 To Len(aStruZZ1)
		cCampoAux := Alltrim(aStruZZ1[nAtual][01])
		
		//Se o campo atual n�o estiver nos que forem considerados
		If Alltrim(cCampoAux) $ "ZZ1_COD;"
			oStZZ1:RemoveField(cCampoAux)
		EndIf
	Next
	*/
Return oView


User Function zMod1Leg()
	Local aLegenda := {}
	
	//Monta as cores
	AADD(aLegenda,{"BR_VERDE",		"Menor ou igual a 5"  })
	AADD(aLegenda,{"BR_VERMELHO",	"Maior que 5"})
	
	BrwLegenda(cTitulo, "Status", aLegenda)
Return