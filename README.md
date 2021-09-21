# test_go_embed

Tests the total size of files that can be added to a Go binary with embed.
Generates a series of main.go with embedded files which it tries to compile and run.
Stops when there is a compile or run error.

Suggest setting the TMP to somewhere that has 10s of GB of space to test.

# Running

    $ make
    
The output should look something like:

    $ make
    ./test_go_embed.sh
     
    ####START################### num files= 1  file size= 512000  MB  total size= 512000 MB
    rm: cannot remove 'test_embed_size': No such file or directory
    524288000
    f_524288000_0.data
    524288000
    # Building Go
    # Running Go
    f_524288000_0 : ¤
    f_524288000_0 : -
    ####END###################
    
     
    ####START################### num files= 2  file size= 512000  MB  total size= 1024000 MB
    524288000
    f_524288000_0.data
    f_524288000_1.data
    128000+0 records in
    128000+0 records out
    524288000 bytes (524 MB, 500 MiB) copied, 2.1669 s, 242 MB/s
    524288000
    # Building Go
    # Running Go
    f_524288000_0 : ¤
    f_524288000_0 : -
    f_524288000_1 : 	
    f_524288000_1 : 
    ####END###################
    
     
    ####START################### num files= 3  file size= 512000  MB  total size= 1536000 MB
    524288000
    f_524288000_0.data
    f_524288000_1.data
    f_524288000_2.data
    128000+0 records in
    128000+0 records out
    524288000 bytes (524 MB, 500 MiB) copied, 2.17622 s, 241 MB/s
    524288000
    # Building Go
    # Running Go
    f_524288000_0 : ¤
    f_524288000_0 : -
    f_524288000_1 : 	
    f_524288000_1 : 
    f_524288000_2 : Ï
    f_524288000_2 : ³
    ####END###################
    
     
    ####START################### num files= 4  file size= 512000  MB  total size= 2048000 MB
    524288000
    f_524288000_0.data
    f_524288000_1.data
    f_524288000_2.data
    f_524288000_3.data
    128000+0 records in
    128000+0 records out
    524288000 bytes (524 MB, 500 MiB) copied, 2.20314 s, 238 MB/s
    524288000
    # Building Go
    # github.com/gnewton/test_embed_size
    too much data in section SXCOFFTOC (over 2e+09 bytes)
    too much data in section SDATA (over 2e+09 bytes)
    make: *** [Makefile:3: default] Error 2
    gnewton@OptiPlex-7010:~/tmp/test_go_embed$ 
