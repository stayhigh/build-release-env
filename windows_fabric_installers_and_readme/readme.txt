#step1: run the command below
python ez_setup.py setuptools

#step2: ADD C:\Python27\Scripts in you Env PATH for easy_install command

#install pip with easyinstall tools
easyinstall pip

#install prarmiko
pip install paramiko

#install fabric with pip
pip install fabric

#It is neccessary to install Pycrypto2.1 and PyWin32
PyCrypto: http://www.voidspace.org.uk/python/modules.shtml#pycrypto
PyWin32: http://sourceforge.net/projects/pywin32/files/pywin32/


此方法不推薦!!!今天在安装reportlab时老是发生Unable to find vcvarsall.bat的错误，上网找了一下，在eddsn找到了“Unable to find vcvarsall.bat” error when trying to install rdflib这么一篇文章，解决了问题。方法如下：

首先安装MinGW，在MinGW的安装目录下找到bin的文件夹，找到mingw32-make.exe，复制一份更名为make.exe；
把MinGW的路径添加到环境变量path中，比如我把MinGW安装到D:\MinGW\中，就把D:\MinGW\bin添加到path中；
打开命令行窗口，在命令行窗口中进入到要安装代码的目录下(C:\Python27\Tools\Scripts)；
输入如下命令就可以安装了。
cd C:\Python27\Tools\Scripts
python setup.py install build --compiler=mingw32


1.windows上做Python开发，搭环境还真不比Linux容易。error: Unable to find vcvarsall.bat这个错误眼熟吧？

凡是安装和操作系统底层密切相关的Python扩展，几乎都会遇到这个错误。比如PIL， Pillow（两个图形库），greenlet以及其基础之上的eventlet, gevent微线程并发库等等。当然了有一些情况下，你不必彻底解决它，你可以选择windows版本，那么也就只能使用阉割版功能。

PIL有windows版，即使安装上了，64位Python一定报错 The _imaging C module is not installed， 除非自己重新编译安装。此外与CPU位数可能有关系，仅个人猜测。本人两个机器都是Win7旗舰版64位，安装的32位Python，其中一个CPU是64位的也遇到这个错误，32位的CPU则不报错。

为了解决64位CPU报错，于是安装Pillow的windows版，确实能正常使用，不再报错。但是图片效果极不理想，图片里面用到font就悲剧，出个验证码的图片都难以辨认。

greenlet也可以安装windows版，有可能报错加载动态链接库失败，比如”ImportError: DLL load failed: %1 不是有效的 Win32 应用程序。“不幸我也遇到了。


2.windows安装使用这些偏底层的Python扩展太不爽了，怎么彻底解决 error: Unable to find vcvarsall.bat 呢？

    1.不要按网上说的，安装MinGW，然后在“..python安装路径...\Lib\distutils”下新建一个文件distutils.cfg，在这文件里面指定编译器为mingw32

       如：
[build]
compiler=mingw32
    原因是什么，可以百度一下mingw是什么，毕竟不是GCC，又不如VC接windows的地气，编译出来的东西，安装上了也有不好使的时候。甚至我遇到MinGW还无法编译greenlet0.4.1，导致greenlet无法源码安装。MinGW经常command 'gcc' failed with exit status 1 或者error: unrecognized command line option '-mno-cygwin'。即使编译通过了，安装上了，你安装的Python标准库不是由mingw编译的，你的扩展包却是mingw编译的，谁也不敢保证完全兼容或者说质量跟得上，说不准一些莫名其妙的神经质错误。

     2.去下载安装VS2010（08版貌似也行，不过没必要用旧版，指不定哪个库又无法编译），给个地址（百度的云盘  国内应该速度可以）
http://pan.baidu.com/share/link?shareid=1609273194&uk=3255422755

   然后注意这一步很重要：命令行下执行 SET VS90COMNTOOLS=%VS100COMNTOOLS%

   如果你安装的是 2012 版 SET VS90COMNTOOLS=%VS110COMNTOOLS%

   如果你安装的是 2013版 SET VS90COMNTOOLS=%VS120COMNTOOLS%

   或者更暴力，直接配置系统环境变量 VS90COMNTOOLS指向 %VS你的版本COMNTOOLS%

   你还可以更暴力，在“..python安装路径...\Lib\distutils目录下有个msvc9compiler.py找到243行  

                  toolskey = "VS%0.f0COMNTOOLS" % version   直接改为 toolskey = "VS你的版本COMNTOOLS"(这个就是为什么要配 ”VS90COMNTOOLS“ 的原因，因为人家文件名都告诉你了是  Microsoft vc 9的compiler,   代码都写死了要vc9的comntools，就要找这个玩意儿，找不到不干活)

   这么做的理由是Python2。7 扩展包是可以用08版或者更高的VS编译的，其setup.py(安装脚本)都是去windows系统寻找08版的VS,所以设置VS90的path

   如果Python版本小于2.7，强烈建议使用 VS08版，用2010或者更高可能部分扩展不好使。给个例子：

    http://stackoverflow.com/questions/6551724/how-do-i-point-easy-install-to-vcvarsall-bat    这个例子说明 VS2010不适合Python2.6


    3.安装VS后该重启的重启，clean一下之前安装Python扩展失败的残留文件，然后 直接下载 pil   pillow greenlet  eventlet等源码，解压后python setup.py build发现都可以编译了。接下来就换成 python setup.py install安装吧。

