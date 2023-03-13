$serverName = "nomedoserver.dominio"
$sessions = qwinsta /server $serverName| ?{ $_ -notmatch '^ SESSIONNAME' } | %{
$item = "" | Select "Active", "SessionName", "Username", "Id", "State", "Type", "Device"
$item.Active = $_.Substring(0,1) -match '>'
$item.SessionName = $_.Substring(1,18).Trim()
$item.Username = $_.Substring(19,20).Trim()
$item.Id = $_.Substring(39,9).Trim()
$item.State = $_.Substring(48,8).Trim()
$item.Type = $_.Substring(56,12).Trim()
$item.Device = $_.Substring(68).Trim()
$item
} 

foreach ($session in $sessions){
    if ($session.Username -ne "" -or $session.Username.Length -gt 1){
        logoff /server $serverName $session.Id
    }
}