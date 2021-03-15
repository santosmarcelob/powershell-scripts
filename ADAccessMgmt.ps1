# POWERSHELL AD ACCESS MANAGEMENT

# 1) Get Folder Permissions (ACL)


function Validation { 

    $folder_path = Read-Host "Enter folder path"

	(get-acl $folder_path).access | ft IdentityReference,FileSystemRights,AccessControlType,IsInherited,InheritanceFlags -AutoSize

    # Get Managed By properties
    $ADGroup = Read-Host "Enter AD Group to check Managed By"

    Get-ADGroup $ADGroup -Properties managedby | ft name,managedby,samaccountname,objectclass -AutoSize

    # Get group members
    $Mgd_by = Read-Host "Enter Managed By group to check member(s)"

    Get-ADGroupMember -Identity $Mgd_by | ft name,SamAccountName,distinguishedName,objectclass -AutoSize

    Write-Host 
    "Summary:`n
    Folder path: $($folder_path)`n
    AD Group: $($ADGroup)`n
    Managed by: $($Mgd_by)`n"

    Action
}

function AddUserAccess {
    $UserID = Read-Host "Enter User ID"
    $ADGroup = Read-Host "Enter AD Group"

    Add-ADGroupMember -Identity $ADGroup -Members $UserID
    Write-Host "User $($UserID) has been added to the group $($ADGroup) successfully!"

    Action
}


function Action {
    $Action = Read-Host "Type the action to perform:`n (1 - Validation | 2 - AddUserAccess | 3 - Exit"
    
    switch ($Action) {
        1 { Validation}
        2 { AddUserAccess}
        3 { exit}
    }
}

Action



