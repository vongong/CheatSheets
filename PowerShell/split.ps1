$ConnectionString='Server=myServerName;Database=master;Trusted_Connection=True;'

$srv=""
$connArr = $ConnectionString -Split ";"
foreach ($keypair in $connArr) {
	$ele = $keypair -Split "="
    if ($ele[0].ToLower() -eq 'server') {
        $srv=$ele[1]
    }
}

$srv