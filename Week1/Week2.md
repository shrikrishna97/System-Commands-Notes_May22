## Week 2 Notes

* Multiple uses of `/` are as good as one
  - i.e.: `cd usr//////bin` will take you to `usr/bin`
* The root folder ` /` is its own parent
  - i.e.: if you do `cd ..` within the root directory you stay in the same directory.
* Options ` / ` Flags can be written in multiple combinations
  - `ls -l level1 -di`
  - `ls -d level1 -il`
  - `ls level1 -ldi`
  - `ls -ldi level1`
 * long formats for options are also available
  - `ls -a` is equivalent to `ls --all`


### Commands
* `ls`
  - `R` flag lists all subdirectories recursively 
  - Passing the directory name to `ls` shows what is within that directory. i.e. : `ls -l level1` 
  - `d` flag displays details of a folder without traversing inside it. i.e.: `ls -ld level1` 
  - 
* `ll`
  - a shortcut for the `ls -la` command
* `which`
  - `which` *command* will show the location of the command
  - `which less` will show `usr/bin/less`
* `whatis`
  - gives a brief description of the command
* `alias` 
  - give a nickname to a frequently used command
  - usage : `alias ll = 'ls -l'`
  - Just typing alias will show a list of aliases
  - `alias date = 'date -R'`
  - If the command is executed by typing the whole path, 
  - e.g.: `/usr/bin/date` the alias is not invoked. (`cd /usr/bin` and `./date`)
  - An alias can be escaped by prefixing a `\` i.e. : `\date`
* `unalias` 
  - used to remove an alias
* `rmdir`
  - removes an empty directory
* `ps`
  - displays current processes
  - `ps --forest` - which process has launched which child process.
  - `ps -f` - displays parent process id
  - `ps -ef` - all the processes running in the operating system now
  - PID is the process ID, and PPID is the parent process ID.
  - PID 1 is `/sbin/init`
* `bc` - bench calculator 
  - exit using `Ctrl`+`D`

### Commands to know the contents of a text file

* `less`
  - displays the content on one screen
  - `ls -l /usr/bin/less` shows that the command takes 180KB
* `wc`
  - prints newline, word, and byte counts for the file
  - the `-l` flag shows just the number of lines
* `head`
  - `head` profile displays the first ten lines
  - use `-n` flag to specify the number of lines
* `tail`
  - `tail` profile displays the last ten lines
  - use `-n` flag to specify the number of lines to be displayed
* `cat`
  - in `/etc`, `cat` profile would just dump contents on the screen without any further prompts.
  - disadvantages: cant move back and forth to view page by page, can't come out halfway through.
  - if the file is very long, `cat` is not the best way to look at the content.
* `more`
  - similar to `less`. Allows page by page viewing
  - `ls -l /usr/bin/more` shows that the command takes 43KB

### Knowing more commands
* `man`
* `which`
* `apropos`
  - For a keyword, it shows you all the commands which have that keyword in the description
  - Used to discover new commands
  - If you type `ls -l /usr/bin/apropos` you see that it is a symbolic link to `whatis`, but the outputs are different: Why?
  - Reason: In Linux, every executable will know in what name it has been invoked - can have different behavior depending on the name that invoked it.
  - It also has the same output as `man -k` : Searching for a keyword
* `info`
  - Allows browsing through commands using the cursor 
  - Can go back using `<` or `'shift'+','`
* `whatis`
* `help`
  - displays keywords reserved for the shell being run
* `type`
  - displays what type of command it is 
  - `type` shows that it is a 'shell built in' being offered from the shell and not the os
  - `type ls` shows that it is aliased with some option. which `ls` shows that it is coming from os because there is an executable available.
 ### Multiple Arguments
 * ##### Recap: Arguments and Options
  - Options are enhanced features of the command
  - Arguments are specific names of files or directories 
 * Second argument behavior and interpretation of the last argument should be seen in the man pages
 * Recursion is assumed for `mv` and not `cp`
  - recursion is assumed for some commands and should be explicitly stated in others
  - For `copy` command, recursion is not assumed
  - `cp dir1 dir2` need not work. dir1 has 2 files in it.
  - `cp -r dir1 dir2` works - recursion is specified explicitly.
  - `mv dir1 dir3` works - it just renames the directory.
 * `touch file1 file2 file3` creates all 3 files in one go with an identical timestamp.

 ### Links (Hard Links and Soft Links)
* Can determine whether a link is HL or SL by looking at the Inode numbers
  - Hard links will have the same inode numbers
  - Soft Link will have different inode numbers 
  - If you delete a certain file using the `rm` command (`rm` unlinks the file from the filesystem. the data is still at the memory location. `shred` for permanent deletion)
    - Its hard link will still give you access to the original file data.
    - Its soft link will not work 
* `ln -s source destination` to create a symbolic link. `ln -s file1 file2`
  - file2 is a separate inode entry but it is just a shortcut to file1
  - file2 has only 1 hard link.
* `ln source destination` to create a hard link . `ln file1 file3`
  - file1 and file 3 have the same inode number - They are the same file.
  - file1 and file3 have 2 hard links when we do `ls -li`
* You can create a Soft Link `ln -s ../dir/filex fileSL` but creating a hard link using `ln ../dir/filex fileHL` will not work.
  - the first/source-file parameter is interpreted in the case of hard link creation and not in soft link creation
  - In the above example, assume that `../dir/filex` does not exist.
  - soft links useful in version control systems

### File Sizes 
* `ls -s`
  - file size appears in the first column
* `stat`
  - in `/usr/bin` we look at `stat znew`
  - Gives information about the size, and how many blocks are being occupied
  - Here the size is little more than 4kb
  - `stat zmore` shows that it takes less than one block
* `du`
  - in `/usr/bin` we look at `du znew` or `du -h znew`
  - Gives information about the size
  - Here the size is displayed as 8.0KB since there is a block overflow.
  - This means that files that are smaller than the block size will  take up a whole block
  - `du -h zmore` shows that it occupies one block - around 4.0K
* Role of block size
  - explained in stat and du

### In-Memory File Systems
* `/proc`
  - Is an older system 
  - `ls -l` will display several zero-size files, even though we can read content from them.
  - These are only a representation and not real files on the HDD.
  - `less cpuinfo` - information about the CPU
  - `cat version` - information about the OS. Also accessible using `uname -a`
  - `cat meminfo` - information about the memory - also `free -h`
  - `cat partitions` - information about the partitions - also `df -h` 
  - The `kcore` file appears to take huge space - Shows the maximum virtual memory that the current Linux os can handle. 2^47 or 140 TB
* `/sys`
  - Used from Kernel v2.6 onwards, however, information about various processes that are running are still stored in the `/proc` directory itself.
  - Much more well organized than `/proc`
  - eg : `sys/bus/usb/devices/1-1` points to a specific usb device. 
* These are directories that are visible in the root folder. They are not on the disk but only in the memory.
* Important system information can be viewed from these directories in a read-only manner.

### $hell Variables 
* Makes it possible to communicate between 2 processes very efficiently. Need not write and read the filesystem.
* Security Concern : Some information that you write to the filesystem may be visible to other processes.
* Shell variables are available only within the shell or its child processes.
* `echo` prints strings to the screen
  - uses space as a delimiter so multiple spaces between words are ignored. For multiple spaces, enclose the string in quotes.
  - can print a multi-line string by using double quotes and not closing it
  - **The difference between `'` and `"`**
  - `echo $USERNAME` and `echo "$USERNAME"` give the same result but `echo '$USERNAME'` is not interpreted to give the value of the shell variable.
  - ** Escaping to prevent interpretation **
  - `echo "username is $USERNAME and hostname is \$HOSTNAME"`
  - Escaping is useful when you want to pass on the information to a child shell, without it being interpreted by the shell launching it.
