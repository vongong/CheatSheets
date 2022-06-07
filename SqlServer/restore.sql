----------------------
--basic
restore database CompressionDemo
from disk = 'C:\Demo\CompressionDemo.bak'
with replace, stats = 10;
/*
    replace = when db exists and don't want to remove   
            if db doesn't exists, ignores
*/

----------------------
--Restore w move
restore filelistonly
from disk = 'C:\Demo\CompressionDemo.bak';


restore database CompressionDemo
from disk = 'C:\Demo\CompressionDemo.bak'
with stats = 10
,replace
,move 'CompressionDemo' to 'C:\MyNewDB\CompressionDemo.mdf'
,move 'CompressionDemoLog' to 'C:\MyNewDB\CompressionDemoLog.ldf'
;

----------------------
--Restore w different name
restore database CompressionDemoDev
from disk = 'C:\Demo\CompressionDemo.bak'
with stats = 10
,replace
,move 'CompressionDemo' to 'C:\MyNewDB\CompressionDemoDev.mdf'
,move 'CompressionDemoLog' to 'C:\MyNewDB\CompressionDemoLogDev.ldf'
,move 'FG1File' to 'C:\MyNewDB\FG1FileDev.ndf'
,move 'FG2File' to 'C:\MyNewDB\FG2FileDev.ndf'
;

restore database CompressionDemoArchive
from disk = 'C:\Demo\CompressionDemo.bak'
with stats = 10, replace;

----------------------
--Restore logs 
--Note: think as vhs. play logs chronologically
--      each one NEEDS to have a begin and end to be recovered

restore database CompressionDemo
from disk = 'C:\Demo\CompressionDemo.bak'
with stats = 10, norecovery; --don't run through the undo process (of recovery).

restore log CompressionDemo
from disk = 'C:\Demo\CompressionDemoLog1.trn'
with stats = 10, norecovery;

restore log CompressionDemo
from disk = 'C:\Demo\CompressionDemoLog2.trn'
with stats = 10, norecovery;

restore log CompressionDemo
from disk = 'C:\Demo\CompressionDemoLog3.trn'
with stats = 10, norecovery; --if last, norecovery isn't needed. just ignored.

restore database CompressionDemo
with recovery;      --runs recovery process. now fully operational

--standby mode (replace norecovery w standby)
--same as recovery, but read-only 
restore database CompressionDemo
from disk = 'C:\Demo\CompressionDemo.bak'
with stats = 10, standby = 'C:\Demo\Restore.txt' ;

--... same as log1, log2, log3, replace norecovery w standby

restore database CompressionDemo
with recovery;      --runs recovery process. now fully operational

--differentials
restore database CompressionDemo
from disk = 'C:\Demo\CompressionDemo.bak'
with stats = 10, norecovery;

restore database CompressionDemo
from disk = 'C:\Demo\CompressionDemo.diff'
with stats = 10, norecovery;

--follow with logs after diff
--restore /w recovery
