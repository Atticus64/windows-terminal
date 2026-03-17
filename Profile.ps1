. $HOME/.config/aliases.ps1                                                                                          
function Invoke-Starship-TransientFunction {
  &starship module character
}

Invoke-Expression (&starship init powershell)

Enable-TransientPrompt

Import-Module -Name Terminal-Icons

Function cfgNeo {nvim $HOME\AppData\Local\nvim\}
Function cfgNp {Set-Location $HOME\AppData\Local\nvim\}
Function asm { cd 'C:/TASM' }
Function goProg { cd 'E:/prog' }
Function goNotes { cd 'E:\prog\manuscripts' }

Function free {
	$OS = Get-CimInstance Win32_OperatingSystem
	$UsedMemoryGB = ([math]::Round(($OS.TotalVisibleMemorySize - $OS.FreePhysicalMemory) / 1024, 2))
	$TotalMemoryGB = ([math]::Round($OS.TotalVisibleMemorySize / 1024, 2))
	$ramUsagePercent = ([math]::Round((100 - ($OS.FreePhysicalMemory / $OS.TotalVisibleMemorySize) * 100), 2))

	Write-Host "Total RAM: $TotalMemoryGB GB"
	Write-Host "Used RAM: $UsedMemoryGB GB"
	Write-Host "RAM Usage: $ramUsagePercent%"
}

Function open($obj) {
   if ( !$obj ){
      Start-Process chrome
   }

   if ( $obj -is [Int32]  ){
      Start-Process chrome "http://localhost:$obj"
   }
   if ( $obj -is [String] ){
      . "$pwd\$obj"
   }
}

function VsOpen($path) {
    if ($path -is [Int32]) {
        echo  "Path invalid"
        return
    }

    if ($path -eq ".") {
        # current path
        $name = (Get-ChildItem -Filter *.sln).name
        Invoke-item $name
    } else {
        # other path
        $name = (Get-ChildItem -Path $path -Filter *.sln).name
        Invoke-item $name
    }
}

Function poshConfig {nvim $HOME/.config/JonasTheme.json; Write-Host " "}

Function cppDev { & 'C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\Common7\Tools\Launch-VsDevShell.ps1' }

Function which ($command) {
        Get-Command -Name $command -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue;
        Write-Host " "
}


Function devServer {
    pnpm dev
}

Function orgFn {
    python org.py
}

Set-Alias org orgFn
Set-Alias -Name vcfg -value cfgNeo
Set-Alias -Name pvc -value cfgNp
Set-Alias -Name prog -value goProg
Set-Alias -Name notes -value goNotes
Set-Alias -Name ip -value ipconfig
Set-Alias -Name ll ls
Set-Alias -Name cpl cppDev
Set-Alias -Name dev devServer
Set-Alias pcfg poshConfig

$env:bash='C:\Program Files\Git\usr\bin\bash.exe'

Set-PSReadLineKeyHandler -Chord 'Ctrl+e' -Function EndOfLine
Set-PSReadLineKeyHandler -Chord 'Ctrl+a' -Function BeginningOfLine
Set-PSReadLineKeyHandler -Chord 'Ctrl+u' -Function DeleteLine
Set-PSReadLineKeyHandler -Chord 'Ctrl+h' -Function BackwardWord
Set-PSReadLineKeyHandler -Chord 'Ctrl+k' -Function ForwardWord

Set-PSReadLineOption -Colors @{
    "String" = "#f39c12"
}

Invoke-Expression (& { (zoxide init powershell | Out-String) })
fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
