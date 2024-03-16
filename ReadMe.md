# This script will constantly run in the background to disable the touchscreen if a specified GPU is found or enable the touchscreen if the specified GPU is not found.


### **Find the GPU name by using this query**

	Get-PnpDevice | Where-Object { $_.FriendlyName -like *"My GPU"* }

Example:

	Get-PnpDevice | Where-Object { $_.FriendlyName -like *"4080* }


### **Add to task scheduler with the following parameters:**

-Run with highest privileges

-Run whether user is logged on or not

-Trigger

  At startup
  
-Actions

   Start a Program
  
   Program/script
      
	powershell
    
   Add arguments (optional)

	-ExecutionPolicy Bypass -command "C:\TEMP\DisableTouchifEGPUconnected.ps1"
      
-Conditions

   Uncheck all
  
-Settings:

   Only check Allow task to be run on demand
