# Unicode Example
[Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes("TextToEncode"))
[System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String("VABlAHgAdABUAG8ARQBuAGMAbwBkAGUA"))

# UT8 Example
[Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("TextToEncode"))
[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("VGV4dFRvRW5jb2Rl"))
