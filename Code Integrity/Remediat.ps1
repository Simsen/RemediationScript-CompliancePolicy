$ErrorActionPreference = "Stop"

try {
    $dg = Get-CimInstance -ClassName Win32_DeviceGuard -Namespace root\Microsoft\Windows\DeviceGuard -ErrorAction Stop

    $vbsStatus = $dg.VirtualizationBasedSecurityStatus
    $hvciConfigured = $dg.SecurityServicesConfigured -contains 2
    $hvciRunning = $dg.SecurityServicesRunning -contains 2

    $rebootRequired = $false

    # --- Enable VBS if not running ---
    if ($vbsStatus -ne 2) {
        Write-Output "Enabling Virtualization Based Security..."

        $vbsPath = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard"
        if (-not (Test-Path $vbsPath)) {
            New-Item -Path $vbsPath -Force | Out-Null
        }

        Set-ItemProperty -Path $vbsPath -Name "EnableVirtualizationBasedSecurity" -Value 1 -Type DWord -Force
        Set-ItemProperty -Path $vbsPath -Name "RequirePlatformSecurityFeatures" -Value 1 -Type DWord -Force

        Write-Output "VBS registry keys set"
        $rebootRequired = $true
    } else {
        Write-Output "VBS already running - skipping"
    }

    # --- Enable HVCI if not configured/running ---
    if (-not $hvciConfigured -or -not $hvciRunning) {
        Write-Output "Enabling HVCI / Code Integrity..."

        $hvciPath = "HKLM:\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity"
        if (-not (Test-Path $hvciPath)) {
            New-Item -Path $hvciPath -Force | Out-Null
        }

        Set-ItemProperty -Path $hvciPath -Name "Enabled" -Value 1 -Type DWord -Force

        Write-Output "HVCI registry key set"
        $rebootRequired = $true
    } else {
        Write-Output "HVCI already configured and running - skipping"
    }

    # --- Result ---
    if ($rebootRequired) {
        Write-Output "SUCCESS: Settings applied. A reboot is required to take effect."
    } else {
        Write-Output "SUCCESS: No changes needed."
    }

    exit 0
}
catch {
    Write-Error "Remediation failed: $_"
    exit 1
}