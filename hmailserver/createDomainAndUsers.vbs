Dim obBaseApp
Dim obDomain
Dim domainName
Dim userName
Dim password
Dim number
Dim numberUsers
domainName = "easysmpc.org" ' Name of domain
userName = "easy" 'user name with an added index
password = "12345" 'Pasword for admin and users
numberUsers = 20


' Connect
Set obBaseApp = CreateObject("hMailServer.Application") 
Call obBaseApp.Authenticate("Administrator","12345")

' Create domain if not exists
Set obDomain = obBaseApp.Domains.Add()
obDomain.Name = domainName
obDomain.Active = True
On Error resume next
	obDomain.Save()
If err.Number <> 0 Then
	WScript.Echo "Error creating domain"
	WScript.Quit
End If
obBaseApp.Domains.Refresh()

' Add users
dim index
index = 0
while index < numberUsers
	CreateUser userName & index & "@" & domainName
	index = index + 1
wend

' Sub routine for users
Sub CreateUser(userName)
	' Init
	Dim obDomain
	Dim obAccounts
	Dim obNewAccount
	Set obDomain = obBaseApp.Domains.ItemByName(domainName)
	Set obAccounts = obDomain.Accounts
	Set obNewAccount = obAccounts.Add()
	
	' Create user
	obNewAccount.Address = userName
	obNewAccount.Password = password 'password
	obNewAccount.Active = 1 'activates user
	obNewAccount.Maxsize = 0 'sets mailbox size, 0=unlimited
	obNewAccount.Save() 'saves account
	If err.Number <> 0 Then
		WScript.Echo "Error creating user"
		WScript.Quit
	end If
	
	' Set nothing
	Set obNewAccount = Nothing  
	Set obAccounts = Nothing
	Set obDomain = Nothing
End sub