backup database CompressionDemo
to disk = 'C:\Demo\CompressionDemo.bak'
--^ Items above are required
with init, format, stats = 10;
/* Options
    init = initalize; create new file
        Default behavior to append to file

*/