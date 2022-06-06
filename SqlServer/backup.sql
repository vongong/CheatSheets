--------------------------------------------
--Full Backups
backup database CompressionDemo
to disk = 'C:\Demo\CompressionDemo.bak'
with init, format, stats = 10;
/* Options
    init = initalize; recreate new file - always have newest
        Default behavior to append to file
    format = reformatted. prevent corruption.
    stats = show completion stats as running - every x Percent
    compression?
*/

--striping
backup database CompressionDemo
to disk = 'C:\Demo\CompressionDemo1.bak', 
disk = 'C:\Demo\CompressionDemo2.bak'       --add striping
with init, format, stats = 10;

--Diff Backup
backup database CompressionDemo
to disk = 'C:\Demo\CompressionDemo.bak'
with init, format, differential, stats = 10;

--filgroup Backups
backup database CompressionDemo
filegroup = 'FG1'
to disk = 'C:\Demo\CompressionDemo.bak'
with init, format, stats = 10;

--Log Backup
backup log CompressionDemo
to disk = 'C:\Demo\CompressionDemoLog1.trn'
with format, stats = 10;

--------------------------------------------
/* Notes:
can't master log
*/