* `echo $HOME` prints values of variables
  - By convention, every shell variable starts with a Dollar
* **Commonly used shell variables**
  - `$USERNAME` e.g.: `echo "User logged into the system now is: $USERNAME"`
  - `$HOME`
  - `$HOSTNAME`
  - `$PWD`
  - `$PATH` - variable contains a list of directories that will be searched when you type a command. Whenever you type a command the system scans these paths from left to right to see if the command is in the directory.
* Commands like `printenv`, `env`, `set` to see variables that are already defined
  - `printenv` Displays all the shell variables defined in the shell that you are running.
  - `env` gives the same output
  - `set` displays some functions defined to interpret what you are typing on the command line.
* **Special Shell Variables**
  - `$0`: name of the shell eg `bash` or `ksh`
  - `$$`: process ID of the shell 
  - `$?`: return code of previously run program
  - `$-`: flags set in the bash shell. The man page for bash shows the meaning of the flags.
* **Process Control** `echo $$`
  - use of `&` to run a job in the background
  - `fg` - bring the process to the foreground
  - `coproc` - run a command while also being able to use the shell
  - `jobs` - list programs running in the background
  - `top` - See programs that are hogging the CPU or memory (refreshed every second)
  - `kill` - kill process owned by you 
* **Program Exit Codes** `echo $?` 
  - exit code always has a value between *0 and 255*
  - 0: Success
  - 1: Failure
  - 2: Misuse (insufficient permissions)
  - 126 : command cannot be executed (usually due to insufficient permissions to execute a file)
  - 127 : command not found (usually due to command typos)
  - 130: processes killed using `ctrl + c`
  - 137: processes killed using `kill -9 <pid>`
  - If the exit code is more than 256 then the exitcode%256 will be reported as the exit code
  - `exit 0` or `exit 1` or `exit <n>` exits with exit code n
  - Used when there are command dependencies (i.e.: run the second command only if the first command completes successfully)
