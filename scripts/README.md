# scripts

Poorly-written scripts I've made.

### watchmarkdown and watchmarkdownposix
Watches files ending in common Markdown extensions (.md, markdown, etc...) and converts them into HTML whenever they're modified. Can also watch directories containing Markdown files.

Depends on [inotify-tools](https://github.com/rvoicilas/inotify-tools/wiki) and [markdown](http://daringfireball.net/projects/markdown/). You'll need a version of `grep` that supports the `-q`, `-i`, and `-E` flags. Yours probably does.

The POSIX version doesn't have colored output.

### watchmarkdown-pdf
Same as **watchmarkdown**, but produces PDFs, not HTML.

Depends on [inotify-tools](https://github.com/rvoicilas/inotify-tools/wiki) and [markdown-pdf](https://github.com/alanshaw/markdown-pdf) (the standalone executable).

### whatsmyip
Fetches your external and internal IP addresses and displays them in the terminal. Only for IPv4 at the moment. It won't fetch your internal IP if it can't fetch your external IP (you can copy the internal IP command from the script and run it yourself though if this is the case.)

### replaceall
Kludgy script to replace all instances of a string in a file with another string. The `-i` flag can be passed to make it case insensitive. The `-h` flag prints its usage.

Note that it has to load the *whole* file into memory to edit it. Use with caution.
