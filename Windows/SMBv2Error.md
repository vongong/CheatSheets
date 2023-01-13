
# Can’t Access Shared Folder Because Security Policies Block Unauthenticated Guest Access

https://woshub.com/cannot-access-smb-network-shares-windows-10-1709/

```
Log Name: Microsoft-Windows-SmbClient/Security  
Source: Microsoft-Windows-SMBClient
Event ID: 31017
Rejected an insecure guest logon.
```

To enable guest access from your computer, you need to use the Group Policy Editor (gpedit.msc). Go to the section: Computer Configuration -> Administrative templates -> Network -> Lanman Workstation. Find and enable the policy Enable insecure guest logons. This policy option determines whether the SMB client will allow an unsafe guest logon to the SMB server. 

