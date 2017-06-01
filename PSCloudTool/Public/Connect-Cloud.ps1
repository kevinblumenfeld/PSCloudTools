function Connect-PSCloud {
    <#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    Param
    (

        [parameter(Mandatory = $false)]
        # [ValidateSet("sentc","contoso")]
        [string] $Customer,
       
        [Parameter(Mandatory = $false)]
        [switch] $All365,
                
        [Parameter(Mandatory = $false)]
        [switch] $Azure,        
 
        [parameter(Mandatory = $false)]
        [switch] $Skype,
          
        [parameter(Mandatory = $false)]
        [switch] $Sharepoint,
         
        [parameter(Mandatory = $false)]
        [switch] $Compliance,
          
        [parameter(Mandatory = $false)]
        [switch] $AzurePreview
        
    )

    Begin {
        
    }
    Process {

        $RootPath = "c:\ps\"
        $KeyPath = $Rootpath + "creds\"

        # Create Directory for Transact Logs
        if (!(Test-Path ($RootPath + $Customer + "\logs\"))) {
            New-Item -ItemType Directory -Force -Path ($RootPath + $Customer + "\logs\")
        }

        Start-Transcript -path ($RootPath + $Customer + "\logs\" + "transcript" + ($(get-date -Format _yyyy-MM-dd_HH-mm-ss)) + ".txt")

        # Create KeyPath Directory
        if (!(Test-Path $KeyPath)) {
            try {
                New-Item -ItemType Directory -Path $KeyPath -ErrorAction STOP | Out-Null
            }
            catch {
                throw $_.Exception.Message
            }           
        }
        if (Test-Path ($KeyPath + "$($Customer).cred")) {
            $PwdSecureString = Get-Content ($KeyPath + "$($Customer).cred") | ConvertTo-SecureString
            $UsernameString = Get-Content ($KeyPath + "$($Customer).ucred") 
            $Credential = New-Object System.Management.Automation.PSCredential -ArgumentList $UsernameString, $PwdSecureString 
        }
        else {
            $Credential = Get-Credential -Message "Enter a user name and password"
            $Credential.Password | ConvertFrom-SecureString | Out-File "$($KeyPath)\$Customer.cred" -Force
            $Credential.UserName | Out-File "$($KeyPath)\$Customer.ucred"
        }

        # Office 365 Tenant
        Import-Module MsOnline
        Connect-MsolService -Credential $Credential

        # Exchange Online
        $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell -Credential $Credential -Authentication Basic -AllowRedirection -Verbose
        Export-PSSession $Session -OutputModule ExchangeOnline -Force
        Import-Module ExchangeOnline -Scope Global

        # Security and Compliance Center
        if ($Compliance -or $All365) {
            $ccSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ -Credential $credential -Authentication Basic -AllowRedirection
            Export-PSSession $ccSession -OutputModule ComplianceCenter -Force
            Import-Module ComplianceCenter -Scope Global
        }

        # Sharepoint Online
        if ($Sharepoint -or $All365) {
            Import-Module Microsoft.Online.SharePoint.PowerShell -DisableNameChecking
            Connect-SPOService -Url ("https://" + $Customer + "-admin.sharepoint.com") -credential $Credential
        }

        # Skype Online
        if ($Skype -or $All365) {
            Import-Module SkypeOnlineConnector
            $sfboSession = New-CsOnlineSession -Credential $Credential
            Import-PSSession $sfboSession
        }

        # Azure
        if ($Azure) {
            if (!(Test-Path ($KeyPath + $Customer + ".json"))) {
                Login-AzureRmAccount
                Save-AzureRmContext -Path ($KeyPath + $Customer + ".json")
                Import-AzureRmContext -Path ($KeyPath + $Customer + ".json")
            }
            else {
                Import-AzureRmContext -Path ($KeyPath + $Customer + ".json")
            }
            Write-Output "Select Subscription and Click "OK" in lower right-hand corner"
            $subscription = Get-AzureRmSubscription | Out-GridView -PassThru | Select id
            Select-AzureRmSubscription  -SubscriptionId $subscription.id
        }

        # Azure AD (Preview)
        If ($AzurePreview) {
            install-module azureadpreview
            import-module azureadpreview
            Connect-AzureAD -Credential $Credential
        }

    }
    End {
    } 
}