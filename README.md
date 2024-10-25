# Ruby Tail command

Ruby script to implement `tail` command from Linux: https://man7.org/linux/man-pages/man1/tail.1.html

## Usage

`ruby tail.rb [options]...[file]`

### Options

- `-f`: Follow the file.
- `-n`: Number of lines to display.

### Examples

```
➜  ruby tail.rb sample.txt
line number 1
line number 2
line number 3
line number 4
line number 5
```

```
➜  ruby tail.rb -n 5 sample.txt
line number 5
line number 7
line number 8
line number 9
line number 10
```

```
➜  ruby tail.rb -f sample.txt
line number 1
line number 2
line number 3
line number 4
line number 5
[new lines are added]
```
