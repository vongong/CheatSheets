# Mount a Linux disk in WSL 2
- [ms doc](https://learn.microsoft.com/en-us/windows/wsl/wsl2-mount-disk)

## Mounting an unpartitioned disk
- Identify Disk: `GET-CimInstance -query "SELECT * from Win32_DiskDrive"`
- Mount Disk: `wsl --mount <DiskPath>`
  - ie: `wsl --mount \\.\PHYSICALDRIVE3`

## Mounting an partitioned disk
- Identify Disk: `GET-CimInstance -query "SELECT * from Win32_DiskDrive"`
- Mount Disk: `wsl --mount <DiskPath> --base`
- List Partition in WSL: `lsblk`
- Identify filesystem in WSL: `blkid <BlockDevice>`
- Mount the selected partitions: `wsl --mount <DiskPath> --partition <PartitionNumber> --type <Filesystem>`

## Unmounting Disk
- Unmounting Disk: `wsl --unmount <DiskPath>`

## Mounting an partitioned disk knowing partition type
- Identify Disk: `GET-Disk`
- Identify Partition: `GET-Partition -DiskNumber <DiskNbr>`
- Mount the selected partitions: `wsl --mount <DiskPath> --partition <PartitionNumber> --type <Filesystem>`
