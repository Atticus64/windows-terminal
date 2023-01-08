. $HOME/.config/aliases.ps1

function Invoke-Starship-TransientFunction {
  &starship module character
}

Invoke-Expression (&starship init powershell)

Enable-TransientPrompt

Import-Module -Name Terminal-Icons 

Function cfgNeo {nvim $HOME\AppData\Local\nvim\}
Function cfgNp {Set-Location $HOME\AppData\Local\nvim\}

Function open($obj) {
   if ( !$obj ){
      Start-Process chrome
   }

   if ( $obj -is [Int32]  ){
      Start-Process chrome "http://localhost:$obj"
   } 
   if ( $obj -is [String] ){
      . $obj
   }

}

Function poshConfig {nvim $HOME/.config/JonasTheme.json; Write-Host " "}

Function which ($command) {
	Get-Command -Name $command -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue; 
	Write-Host " "
}

Set-Alias -Name vcfg -value cfgNeo
Set-Alias -Name pvc -value cfgNp
Set-Alias -Name prog -value goProg
Set-Alias -Name ll ls
Set-Alias -Name vim nvim
Set-Alias pcfg poshConfig

$env:bash='C:\Program Files\Git\usr\bin\bash.exe'

Set-PSReadLineKeyHandler -Chord 'Ctrl+e' -Function EndOfLine 
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function BeginningOfLine 
Set-PSReadLineKeyHandler -Chord 'Ctrl+q' -Function DeleteLine
Set-PSReadLineKeyHandler -Chord 'Ctrl+h' -Function BackwardWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+k' -Function ForwardWord

Set-PSReadLineOption -Colors @{
    "String" = "#f39c12"
}
