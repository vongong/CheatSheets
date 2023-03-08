param (
	[string] $Method
)

if ($Method -notin 'AzCli','Pwsh' ) {
    $options = @()
    $options += New-Object System.Management.Automation.Host.ChoiceDescription '&Az', 'Azure Cli'
    $options += New-Object System.Management.Automation.Host.ChoiceDescription '&Pwsh', 'PowerShell (default)'

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
        default {
            $Method = 'Pwsh'             
        }
    }

}

$options = @()
$options += New-Object System.Management.Automation.Host.ChoiceDescription '&Dev', 'BPB Dev-Test (Default)'
$options += New-Object System.Management.Automation.Host.ChoiceDescription '&Prod', 'BPB Production'

$title = 'Azure Subscription'
$message = 'Subscription?'
$result = $host.ui.PromptForChoice($title, $message, $options, 0)

$SubscriptionID = ''
switch ($result) {
    0 { $SubscriptionID = "1efa4976-74c8-48ff-be80-65eaf8643661" }
    1 { $SubscriptionID = "b011b7ee-749e-447f-bbf7-79191dfc1b6c"  }    
    default { $SubscriptionID = "1efa4976-74c8-48ff-be80-65eaf8643661" }
}


if ($Method -eq 'AzCli') {
    az account set --subscription $SubscriptionID
    az account show
} else{
    Set-AzContext -SubscriptionID $SubscriptionID
}