* **Flags set in bash** `echo $-`
  - h: locate hash commands
  - B: brace expansion enabled
  - i: interactive mode
  - m: job control enabled (can be taken to bg or fg)
  - H: !style history substitution enabled
  - s: commands are read from stdin
  - c: commands are read from arguments

### Linux Process Management
* `sleep` command to create processes
  - usage : `sleep 3` for 3 seconds
* If you have a command running in the Foreground for a long time but you need to write something else on the command line :
  - kill the process
  - suspend the process
  - run it in the background `coproc sleep 10` - When complete it gives a message.
* `coproc` is a shell keyword. No manual entry for it.
  - To learn more about a shell keyword use `help coproc`
  - a running background process can be killed by process id (use : `ps --forest` to find PID and `kill -9 <pid>`)
* A command followed by an `&` means that it is being assigned to the background
  - Executing the command `fg` will bring it back to the foreground
* `jobs` is a shell built-in - it lists active jobs in the current shell
* `top` shows processes taking up maximum CPU and memory. Exit gracefully by pressing `q`
* `Ctrl`+`z` suspends a process.
  - Suspended processes can be seen with `jobs`
  - Can be brought back to the foreground using the `fg` command
* `Ctrl`+`c` kills a process
* `fg` is a shell built-in
* `bash -c "echo \$-"` creates a child shell, gets the value of `echo $-`, and gives the output to the parent shell
  - `bash -c "echo \$-; ps --forest;"` - multiple commands separated by ;
  - `bash -c "echo \$$ ; ps --forest ; exit 300"` : custom error code mod 256 = 44
* `history` displays a list of commands that have been run on that computer
  - `!n` executes command line no n displayed by the `history`
  - useful for repeating long commands
  - The `H` flag in bash means the history is being recorded
* Brace expansion option `B`
  - if you type `echo {a..z}` character in the ASCII sequence will be expanded.
  - In combination `echo {a..d}{a..d}` will display all possible combinations of the 2 alphabets.
  - `*` expands to all the files in the current directory
  - `echo D*` lists all the files beginning with D.
  - Examples :
    - `mkdir {1..12}{A..E}` or `rmdir {1..12}{A..E}` or `touch {1..12}{A..E}/{1..40}`
* `;` acts as a separator between individual commands eg : `echo hello ; ls`



### Shell Variables 

* Creation, inspection, modification, lists

