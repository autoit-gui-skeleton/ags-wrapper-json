AGS-wrapper-json
================

> [AutoIt Gui Skeleton](https://autoit-gui-skeleton.github.io/) package for wrapping the library [JSON.au3](https://www.autoitscript.com/forum/topic/148114-a-non-strict-json-udf-jsmn/) created by [Ward's](https://www.autoitscript.com/forum/profile/10768-ward/). See this package on [npmjs.com](https://www.npmjs.com/package/@autoit-gui-skeleton/ags-wrapper-json/)



<br/>

## How to install AGS-wrapper-wrapper-json ?

We assume that you have already install [Node.js](https://nodejs.org/) and [Yarn](https://yarnpkg.com/lang/en/), for example by taking a [Chocolatey](https://chocolatey.org/). AGS framework use it for manage dependencies.

To add this package into your AutoIt project, just type in the root folder of your AGS project where the `package.json` is stored. You can also modify the `dependencies` property of this json file and use the yarn [install](https://yarnpkg.com/en/docs/usage) command. It is easier to use the add command :

```
λ  yarn add @autoit-gui-skeleton/ags-wrapper-json --modules-folder vendor
```

The property `dependencies` of the  `package.json` file is updated consequently, and all package dependencies, as well as daughter dependencies of parent dependencies, are installed in the `./vendor/@autoit-gui-skeleton/` directory. Note that with an AGS project, it is not necessary to explicitly write this option `--modules-folder vendor` on the command line, thanks to the `.yarnrc` file stored at the root of the project. Yarn automatically use `.yarnrc` file to add an additional configuration of options.

```
 #./.yarnrc
 --modules-folder vendor
 ```

Finally to use this library in your AutoIt program, you need to include this library in the main program. There is no need for additional configuration to use it.

```autoit
#include './vendor/@autoit-gui-skeleton/ags-wrapper-json/JSON.au3'
```



<br/>

## What is AGS (AutoIt Gui Skeleton) ?

[AutoIt Gui Skeleton](https://autoit-gui-skeleton.github.io/) give an environment for developers, that makes it easy to build AutoIt applications. To do this AGS proposes to use conventions and a standardized architecture in order to simplify the code organization, and thus its maintainability. It also gives tools to help developers in recurring tasks specific to software engineering.

> More information about [AGS framework](https://autoit-gui-skeleton.github.io/)

AGS provides a dependency manager for AutoIt library. It uses the Node.js ecosystem and its dependency manager npm and its evolution Yarn. All AGS packages are hosted in npmjs.org repository belong to the [@autoit-gui-skeleton](https://www.npmjs.com/search?q=autoit-gui-skeleton) organization. And in AGS you can find two types of package :

- An **AGS-component** is an AutoIt library, that you can easy use in your AutoIt project built with the AGS framework. It provides some features for application that can be implement without painless.
- An **AGS-wrapper** is a simple wrapper for an another library created by another team/developer.

> More information about [dependency manager for AutoIt in AGS](https://autoit-gui-skeleton.github.io//2018/07/10/ags_dependencies_manager_for_AutoIt.html)



<br/>

## How to decode a JSON ?

### Decode a JSON file from local

For example, create this json file in your `./assets/DROIDS.json` folder of your AGS project.

```json
{
  "project": "Listing droids",
  "version": "1.0",
  "author": {
    "name": "Luke",
    "mail": "luke@2080.org"
  },
  "droids": [
    {
      "name": "R2D2",
      "type": "Astromecano",
      "size": "0,96m"
    },
    {
      "name": "BB8",
      "type": "Astromecano",
      "size": "0,67m"
    },
    {
      "name": "C-3PO",
      "type": "Social",
      "size": "1,67m"
    }
  ]
}
```

To decode this local file, we use this bellow function `json_decode_from_file`.

```autoit
#include 'vendor/@autoit-gui-skeleton/ags-wrapper-json/JSON.au3'

;====================================================================================
; Decode JSON from a given local file
;
; @param $jsonfilePath (string)
; @return $object (object), instance return by json_decode
;====================================================================================
Func json_decode_from_file($filePath)
	Local $fileOpen, $fileContent, $object

	$fileOpen = FileOpen($filePath, $FO_READ)
	If $fileOpen = -1 Then
		Return SetError(1, 0, "An error occurred when reading the file " & $filePath)
	EndIf
	$fileContent = FileRead($fileOpen)
	FileClose($fileOpen)
	$object = Json_Decode($fileContent)

	Return $object
EndFunc
```

According to Ward's documentation.

> The most JSON data type will be decoded into corresponding AutoIt variable, including 1D array, string, number, true, false, and null. JSON object will be decoded into "Windows Scripting Dictionary Object" retuned from `ObjCreate("Scripting.Dictionary")`. AutoIt build-in functions like IsArray, IsBool, etc. can be used to check the returned data type. But for Object and Null, Json_IsObject() and Json_IsNull() should be used.
>
> If the input JSON string is invalid, `@Error` will be set to `$JSMN_ERROR_INVAL`. And if the input JSON string is not finish, `@Error` will be set to `$JSMN_ERROR_PART`.



### Get values from a json object

To work with `$jsonObject`, the return of `json_decode_from_file`, you can use `Json_Get` function. To select a JSON variable, both dot notation and square bracket notation can be supported.

```autoit
Local $file = @ScriptDir & "\assets\DROIDS.json"
Local $jsonObject = json_decode_from_file($file)

; With dot notation
Local $project = Json_Get($jsonObject, '.project')     ; Listing droids
Local $name = Json_Get($jsonObject, '.author.name')    ; Luke
Local $mail = Json_Get($jsonObject, '.author.mail')    ; luke@2080.org
local $test = Json_Get($jsonObject, '.droids[1].name') ; BB8

; With array notation
Local $project2 = Json_Get($jsonObject, '["project"]')
Local $name2 = Json_Get($jsonObject, '["author"]["name"]')
Local $mail2 = Json_Get($jsonObject, '["author"]["mail"]')
local $test2 = Json_Get($jsonObject, '["droids"][1]["name"]')
```

You also can use object help functions. These functions are just warps of `Scripting.Dictionary` COM object.

- Json_ObjCreate()
- Json_ObjPut(ByRef $Object, $Key, $Value)
- Json_ObjGet(ByRef $Object, $Key)
- Json_ObjDelete(ByRef $Object, $Key)
- Json_ObjExists(ByRef $Object, $Key)
- Json_ObjGetCount(ByRef $Object)
- Json_ObjGetKeys(ByRef $Object)
- Json_ObjClear(ByRef $Object)


### Work with an object collection, and iterate its items

To iterate values from an array json

```autoit
Local $file = @ScriptDir & "\assets\DROIDS.json"
Local $jsonObject = json_decode_from_file($file)

; Check if exists an item droid into the collection `droids`
Local $droids = Json_Get($jsonObject, '.droids')
If UBound($droids) = 0 Then
    Return SetError(3, 0, "Array attribute 'droids' is empty.")
EndIf

; Iterate items collection to store values into an array
Local $array[UBound($droids)][3]
For $i = 0 To UBound($droids) - 1 Step 1
    $array[$i][0] = Json_Get($jsonObject, '.droids' & '[' & $i & '].name')
    $array[$i][1] = Json_Get($jsonObject, '.droids' & '[' & $i & '].type')
    $array[$i][2] = Json_Get($jsonObject, '.droids' & '[' & $i & '].size')
Next
```


### Add object into a JSON

You can do it with `Json_Put`:

```àutoit
Local $Obj
Json_Put($Obj, ".foo", "foo")
Json_Put($Obj, ".bar[0]", "bar")
Json_Put($Obj, ".test[1].foo.bar[2].foo.bar", "Test")

Local $Test = Json_Get($Obj, '["test"][1]["foo"]["bar"][2]["foo"]["bar"]') ; "Test"
```


### Decode a JSON file from a remote server

To decode a JSON file hosted on a remote server, or built from a webservice or from a REST API, you can use the component [@autoit-gui-skeleton/ags-component-http-request](https://www.npmjs.com/package/@autoit-gui-skeleton/ags-component-http-request) to make HTTP requests to a given URL.

```autoit
#include 'vendor/@autoit-gui-skeleton/ags-component-http-request/ags-component-http-request.au3'

;====================================================================================
; Decode JSON from a given URL
;
; @param $jsonfileUrl (string)
; @param $proxy (string), by default we load proxy settings form configuration file
; @return $object (object), instance return by json_decode
;====================================================================================
Func json_decode_from_url($jsonfileUrl, $proxy = "")
	Local $response = HttpGET($jsonfileUrl, Default, $proxy)
	If (@error) Then
		Return SetError(@error, $response, _
		    "Unable to get json file on server " & $jsonfileUrl & ".")
	EndIf
	Local $data = $response.ResponseText
	Local $object = json_decode($data)

	Return $object
EndFunc

Local $jsonObject = json_decode_from_url(https://api.spacexdata.com/v2/info)

Local $name = Json_Get($jsonObject, '.name')        ; SpaceX
Local $founder = Json_Get($jsonObject, '.founder')  ; Elon Musk
Local $founded = Json_Get($jsonObject, '.founded')  ; 2002
```


<br/>

## How to encode a JSON ?

According to Ward's documentation, you can use `Json_Encode($Data, $Option = 0, $Indent = "\t", $ArraySep = ",\r\n", $ObjectSep = ",\r\n", $ColonSep = ": ")`.


> - `$Data` can be a string, number, bool, keyword : default or null, 1D array, or `Scripting.Dictionary` COM object.
> - Binary will be converted to string in UTF8 encoding.
> - Ptr will be converted to number
> - Other unsupported types like 2D array, dllstruct or object will be encoded into null.
>
> `$Option` is bitmask consisting following constant:
>
> - `$JSON_UNESCAPED_ASCII` ; Don't escape ascii charcters between chr(1) ~ chr(0x1f)
> - `$JSON_UNESCAPED_UNICODE` ; Encode multibyte Unicode characters literally
> - `$JSON_UNESCAPED_SLASHES` ; Don't escape /
> - `$JSON_HEX_TAG` ; All < and > are converted to \u003C and \u003E
> - `$JSON_HEX_AMP` ; All &amp;amp;amp;amp;s are converted to \u0026
> - `$JSON_HEX_APOS` ; All ' are converted to \u0027
> - `$JSON_HEX_QUOT` ; All " are converted to \u0022
> - `$JSON_PRETTY_PRINT` ; Use whitespace in returned data to format it
> - `$JSON_STRICT_PRINT` ; Make sure returned JSON string is RFC4627 compliant
> - `$JSON_UNQUOTED_STRING` ; Output unquoted string if possible (conflicting with $JSMN_STRICT_PRINT)

For example to encode in JSON:

```autoit
Local $file = @ScriptDir & "\assets\DROIDS.json"
Local $jsonObject = json_decode_from_file($file)
Local $jsonEncoded = Json_Encode($jsonObject, $JSON_PRETTY_PRINT)

ConsoleWrite($jsonEncoded)
```

> Most encoding option have the same means like PHP's json_encode() function. When `$JSON_PRETTY_PRINT` is set, output format can be change by other 4 parameters : `($Indent, $ArraySep, $ObjectSep, $ColonSep)`. Because these 4 output format parameters will be checked inside `Jsmn_Encode()` function, returned string will be always accepted by `Jsmn_Decode()`. $JSON_UNQUOTED_STRING can be used to output unquoted string that also accetped by Jsmn_Decode(). `$JSON_STRICT_PRINT` is used to check output format setting and avoid non-standard JSON output. So this option is conflicting with `$JSON_UNQUOTED_STRING`.



<br/>

## About

### Acknowledgments

Acknowledgments for [Ward's](https://www.autoitscript.com/forum/profile/10768-ward/) work and its library [JSON.au3](https://www.autoitscript.com/forum/topic/148114-a-non-strict-json-udf-jsmn/)


### Contributing

Comments, pull-request & stars are always welcome !

### License

Copyright (c) 2018 by [v20100v](https://github.com/v20100v). Released under the MIT license.
