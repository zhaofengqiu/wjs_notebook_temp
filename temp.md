---
title: k近邻法
---

### k近邻法

算法描述：

输入：训练数据集

$$
T=\left \{ (x_1,y_1), (x_2,y_2),\cdot \cdot \cdot (x_N,y_N)\right \}
$$

其中，$x_i\in \chi \subseteq \mathbb R^{n}$为实例的特征向量，$y_i\in {Y} =\left \{ c_1,c_2,\cdot \cdot \cdot ,c_K \right \}$为实例的类别，$i=1,2,\cdot \cdot \cdot ,N$；实例特征向量$x$；

输出：实例$x$所属的类$y$。

（1）根据给定的距离度量，在训练集$T$中找出与$x$最邻近的k个点，涵盖这k个点的$x$的领域记作$N_k(x)$；

（2）在$N_k(x)$中根据分裂决策规则（如多数表决）决定$x$的类别$y$：

$$
y= arg\: \underset{c_j}{max} \sum _{x_i\in N_k(x)}I(y_i=c_j),i=1,2,\cdot \cdot \cdot ,K
$$

式中，$I$为指示函数，即当$y_i=c_j$时$I$为1，否则$I$为0




```
sources
├── 1-FirstChapter   // The first chapter，format: {orderNumber or alphabet}-{chapterName}.md
├────── 1-FirstDocument.md
├────── 5-SecondDocument.md  // concentrating solely on the order, not the numbers.
├── 3-SecondChapter                     // Focus only on the order, not the numbers.
├────── 1-FirstDocumentOfSecondChapter.md
├────── 2-SecondDocumentOfSecondChapter.md  
├── 7-ThirdChapter
├── FourthChapter  // May have no order
├── README.md // In addition to readme.md, not to put other markdown documents
└── book.json     // Set up the book
```


## Install

```
npm install -g gitbook-summary
```


## Using

1> Generate a `SUMMARY.md` Simply

```
$ cd /path/to/your/book/
$ book sm
```


or, For example:

```
$ book sm -r ../sailsjs-docs-gitbook/en -i 0home -u 'myApp' -c 'concepts, reference, userguides' -n "Sails.js 官方文档(中英合辑）"
```


To see the command line options:

```
$ book sm --help

  Usage: summary|sm [options]

  Generate a `SUMMARY.md` from a folder

  Options:

    -h, --help                    output usage information
    -r, --root [string]           root folder, default is `.`
    -t, --title [string]          book title, default is `Your Book Title`.
    -c, --catalog [list]          catalog folders included book files, default is `all`.
    -i, --ignores [list]          ignore folders that be excluded, default is `[]`.
    -u, --unchanged [list]        unchanged catalog like `request.js`, default is `[]`.
    -o, --outputfile [string]     output file, defaut is `./SUMMARY.md`
    -s, --sortedBy [string]       sorted by sortedBy, for example: `num-`, defaut is sorted by characters
    -d, --disableTitleFormatting  don't convert filename/folder name to start case (for example: `JavaScript` to `Java Script`), default is `false`

```


**Notes**： 
* The article title is taken from `title` property in the articles front-matter. If this property is not available, the articles filename will be used as title for the summary. 
* The option `-s` or `--sortedBy` can not be given `-` as argument, because commander.js will parse it an option. But you can set it in `book.json` as follows.  
* set up the sortedBy and if there are any summaries missing the order, look at the example below and follow,  
for example, you have summaries like this `01-elementry-school, 02-middle-school, 03-university, ...`  
you realized high school was missing, then You can make correct order in the following way  
eg. `01-elementry-school, 02-middle-school, 02a-high-school, 03-university, ...`  
not `01-elementry-school, 02-middle-school, 03-high-school, 04-university, ...`

2> Create a `book.json` in the book`s root folder

for example:

```
// test/books/config-json/book.json
{
    "title": "json-config-name",
    "outputfile": "test.md",
    "catalog": "all",  // or [chapter1，chapter2, ...]
    "ignores": [],  //Default: '.*', '_book'...
    "unchanged": [], // for example: ['myApp'] -> `myApp` not `My App`
    "sortedBy": "-",
    "disableTitleFormatting": true // default: false
}
```


then, you can do:

```
$ book sm
```


You will get a `test.md` file:

![test.md.jpg](doc/img/test.md.jpg)

3> Get a markdown artical from a html file or a remote url

```
$ book md -l "http://book.btcnodejs.com/index.html" -s "div.className"
```


You will get the 'index.html' and 'index.md'.

4> Get convert between zh and zh-tw, zh-hk, or zh-sg

```
$ book cv -f ./test/language/test.md -l zh-tw -t "./test/language/test2.md"
```


## eBooks

* 《Nodejs开发加密货币》： https://github.com/imfly/bitcoin-on-nodejs
* 《用Gitbook和Github轻松搭建自出版平台》： https://github.com/imfly/how-to-create-self-publishing-platform
* 《sails.js 官方文档 多语言电子书》：https://github.com/imfly/sailsjs-docs-gitbook

More Gitbooks : https://www.gitbook.com/@imfly

## Development

```
npm install
npm link
```


## Test

```
npm test
```


## Todo

- Convert articals between Simplified and Traditional Chinese.
- Generate eBooks(html, pdf, etc) by extending `gitbook`;

## Contribute

We love pull requests! You can `fork it` and commit a `pr`

## License

The MIT License