* Creating a variable

  - `myvar="value string"`
    - `myvar` can't start with a number, but you can mix alphanumeric and `_`
    - No space around the `=`
    - `"value string"` is the number, string, or `command`. The output of a command can be assigned to myvar by enclosing the command in back-ticks.

  ![image-20220607134006038](https://github.com/shrikrishna97/System-Commands-Notes_May22/blob/main/Week1/static/image-20220607134006038.png)

* Exporting a variable

  - `export myvar="value string"` or
  - `myvar="value string" ; export myvar`
  - This makes the value of the variable available to a shell that is spawned by the current shell.

* Using variable values

  - `echo $myvar`
  - `echo ${myvar}`
    - can manipulate the value of the variable by inserting some commands within the braces.
  - `echo "${myvar}_something"` 

* Removing a variable

  - `unset myvar`
  - Removing the value of a variable `myvar=`

* Test if a variable is set

  - `[[ -v myvar ]] ; echo $? `
    - 0: success (variable myvar is set)
    - 1: failure (variable myvar is not set)
  - `[[ -z ${myvar+x} ]] ; echo $?`  (the `x` can be any string)
    - 0:success (variable myvar is not set)  
    - 1:failure (variable myvar is set)

* Substitute default value

  - If the variable `myvar` is not set, use "default" as its default value
  - `echo ${myvar:-"default"}`
    - if `myvar` is set display its value
    - else display "default"

* Set default value

  - If the variable `myvar` is not set then set "default" as its value 
  - `echo ${myvar:="default"}`
    - if `myvar` is set display its value
    - else set "default" as its value and display its new value

* Reset value if the variable is set

  - If the variable `myvar` is set, then set "default" as its value
  - `echo ${myvar:+"default"}`
    - if `myvar` is set, then set "default" as its value and display the new value
    - else display null 

* List of variable names

  - `echo ${!H*}`
    - displays the list of names of shell variables that start with H

* Length of a string value

  - `echo ${#myvar}`
    - Display length of the string value of the variable `myvar`
    - if `myvar` is not set then display 0

* Slice of a string value

  - `echo ${myvar:5:4}` (5 is the offset and 4 is the slice length)
    - Display 4 characters of the string value of the variable `myvar` after skipping the first 5 characters.
  - if the slice length is larger than the length of the string then only what is available in the string will be displayed.
  - the offset can also be negative. However, you need to provide a *space* after the *:* to avoid confusion with the earlier usage of the `:-` symbol. The offset would come from the right-hand side of the string.

* Remove matching pattern

  - `echo ${myvar#pattern}` - matches once
  - `echo ${myvar##pattern}` - matches maximum possible
  - Whatever is matching the pattern will be removed and the rest of it will be displayed on the screen.

* Keep matching pattern

  - `echo ${myvar%pattern}` - matches once
  - `echo ${myvar%%pattern}` - matches maximum possible

* Replace matching pattern

  - `echo ${myvar/pattern/string}` - match once and replace with string
  - `echo ${myvar//pattern/string}` - match max possible and replace with string

* Replace matching pattern by location

  - `echo ${myvar/#pattern/string}` - match at begining and replace with string
  - `echo ${myvar/%pattern/string}` - match at the end and replace with string

* Changing case

  - `echo ${myvar,}` - Change the first character to lower case.
  - `echo ${myvar,,}` - Change all characters to lower case.
  - `echo ${myvar^}` - Change the first character to uppercase
  - `echo ${myvar^^}` - Change all characters to upper case
  - The original value of the variable is not changed. Only the display will be modified as the trigger commands are within braces.

* Restricting value types

  - `declare -i myvar` - only integers assigned 
  - `declare -l myvar` - Only lower case chars assigned
  - `declare -u myvar` - Only upper case chars assigned
  - `declare -r myvar` - Variable is read-only
  - Once a variable is set as read-only you may have to restart the bash to be able to set it 

* Removing restrictions

  - `declare +i myvar` - integer restriction removed 
  - `declare +l myvar` - lower case chars restriction removed
  - `declare +u myvar` - upper case chars restriction removed
  - `declare +r myvar` - *Can't do once it is read-only*

* Indexed arrays

  - `declare -a arr`
    - Declare `arr` as an indexed array
  - `arr[0]="value"`
    - Set value of element with index 0 in the array
  - `echo ${arr[0]}`
    - Value of element with index 0 in the array
  - `echo ${#arr[@]}`
    - Number of elements in the array. The `@` symbol is a wild character to run through all the elements in the array
  - `echo ${!arr[@]}`
    - Display all indices used
  - `echo ${arr[@]}`
    - Display values of all elements of the array
  - `unset 'arr[2]'`
    - Delete element with index 2 in the array
  - `arr+=("value")`
    - Append an element with a value to the end of the array

* Associative arrays

  - `declare -A hash`
    - declare `hash` as an associative array
  - `$hash["a"]="value"`
    - set the value of element with index a in the array
  - `echo ${hash["a"]}`
    - value of element with index a in the array
  - `echo ${#hash[@]}`
    - number of elements in the array
  - `echo ${!hash[@]}`
    - display all indices used
  - `echo ${hash[@]}`
    - display values of all elements of the array
  - `unset ‘hash["a"]’`
    - delete an element with index a in the array
  - Can do everything in the indexed array except append because there is nothing called the end of the array as there is no sequence for the elements of a hash

* Examples

  - `true` always returns exit code 0
  - `false` always returns exit code 1 (Check with `echo $?`)
  - To check whether a variable is present
    - `[[ -v myvar ]] ; echo $?` returns 1 if the variable is not present in the memory
    - `[[ -z ${myvar+x} ]] ; echo $? ` returns 0 if variable is not present and 1 if it is present. `x` is a string that will be used as a replacement if the variable was not present.
  - Use of Braces
    - `myvar=FileName`
    - `echo $myvar`
    - `echo "$myvar.txt"` prints FileName.txt
    - `echo "$myvar_txt"` does not print anything as the variable `myvar_txt` does not exist
    - `echo "${myvar}_txt"` prints Filename_txt 
    - Braces are useful in stating clearly the name of the variable.
    - Can also be used outside quotes `echo ${myvar}`
  - Does the variable we have created get passed on to the shell or any other program created within the shell?
    - `myvar=3.14 ; echo $myvar`
    - `bash` one more level of bash
    - `ps --forest` to show that we are one level below
    - `echo $myvar` not present
    - Use `export myvar=3.14` to ensure this variable is available to all spawned subshells.
    - Change the value of a variable within the child shell
    - modification of value is not reflected in the value of the variable in the parent shell
    - even if you do export of the variable within the child shell it will not change the value within the parent shell.
  - Use of back-ticks
    - `` mydate=`date` `` value of `mydate` will be the output of the `date` command.
    - `` mydate=`echo Sunday that is today`; echo $mydate ``
  - Manipulations for variables within the shell environment
    - We would like to have echo display a default value if the variable is not available
    - `` echo ${myvar:-hello} `` the `-` indicates if the value is not present what is the display value
    - `` echo ${myvar:-"myvar is not set"} ``
    - Set the value if it was not set already
    - `` echo ${myvar:=hello} `` if absent / not set then set it to the value after `=`
    - If it is present it will not change
    - `` echo ${myvar:?"myvar is not set"} `` displays a little more information and a debug message. `bash: myvar: myvar is not set`
    - Unset the value of a variable using `unset myvar`
    - ``echo ${myvar:+HELLO}`` displays the message if the variable is present
  - Inspecting all the variables in the shell environment
    - `printenv`
    - `env`
    - `echo ${!H*}` displays the names of variables beginning with 'H' - `!` indicates the names of the variables instead of value.
  - Counting characters
    - `` mydate=`date` `` stores the output of the `date` command in `mydate`
    - `echo ${#mydate}` prints the length of the value present in `mydate`.
    - length of a non-existing variable is zero
  - Features of using colon : within braces {}
    - Extracting part of a string from the value of a particular variable.
      - `echo ${mydate:6:10}`
      - `echo ${myvar:3:3}` will print `def` for `myvar=abcdefg` ie: 3 characters after the offset (position 3)
    - Using negative offset
      - `echo ${myvar: -3:3}` and `echo ${myvar: -3:4}` will print `efg` for `myvar=abcdefg`
        - note `-` is to be preceded with a blank to avoid confusion
        - asking for more characters will print just what is available
      - `echo ${myvar: -3:2}` will print `ef` for `myvar=abcdefg`
    - Extracting a portion of the date
      - The output of `date` is `Tuesday 25 January 2022 09:10:20 PM IST`
      - Output of `date +"%d %B %Y"` is `25 January 2022`
      - if `` mydate=`date` `` then `echo ${mydate:8:16}` will also print `25 January 2022`
    - Extracting patterns from a string
      - `myvar=filename.txt.jpg`
      - `echo ${myvar#*.}` minimal matching displays `txt.jpg`
      - `myvar=filename.somethingelse.jpeg`
      - `echo ${myvar##*.}` maximal matching displays `jpeg`
      - `echo ${myvar%*.}` displays filename.somethingelse
        - the `%` is used to indicate what has not been matched. (minimal)
      - `echo ${myvar%%*.}` displays filename
        - the `%` is used to indicate what has not been matched. (maximal)
      - Can be combined `echo ${myvar%%.*}.${myvar##*.}` to get `filename.jpeg`
     - Replacing what has been matched
      - Pattern matching in Linux usually goes with a pair of forwarding slashes.
      - Convert all `e` to `E` in a string
        - `echo ${myvar/e/E}` replaces only the first occurrence of `e`
        - `echo ${myvar//e/E}` replaces all occurances of `e`
      - Replace characters at the beginning of a string
        - `echo ${myvar/#f/F}` replaces the occurrence of `f` at the beginning of the string with `F`. The `#` indicates the beginning of the string
      - Replace characters at the end of a string
        - `echo ${myvar/%g/G}` replaces the occurrence of `g` at the end of the string with `G`. The `%` indicates the end of the string.
      - Replace jpeg with jpg, only if it is at the end of a string
        - `echo ${myvar/%jpeg/jpg}`
     - Modifying and storing it in a variable
       - `` myvar1=`echo ${myvar//jpeg/jpg}` ``
     - Generic command to remove a day from the date
       - `echo ${mydate#*day}`
     - Upper case to lower case and vice-versa
       - `echo ${mydate,}` changes the first character to lowercase
       - `echo ${mydate,,}` converts all characters to lowercase
       - `echo ${mydate^}` changes the first character to uppercase
       - `echo ${mydate^^}` changes all characters to uppercase
     - Restricting values that can be assigned to shell variables using `declare`
       - `declare` is a shell built-in
       - `+` to **unset** a restriction and `-` to **set** it  (Note : counterintuitive )
       - `-a` for indexed arrays (need not be ordered indexes)
       - `-A` for associative arrays (dictionaries)
       - `-i` for integers
       - `-u` for uppercase conversion on assignment
       - Integer restriction
         - `declare -i mynum`
         - `mynum=10` will assign 10 to mynum
         - `mynum=hello` will assign 0 to mynum
       - lowercase restriction
         - `declare -l myvar`
         - `myvar=hello` assigns hello to myvar
         - `myvar=BELLOW` converts BELLOW to lowercase and assigns it to myvar.
       - removing a restriction
         - `declare +l myvar`
         - the value is still contained after removing the restriction but you can now store upper case characters as well
       - declaring a read-only variable
         -  `declare -r myvar`
         -  once a variable has been set as read only, you cannot change its value and you cannot remove the read-only restriction using `+r`
         -  `declare +r myvar` gives the error `bash: declare: myvar: readonly variable`
      - Arrays
        - `declare -a arr`
        - `arr[0]=Sunday`
        - `arr[1]=Monday`
        - `echo ${arr[0]}`
        - `echo ${arr[1]}` 
        - `echo ${#arr[@]}` gives number of elements in the array
        - `echo ${arr[@]}` displays all values
        - `echo ${!arr[@]}` displays the indices`
        - You can have any index without filling up intermediate indices. Indices are not necessarily contiguous.
        - `arr[100]=Friday` is also valid
        - Removing an element from an array = `unset 'arr[100]'`
        - Appending to an array `arr+=(Tuesday)`
        - Populating an array in one go `arr=(Sunday Monday Tuesday)` . The indices are sequential
      - Associative Arrays / Hashes
        - `declare -A hash`
        - `hash[0]="Amal"`
        - `hash["mm12b001"]="Charlie"`
        - `echo ${!hash[@]}` to get indices
        - `echo ${hash["mm12b001"]}`
      - File names in a shell variable 
        - ``myfiles=(`ls`) ``
        - `echo ${myfiles[@]}

### REPLIT CODE WITH US

[Link to Replit](https://replit.com/team/22t2SystemCommands)

- `date -d "2024-04-01" +%A` - Day of the week for a given date
- `file --mime-type somefile` - mime type of a given file 
- `mkdir {1..12}{A..E}`
- `rmdir {1..12}{A..E}`
- `touch {1..12}{A..E}/{1..40}`
- `lscpu | grep -i "model name"| cut -d ":" -f "2"`
