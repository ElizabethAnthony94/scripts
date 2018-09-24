# Create Virtual Network, Subnets and Network Security group In Azure
##### This template :
* Creates a Virtual Network
* Creates Subnets
* Creates Network Security Group(NSG)
* Attaches the NSG to specific subnets

##### The parameters passed to this template via the parameter file are as follows:
* vnetName : This parameter specifies the name of the Virtual Network
* vnetAddressPrefix : This parameter specifies the address of the Virtual Network
* subnet1Name : This parameter specifies the name of the first Subnet
* subnet1Prefix : This parameter specifies the address of the first Subnet
* subnet2Name : This parameter specifies the name of the second Subnet
* subnet2Prefix : This parameter specifies the address of the second Subnet
* frontEndNSGName : This parameter specifies the name of the Front End Network Security Group
* backEndNSGName : This parameter specifies the name of the Back End Network Security Group


### Command to execute ARM template using Powershell:
New-AzureRMResourceGroupDeployment -Name "DeploymentName" -ResourceGroupName "testRG" -TemplateFile "Path to template.json" -TemplateParameterFile "Path to parameter.json" -Verbose