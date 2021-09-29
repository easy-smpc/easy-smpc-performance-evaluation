Option Explicit
Dim Elog
Dim obBaseApp
Dim objFSO
Dim objTextFile
Dim strNewAlias,i

Dim failed
Dim added
Dim domainsAdded
failed = 0
added = 0
domainsAdded = 0

Const ForReading = 1
 
Set Elog = CreateObject("hMailServer.EventLog")
Set obBaseApp = CreateObject("hMailServer.Application") 

Call obBaseApp.Authenticate("Administrator","password") '*** N.B. 1. set your administrator password in this line 
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objTextFile = objFSO.OpenTextFile("AddAccounts.txt", ForReading) 'N.B. 2. Set your CSV path/filename in this line
On Error resume next
Do While objTextFile.AtEndOfStream <> True
    strNewAlias = split(objTextFile.Readline, ",")

    Select Case strNewAlias(0)
       Case "User"
          AddUser strNewAlias(1), strNewAlias(2), strNewAlias(3)
       Case "Alias"
          AddAlias strNewAlias(1), strNewAlias(2), strNewAlias(3)
    End Select
    If err.Number <> 0 Then    'error handling:
     Elog.Write("Failed add (probably duplicate)" & Chr(34) & vbTab & Chr(34) & strNewAlias(0) _
     & "," & strNewAlias(1) & "," & strNewAlias(2) & "," & strNewAlias(3))
     failed = failed + 1
     err.Clear
    Else
     added = added + 1
    End If
Loop
On Error goto 0
Elog.Write("Domains Added Sucessfully    = " & domainsAdded)
Elog.Write("Accounts Added Sucessfully   = " & added)
Elog.Write("Failed or Duplicate Accounts = " & failed)
Wscript.Echo ("Domains Added Sucessfully    = " & domainsAdded & VbNewLine _
            & "Accounts Added Sucessfully   = " & added & VbNewLine _
            & "Failed or Duplicate Accounts  = " & failed & VbNewLine & VbNewLine _
            & "See hmailserver_events.log for list of duplicates (if any)")

Sub AddAlias(strAlias,strEmailAddress,strDomain)

   AddDomain strDomain

   Dim obDomain 
   Dim obAliases 
   Dim obNewAlias

   Set obDomain = obBaseApp.Domains.ItemByName(strDomain) 
   Set obAliases = obDomain.Aliases
   Set obNewAlias = obAliases.Add() 
   
   obNewAlias.Name = strAlias & "@" & strDomain 'username
   obNewAlias.Value = strEmailAddress 'password
   obNewAlias.Active = 1 'activates user
   obNewAlias.Save() 'saves account
   
   Set obNewAlias = Nothing
   Set obAliases = Nothing
   Set obDomain = Nothing   
   
End Sub

Sub AddUser(strUsername, strPassword, strDomain)
   
   AddDomain strDomain
   
   Dim obDomain 
   Dim obAccounts 
   Dim obNewAccount

   Set obDomain = obBaseApp.Domains.ItemByName(strDomain) 
   Set obAccounts = obDomain.Accounts
   Set obNewAccount = obAccounts.Add() 
   
   obNewAccount.Address = strUsername & "@" & strDomain 'username
   obNewAccount.Password = strPassword 'password
   obNewAccount.Active = 1 'activates user
   obNewAccount.Maxsize = 0 'sets mailbox size, 0=unlimited
   obNewAccount.Save() 'saves account
  
   Set obNewAccount = Nothing
   Set obDomain = Nothing   
   Set obAccounts = Nothing
  
End Sub

Sub AddDomain(strDomain)
   Dim obNewDomain
   Set obNewDomain = obBaseApp.Domains.Add()
   obNewDomain.Name = strDomain
   obNewDomain.Active = True

   On Error resume next
   obNewDomain.Save()
   If err.Number = 0 Then
    domainsAdded = domainsAdded + 1
   End If 
   err.Clear
 
   obBaseApp.Domains.Refresh()
End Sub
