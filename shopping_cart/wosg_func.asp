<SCRIPT RUNAT=SERVER LANGUAGE=VBSCRIPT> 
dim SB_Name
dim SB_Price
dim SB_Qtty
dim SB_SQ
dim SB_Action

dim CL_Name
dim CL_Price
dim CL_Qtty
dim CL_SQ

dim i
dim ii
dim iii

dim TN_a
dim TN_b

private function Get_Info(SMode,SKey,STag)
	CL_Name=Split(request.Cookies("Cart")("Name"),"|")
	CL_Price=Split(request.Cookies("Cart")("Price"),"|")
	CL_Qtty=Split(request.Cookies("Cart")("Qtty"),"|")
	CL_SQ=Split(request.Cookies("Cart")("SQ"),"|")
	Get_Info=0
	ii=-1
	select case LCase(SMode)
		case "num"
			Get_Info=UBound(CL_Name)
			exit function
		case "id"
			if CInt(SKey)>=0 and CInt(SKey)<=CInt(UBound(CL_Name)) then
				ii=SKey
			end if
		case "name"
			for i=0 to CInt(UBound(CL_Name))
				if SKey=CL_Name(i) then
					ii=i
					exit for
				end if
			next
	end select
	if ii=-1 then
		Get_Info="error"
		exit function
	end if
	select case LCase(STag)
		case "name"
			Get_Info=CL_Name(ii)
		case "price"
			Get_Info=CL_Price(ii)
		case "qtty"
			Get_Info=CL_Qtty(ii)
		case "sq"
			Get_Info=CL_SQ(ii)
		case "amount"
			if len(CL_Price(ii))>0 then
					TN_a=CSng(CL_Price(ii))
				else
					TN_a=0
			end if
			if len(CL_Qtty(ii))>0 then
					TN_b=CSng(CInt(CL_Qtty(ii)))
				else
					TN_b=0
			end if
			Get_Info=TN_a * TN_b
	end select
end function


private sub Set_Info(SMode,SKey,STag,SVal)
	CL_Name=Split(request.Cookies("Cart")("Name"),"|")
	CL_Price=Split(request.Cookies("Cart")("Price"),"|")
	CL_Qtty=Split(request.Cookies("Cart")("Qtty"),"|")
	CL_SQ=Split(request.Cookies("Cart")("SQ"),"|")
	ii=-1
	select case LCase(SMode)
		case "id"
			if CInt(SKey)>=0 and CInt(SKey)<=CInt(UBound(CL_Name)) then
				ii=SKey
			end if
		case "name"
			for i=0 to CInt(UBound(CL_Name))
				if SKey=CL_Name(i) then
					ii=i
					exit for
				end if
			next
	end select
	if ii=-1 then
		response.Write("error <br />")
		exit sub
	end if
	select case LCase(STag)
		case "name"
			CL_Name(ii)=SVal
		case "price"
			CL_Price(ii)=SVal
		case "qtty"
			CL_Qtty(ii)=SVal
		case "sq"
			CL_SQ(ii)=SVal
	end select
	for i=0 to CInt(UBound(CL_Name))
		if i=0 then
				response.Cookies("Cart")("Name")=CL_Name(i)
				response.Cookies("Cart")("Price")=CL_Price(i)
				response.Cookies("Cart")("Qtty")=CL_Qtty(i)
				response.Cookies("Cart")("SQ")=CL_SQ(i)
			else
				response.Cookies("Cart")("Name")=request.Cookies("Cart")("Name") & "|" & CL_Name(i)
				response.Cookies("Cart")("Qtty")=request.Cookies("Cart")("Qtty") & "|" & CL_Qtty(i)
				response.Cookies("Cart")("Price")=request.Cookies("Cart")("Price") & "|" & CL_Price(i)
				response.Cookies("Cart")("SQ")=request.Cookies("Cart")("SQ") & "|" & CL_SQ(i)
		end if

	next
end sub


private sub Add_Info(CName,Qtty,Price,SQ)
	if Get_Info("num",0,0) = -1 then
		response.Cookies("Cart")("Name")= CName
		response.Cookies("Cart")("Qtty")=CInt(Qtty)
		response.Cookies("Cart")("Price")=Price
		response.Cookies("Cart")("SQ")= CInt(SQ)
	else
		response.Cookies("Cart")("Name")=request.Cookies("Cart")("Name") & "|" & CName
		response.Cookies("Cart")("Qtty")=request.Cookies("Cart")("Qtty") & "|" & CInt(Qtty)
		response.Cookies("Cart")("Price")=request.Cookies("Cart")("Price") & "|" & Price
		response.Cookies("Cart")("SQ")=request.Cookies("Cart")("SQ") & "|" & CInt(SQ)
	end if
end sub


private sub Del_Info(SMode,SKey)
	CL_Name=Split(request.Cookies("Cart")("Name"),"|")
	CL_Price=Split(request.Cookies("Cart")("Price"),"|")
	CL_Qtty=Split(request.Cookies("Cart")("Qtty"),"|")
	CL_SQ=Split(request.Cookies("Cart")("SQ"),"|")
	ii=-1
	select case LCase(SMode)
		case "id"
			if CInt(SKey)>=0 and CInt(SKey)<=CInt(UBound(CL_Name)) then
				ii=SKey
			end if
		case "name"
			for i=0 to CInt(UBound(CL_Name))
				if SKey=CL_Name(i) then
					ii=i
					exit for
				end if
			next
	end select
	if ii=-1 then
		response.Write("error <br />")
		exit sub
	end if
	if ii=0 then
			iii=1
		else
			iii=0
	end if
	for i=0 to CInt(UBound(CL_Name))
		if i<>ii then
			if i=iii then
					response.Cookies("Cart")("Name")=CL_Name(i)
					response.Cookies("Cart")("Price")=CL_Price(i)
					response.Cookies("Cart")("Qtty")=CL_Qtty(i)
					response.Cookies("Cart")("SQ")=CL_SQ(i)
				else
					response.Cookies("Cart")("Name")=request.Cookies("Cart")("Name") & "|" & CL_Name(i)
					response.Cookies("Cart")("Qtty")=request.Cookies("Cart")("Qtty") & "|" & CL_Qtty(i)
					response.Cookies("Cart")("Price")=request.Cookies("Cart")("Price") & "|" & CL_Price(i)
					response.Cookies("Cart")("SQ")=request.Cookies("Cart")("SQ") & "|" & CL_SQ(i)
			end if
		end if
	next
end sub

private function Add_Check(SName,SQtty,SSQ)

end function
</script>