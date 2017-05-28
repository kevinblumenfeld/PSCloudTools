Write-Output "Import File"
$file = Import-Csv "C:\scripts\lausd\LA_Mbx_upn_holds.csv"
Write-Output "Get-MailboxSearch to Create HashTable"
$HoldList = Get-MailboxSearch | Select Name, InPlaceHoldIdentity
# Create Hash Table with Hold GUIDS(Key) & Friendly Name (Value) 
$hash = @{}
foreach ($Hold in $HoldList) {
    $hash.add($hold.InPlaceHoldIdentity, $hold.name)
}
$row = @()
foreach ($row in $file) {
    $new = @()
    if ($row.inplaceholds) {
        if ($row.inplaceholds.split().count -gt 1) {
            ForEach ($hold in $row.inplaceholds.split()) {
                $temp = $hash.GetEnumerator() | Where {$_.Name -match $hold}
                $new += $temp.Value + ","
                $new = $new.trim()
            }
        }
        else {
            ForEach ($hold in $row.inplaceholds.split()) {
                $temp = $hash.GetEnumerator() | Where {$_.Name -match $hold}
                $new += $temp.Value + ","
            }
        }   
        $row.userprincipalname + "," + $new | Out-File ".\LA_With_Holds.csv" -Append -Encoding utf8
    }
    else {
        $row.userprincipalname + "," + "" | Out-File ".\LA_Without_Holds.csv" -Append -Encoding utf8
    }
}