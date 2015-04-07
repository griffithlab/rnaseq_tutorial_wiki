#1-ii. Syntax

In this tutorial, created using [Github Flavored Markdown](https://help.github.com/articles/github-flavored-markdown), [fenced code blocks](https://help.github.com/articles/github-flavored-markdown/#fenced-code-blocks) are optional portions of the tutorials whereas [indented code blocks](http://daringfireball.net/projects/markdown/syntax#precode) are required to complete the tutorial.

A fenced code block will look like this:
```bash
sudo apt-get install tree
cd ~
tree -I tools 
```

An indented code block will look very similar in the wiki but will be interpreted differently when this tutorial is parsed:

    sudo apt-get install tree
    cd ~
    tree -I tools 

To make the Markdown files bash/shell compatible, a script will add a comment or '#' character to all lines that are NOT indented with a TAB character.

In text form, all lines starting with a '#' are comments and will not be executed.  Therefore, [fenced code blocks](https://help.github.com/articles/github-flavored-markdown/#fenced-code-blocks) will be ignored when converted to a bash script.

| [[Previous Section|Citation]] | [[This Section|Syntax]]  | [[Next Section|Intro-to-AWS-Cloud-Computing]] |
|:----------------------------:|:------------------------:|:------------------------------------------:|
| [[Citation|Citation]]          | [[Syntax|Syntax]]        | [[Intro to AWS Cloud Computing|Intro-to-AWS-Cloud-Computing]]       |
