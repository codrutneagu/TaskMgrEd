#Made by Codrut Neagu
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$TaskMgrED                       = New-Object system.Windows.Forms.Form
$TaskMgrED.ClientSize            = '340,248'
$TaskMgrED.text                  = "Enable or Disable Task Manager"
$TaskMgrED.BackColor             = "#ffffff"
$TaskMgrED.TopMost               = $false

$Button1                         = New-Object system.Windows.Forms.Button
$Button1.BackColor               = "#d0021b"
$Button1.text                    = "Disable Task Manager"
$Button1.width                   = 205
$Button1.height                  = 50
$Button1.location                = New-Object System.Drawing.Point(64,43)
$Button1.Font                    = 'Microsoft Sans Serif,10,style=Bold'

$Button2                         = New-Object system.Windows.Forms.Button
$Button2.BackColor               = "#4a90e2"
$Button2.text                    = "Enable Task Manager"
$Button2.width                   = 205
$Button2.height                  = 50
$Button2.location                = New-Object System.Drawing.Point(64,125)
$Button2.Font                    = 'Microsoft Sans Serif,10,style=Bold'

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Tool provided by digitalcitizen.life"
$Label1.BackColor                = "#ffffff"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(125,221)
$Label1.Font                     = 'Microsoft Sans Serif,10,style=Underline'
$Label1.ForeColor                = "#4a90e2"

$TaskMgrEd.controls.AddRange(@($Button1,$Button2,$Label1))

$Button1.Add_Click({
DisableTaskManager
[System.Windows.Forms.MessageBox]::Show("Task Manager has been disabled." , "Task Manager has been disabled")
})
$Button2.Add_Click({
EnableTaskManager
[System.Windows.Forms.MessageBox]::Show("Task Manager has been enabled." , "Task Manager has been enabled")
})
$Label1.Add_Click({ opendigitalcitizen })

function EnableTaskManager {

$registryPath = "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$name = "DisableTaskMgr"
$value = 0

# If registry path doesn't exist, create it.
If (-NOT (Test-Path $registryPath)) {
    New-Item -Path $registryPath | Out-Null
}
New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWord -Force | Out-Null

}

function DisableTaskManager {

$registryPath = "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$name = "DisableTaskMgr"
$value = 1

# If registry path doesn't exist, create it.
If (-NOT (Test-Path $registryPath)) {
    New-Item -Path $registryPath | Out-Null
}

New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWord -Force | Out-Null
}

function opendigitalcitizen {
    start https://www.digitalcitizen.life
}

$TaskMgrEd.ShowDialog()