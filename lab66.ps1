## Powershell Lab 6
## Manipulate Users, OUs, Groups & Membership

cls

$splat6 = "Choose from the following menu items:"

$splat4 = @"
$splat6
    A. View ONE OU         B. View ALL OUs
    C. View ONE Group      D. View ALL Groups
    E. View ONE User       F. View ALL Users

    G. Create ONE OU       H. Create ONE Group
    I. Create ONE User     J. Create Users from CSV File

    K. Add User to Group   L. Remove User from Group

    M. Delete ONE Group    N. Delete ONE User
    
"@
$splat4
 $answer = read-host "Choose A - N"

 if($answer -eq "A")
{
 $choice1 = $(Read-Host 'What is the name of the OU to use?')
 get-adorganizationalunit -filter $choice1 | format-table -Property name, distinguishedname
}

elseif($answer -eq "B")
{
    
    Get-adorganizationalunit -filter * | Format-Table -property name, distinguishedname

}


elseif($answer -eq "C")
{
 $choice2 = $(read-host 'What is the Group you want to view?')
  Get-adgroup -filter $choice2 | Format-Table -property name, groupscope, groupcategory

}


elseif($answer -eq "D")
{
 
  Get-adgroup -filter * | Format-Table -property name, groupscope, groupcategory

}

elseif($answer -eq "E")
{
  $choice3 = $(read-host 'What is the name of the User you would like to view?')
  Get-aduser -filter $choice3 | Format-Table -property name, distinguishedname

}


elseif($answer -eq "F")
{
  
  Get-aduser -filter * | Format-Table -property name, distinguishedname

}


elseif($answer -eq "G")
{
  $choice4 = $(read-host 'What is the name of the OU you would like to CREATE?')
  new-adorganizationalunit -name "$choice4" -path "DC=ravnica,DC=com" 
  get-adorganizationalunit -filter 'name -like "$choice4"' | format-table -property name, distinguishedname	

}


elseif($answer -eq "H")
{
  $choice5 = $(read-host 'What is the name of the GROUP you would like to CREATE?')
  new-adgroup -name "$choice5" -groupcategory security -groupscope global -path "DC=ravnica,DC=com" 
  get-adgroup -filter 'name -like "$choice5"' | format-table -property name, groupscope, groupcategory	
  
}


elseif($answer -eq "I")
{
  $choice6 = $(read-host 'Would you like to add the user to an OU Y or N?')
        if($choice6 -eq "Y"){
                $OUname = $(read-host 'What is the name of the OU?')
                
        $name = read-host "Enter name"
        $login = read-host "Enter login name"
        $pre2000 = read-host "Enter a user name for pre Win2000"
        $pass = read-host "Enter a password" -assecurestring
        $fname = read-host "Enter first name"
        $lname = read-host "Enter last name"
        $addr = read-host "Enter address"
        $city = read-host "Enter city" 
        $state = read-host "Enter state"
        $post = read-host "Enter Zip code"
        $comp = read-host "Enter company"
        $div = read-host "Enter the division you are in" 
        

  New-aduser -path "OU=$OUname, DC=ravnica, DC=com" -name $name -samaccountname $pre2000 -userprincipalname $login@ravnica.com -givenname $fname -surname $lname -streetaddress $addr -city $city -state $state -PostalCode $post -Company $comp -division $div -Enabled $true -AccountPassword $pass
  get-aduser -filter "name -eq '$name'" -Properties *| format-list -property name, samaccountname, userprincipalname, givenname, surname, city, state, postalcode, company, division
    }  #Y          
        if($choice6 -eq "N"){
        
        $name = read-host "Enter name"
        $login = read-host "Enter login name"
        $pre2000 = read-host "Enter a user name for pre Win2000"
        $pass = read-host "Enter a password" -assecurestring
        $fname = read-host "Enter first name"
        $lname = read-host "Enter last name"
        $addr = read-host "Enter address"
        $city = read-host "Enter city" 
        $state = read-host "Enter state"
        $post = read-host "Enter Zip code"
        $comp = read-host "Enter company"
        $div = read-host "Enter the division you are in" 

        New-aduser -name $name -samaccountname $pre2000 -userprincipalname $login@ravnica.com -givenname $fname -surname $lname -streetaddress $addr -city $city -state $state -PostalCode $post -Company $comp -division $div -Enabled $true -AccountPassword $pass
        get-aduser -filter "name -eq '$name'" -Properties *| format-list -property name, samaccountname, userprincipalname, givenname, surname, city, state, postalcode, company, division
  

        }  #N
}
  
 elseif($answer -eq "K")
 {
    $choice7 = read-host "What is the name of the user?"
    $group = Read-Host "What is the name of the group to add them too?"

    Add-ADGroupMember -identity "$group" -Members $choice7
    get-adgroupmember -Identity $group | format-table samaccountname, distinguishedname, name
 }

 elseif($answer -eq "L")
 {
   
    $group1 = Read-Host "What is the name of the group to remove them from?"
    get-adgroupmember -identity $group1 | format-table samaccountname, distinguishedname, name
    $choice8 = Read-Host "Should a user be removed from this account Y or N?"

    if($choice8 -eq "Y")
        { 
        $lose = Read-host "What is the name of the user to remove?"
        Remove-ADGroupMember -identity $group1 -Members $lose
        get-adgroupmember -identity $group1 | format-table samaccountname, distinguishedname, name

        }
 }

 elseif($answer -eq "M")
 {
    $choice9 = read-host "What is the name of the group to delete?"
    remove-adgroup -Identity $choice9
    get-adgroup -filter * | format-table name, groupscope, groupcategory
    
 }


 elseif($answer -eq "N")
 {
    $choice10 = read-host "What is the name of the user to delete?"
    remove-aduser -Identity $choice10
    get-aduser -filter * | format-table name, distinguishedname
    
 }