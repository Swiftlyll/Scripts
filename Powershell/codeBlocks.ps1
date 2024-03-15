# Encrypted Credentials
# $psCred =  ConvertFrom-SecureString -SecureString (ConvertTo-SecureString (Get-Credential) -AsPlainText -Force)