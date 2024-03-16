# Define the device you want to monitor
$deviceName = "NVIDIA GeForce RTX 4080"

# Define the interval in seconds for how often you want to check the connection
$interval = 5

# This is the script block that will be executed repeatedly
$scriptBlock = {
    param($deviceName)
    
    # Get the list of connected devices and filter for your device
    $device = Get-PnpDevice | Where-Object { $_.FriendlyName -eq $deviceName }
    
    # Check if the device is found
    if ($device) { 
        # If device is found
        if ($device.Status -eq 'OK') {
            Get-PnpDevice | Where-Object { $_.FriendlyName -like "*touch screen*" } | Disable-PnpDevice -Confirm:$false
        } # If device is not found
        else {
            Get-PnpDevice | Where-Object { $_.FriendlyName -like "*touch screen*" } | Enable-PnpDevice -Confirm:$false
        }
    }
    else {
        Write-Host "Device $deviceName not found."
    }
}

# Run the script block repeatedly at the specified interval
while ($true) {
    Start-Job -ScriptBlock $scriptBlock -ArgumentList $deviceName
    Start-Sleep -Seconds $interval
    Get-Job | Remove-Job # Remove completed jobs to avoid accumulation
}
