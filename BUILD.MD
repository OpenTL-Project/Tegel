Tegel is written in Haxe and uses OpenFL as the main framework.

The following below are required for building the project.

### Haxe ###
[Download](https://haxe.org/download/) 

*NOTE:* This project uses **Haxe 3.4.7** to test completion with Travis, newer syntax supported by 4.0 will not be able to pass review.

<br>

### Haxelib Libaries ###
After installing Haxe, the `haxelib` command should be available in your terminal/command prompt.

``` SH
haxelib install lime
haxelib install openfl
haxelib install hxcpp
haxelib install svg
```

<br>

**Tested Versions**
* OpenFL 7-8
* Lime 6.0 - 6.4

<br>

### Platform setup ###
* cpp
``` SH
lime setup cpp
```
* neko, N/A

<br>

### **Building the project!** ###

* c++ version
``` SH
lime test cpp
```
* neko virtual machine (worse performance, faster completion)
``` SH
lime test neko
```

### flags ###
*Explanation*: Flags are used to apply certain attributes to your build. You can use them by appending them to a build/test command.

* `-debug`:for testing/debugging builds
* `-release`: greater performance.
* `-final`: release with [dce full](https://haxe.org/manual/cr-dce.html)


