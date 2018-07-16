AGS-wrapper-json
================

> A simple *wrapper* of the library [JSON.au3](https://www.autoitscript.com/forum/topic/148114-a-non-strict-json-udf-jsmn/), created by Ward, for simplifiy handling dependencies of an AutoIt project built with [AGS framework](https://v20100v.github.io/autoit-gui-skeleton/).



<br/>

## Install

In order to simplify the management of the dependencies of an AutoIt project built with AGS framework, we have diverted form its initial use the dependency manager npm, and its evolution Yarn. This allows us to manage the dependencies of an AGS project with other AutoIt libraries, and to share these AutoIt packages from the npmjs.org repository. All AGS packages hosted in this npmjs repository belong to [@autoit-gui-skeleton organization](https://www.npmjs.com/search?q=autoit-gui-skeleton)

We assume that you have already install [Node.js](https://nodejs.org/) and [Yarn](https://yarnpkg.com/lang/en/), for example with [Chocolatey](https://chocolatey.org/), so to install AGS-wrapper-json, just type in the root folder of your project where the `package.json` is saved :

```
λ  yarn add @autoit-gui-skeleton/ags-wrapper-json --modules-folder vendor
```

All project dependencies, as well as daughter dependencies of parent dependencies, are installed in the `./vendor/@autoit-gui-skeleton/` directory. And after to use it in your AutoIt program, you need to include this library with this instruction:

```autoit
#include 'vendor/@autoit-gui-skeleton/ags-wrapper-json/JSON.au3'
```



<br/>

## AGS's vendor directory

To install AutoIt dependencies in the `./vendor` directory, and not in the default directory of Node.js `./node_modules`, you must add the `--modules-folder vendor` option. We force this choice to avoid any confusion with a Node.js project. 

Note that with an AGS project, it is not necessary to explicitly write this option on the command line, thanks to the `.yarnrc` file stored at the root of the project. Yarn automatically use this file to add an additional configuration of options.

```
 #./.yarnrc 
 --modules-folder vendor
 ```
 
So with this file you can run `yarn add @autoit-gui-skeleton/ags-wrapper-json` to install the dependencies directly into the appropriate `./vendor` directory.



<br/>

## About
 
### Thanks

Acknowledgments for [Ward's](https://www.autoitscript.com/forum/profile/10768-ward/) work and its library [JSON.au3](https://www.autoitscript.com/forum/topic/148114-a-non-strict-json-udf-jsmn/)

### Contributing
 
Comments, pull-request & stars are always welcome !
 
### License
 
Copyright (c) 2018 by [v20100v](https://github.com/v20100v). Released under the MIT license.