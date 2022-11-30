function Test-Exit {
    exit 11
}


function Test-ThrowErr {
    throw "Error 123"
}

try {
    Test-ThrowErr
}
catch {
    Write-Host "Error running test-throw Error"
    Write-Host "Process Error"
}

# try {
#     Test-Exit
# }
# catch {
#     Write-Host "Error running Test-Exit Error"
#     Write-Host "Process Error"
# }

Write-Host "Exit script"