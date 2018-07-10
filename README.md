AGS-wrapper-json
================

> A simple *wrapper* of library [JSON.au3](https://www.autoitscript.com/forum/topic/148114-a-non-strict-json-udf-jsmn/) created by Ward for simplifiy handling dependencies of an AutoIt project built with [AGS](https://v20100v.github.io/autoit-gui-skeleton/).



<br/>

## Install

We assume that you have already install [Node.js](https://nodejs.org/) and [Yarn](https://yarnpkg.com/lang/en/), for example with [Chocolatey](https://chocolatey.org/). We recommend you to install AGS-wrapper-json with Yarn. Just type in the root folder of your project where the `package.json` is saved :

```
λ  yarn add @autoit-gui-skeleton/ags-wrapper-json --modules-folder vendor
```

The package is installed into the `./vendor` directory, and to use it in your AutoIt program, you need to include this library with:

```autoit
#include 'vendor/@autoit-gui-skeleton/ags-wrapper-json/JSON.au3'
```



<br/>

## AGS's vendor directory

By default Yarn and npm installs packages into the `./node_modules` directory. With an AGS project we want to install this kind of dependency package into the `./vendor/` directory, in order to avoid any confusion with a Node.js project. To do this we add the option `--modules-folder vendor`. 

You can omit this option normaly with an AGS project. Indeed, you are supposed to have the file `./.yarnrc` in the root folder of your AGS project, in the same place of your `pacakge.json` file. Yarn automatically looks into the `./.yarnrc` file for additional configuration options.

```
#./.yarnrc 
--modules-folder vendor
```

With this file, you can run `yarn add @autoit-gui-skeleton/ags-wrapper-json` to install it directly into the appropriate `./vendor` directory.



<br/>

## About
 
### Thanks

Acknowledgments for [Ward's](https://www.autoitscript.com/forum/profile/10768-ward/) work and its library [JSON.au3](https://www.autoitscript.com/forum/topic/148114-a-non-strict-json-udf-jsmn/)

### Contributing
 
Comments, pull-request & stars are always welcome !
 
### License
 
Copyright (c) 2018 by [v20100v](https://github.com/v20100v). Released under the MIT license.