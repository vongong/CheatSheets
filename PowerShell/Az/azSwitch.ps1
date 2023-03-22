param (
	[string] $Method
	,[int] $Sub = -1
    ,[switch] $silent
)

if ($Method -notin 'AzCli','Pwsh','Both' ) {
    $options = @()
    $options += New-Object System.Management.Automation.Host.ChoiceDescription '&Az', 'Azure Cli'
    $options += New-Object System.Management.Automation.Host.ChoiceDescription '&Pwsh', 'PowerShell (default)'
    $options += New-Object System.Management.Automation.Host.ChoiceDescription '&Both', 'Both'

    $title = 'Azure Method'
    $message = 'Login Protocol?'
    $result = $host.ui.PromptForChoice($title, $message, $options, 1)

    switch ($result) {
        0 {
            $Method = 'AzCli' 
        }
        1 {
            $Method = 'Pwsh'             
        }    
        2 {
            $Method = 'Both'             
        }    
        default {
            $Method = 'Pwsh'             
        }
    }

}

if ($Sub -notin 0,1 ) {
    $options = @()
    $options += New-Object System.Management.Automation.Host.ChoiceDescription '&Dev', 'BPB Dev-Test (Default)'
    $options += New-Object System.Management.Automation.Host.ChoiceDescription '&Prod', 'BPB Production'
    
    $title = 'Azure Subscription'
    $message = 'Subscription?'
    $Sub = $host.ui.PromptForChoice($title, $message, $options, 0)
    
} 

switch ($sub) {
    0 { $SubscriptionID = "DevTest-SubscriptionID" }
    1 { $SubscriptionID = "Prod-SubscriptionID"  }    
    default { $SubscriptionID = "DevTest-SubscriptionID" }
}
    

if ($Method -in ('AzCli','Both')) {
    az account set --subscription $SubscriptionID
    if (-not $silent) {
        az account show        
    }
} 
if ($Method -in ('Pwsh','Both')){
    $msg = Set-AzContext -SubscriptionID $SubscriptionID
    if (-not $silent) {
        $msg
    }
}