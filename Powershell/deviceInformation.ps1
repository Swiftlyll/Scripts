Import-Module Microsoft.Graph.DeviceManagement

Connect-MgGraph -Scopes "DeviceManagementManagedDevices.Read.All", "DeviceManagementConfiguration.Read.All"

Get-MgDeviceManagementManagedDevice -ManagedDeviceId jz2qy04