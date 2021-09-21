# test_go_embed

Tests the total size of files that can be added to a Go binary with [embed](https://pkg.go.dev/embed).
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
    128000+0 records in
    128000+0 records out
    524288000 bytes (524 MB, 500 MiB) copied, 2.15716 s, 243 MB/s
    524288000
    # Building Go
    -rwxrwxr-x 1 gnewton gnewton 502M Sep 20 20:45 ./test_embed_size
    # Running Go
    f_524288000_0 : `
    f_524288000_0 : a
    ####END###################
    
     
    ####START################### num files= 2  file size= 512000  MB  total size= 1024000 MB
    524288000
    f_524288000_0.data
    f_524288000_1.data
    128000+0 records in
    128000+0 records out
    524288000 bytes (524 MB, 500 MiB) copied, 2.13479 s, 246 MB/s
    524288000
    # Building Go
    -rwxrwxr-x 1 gnewton gnewton 1002M Sep 20 20:46 ./test_embed_size
    # Running Go
    f_524288000_0 : `
    f_524288000_0 : a
    f_524288000_1 : Y
    f_524288000_1 : Â
    ####END###################
    
     
    ####START################### num files= 3  file size= 512000  MB  total size= 1536000 MB
    524288000
    f_524288000_0.data
    f_524288000_1.data
    f_524288000_2.data
    128000+0 records in
    128000+0 records out
    524288000 bytes (524 MB, 500 MiB) copied, 2.18658 s, 240 MB/s
    524288000
    # Building Go
    -rwxrwxr-x 1 gnewton gnewton 1.5G Sep 20 20:47 ./test_embed_size
    # Running Go
    f_524288000_0 : `
    f_524288000_0 : a
    f_524288000_1 : Y
    f_524288000_1 : Â
    f_524288000_2 : ä
    f_524288000_2 : 
    ####END###################
    
     
    ####START################### num files= 4  file size= 512000  MB  total size= 2048000 MB
    524288000
    f_524288000_0.data
    f_524288000_1.data
    f_524288000_2.data
    f_524288000_3.data
    128000+0 records in
    128000+0 records out
    524288000 bytes (524 MB, 500 MiB) copied, 2.20701 s, 238 MB/s
    524288000
    # Building Go
    # github.com/gnewton/test_embed_size
    too much data in section SXCOFFTOC (over 2e+09 bytes)
    too much data in section SDATA (over 2e+09 bytes)
    make: *** [Makefile:3: default] Error 2
    $ 

# Example Go program
Below is what is produced with the default values, for 3 embedded files:

    package main
    import _ "embed"
    //go:embed f_524288000_0.data
    var f_524288000_0 []byte
     
    //go:embed f_524288000_1.data
    var f_524288000_1 []byte
     
    //go:embed f_524288000_2.data
    var f_524288000_2 []byte
     
    //go:embed f_524288000_3.data
    var f_524288000_3 []byte
     
    func main() {
    
    
        print("f_524288000_0", " : ", string(f_524288000_0[0]), "\n")
        print("f_524288000_0", " : ", string(f_524288000_0[len(f_524288000_0)-1]), "\n")
        print("f_524288000_1", " : ", string(f_524288000_1[0]), "\n")
        print("f_524288000_1", " : ", string(f_524288000_1[len(f_524288000_1)-1]), "\n")
        print("f_524288000_2", " : ", string(f_524288000_2[0]), "\n")
        print("f_524288000_2", " : ", string(f_524288000_2[len(f_524288000_2)-1]), "\n")
        print("f_524288000_3", " : ", string(f_524288000_3[0]), "\n")
        print("f_524288000_3", " : ", string(f_524288000_3[len(f_524288000_3)-1]), "\n")
    
    }
    
