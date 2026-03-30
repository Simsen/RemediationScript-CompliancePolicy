$ErrorActionPreference = "Stop"

try {
    $dg = Get-CimInstance -ClassName Win32_DeviceGuard -Namespace root\Microsoft\Windows\DeviceGuard -ErrorAction Stop

    # VBS Status: 0 = Not enabled, 1 = Enabled not running, 2 = Enabled and running
    $vbsStatus = $dg.VirtualizationBasedSecurityStatus
    $hvciConfigured = $dg.SecurityServicesConfigured -contains 2
    $hvciRunning = $dg.SecurityServicesRunning -contains 2

    Write-Output "VBS Status: $vbsStatus"
    Write-Output "HVCI Configured: $hvciConfigured"
    Write-Output "HVCI Running: $hvciRunning"

    if ($vbsStatus -eq 2 -and $hvciConfigured -and $hvciRunning) {
        Write-Output "OK: VBS and Code Integrity (HVCI) are both enabled and running"
        exit 0  # Compliant - no remediation needed
    }

    # Report what is missing
    if ($vbsStatus -ne 2) {
        Write-Output "NON-COMPLIANT: VBS is not running (Status: $vbsStatus)"
    }
    if (-not $hvciConfigured -or -not $hvciRunning) {
        Write-Output "NON-COMPLIANT: HVCI Code Integrity is not enabled or not running"
    }

    exit 1  # Trigger remediation
}
catch {
    Write-Error "Detection failed: $_"
    exit 1
}