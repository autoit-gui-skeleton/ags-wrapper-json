
; Include
#Include "../JSON.au3"


If Test1() And Test2() And Test3() And Test4() And Test5() Then MsgBox(0, "Json UDF Test", "All Passed !")


Func Test1()
	Local $Json1 = FileRead(@ScriptDir & "\test.json")
	Local $Data1 = Json_Decode($Json1)
	Local $Json2 = Json_Encode($Data1)

	Local $Data2 = Json_Decode($Json2)
	Local $Json3 = Json_Encode($Data2)

	ConsoleWrite("Test1 Result: " & $Json3 & @LF)
	Return ($Json2 = $Json3)
EndFunc

Func Test2()
	Local $Json1 = '["100","hello world",{"key":"value","number":100}]'
	Local $Data1 = Json_Decode($Json1)

	Local $Json2 = Json_Encode($Data1, $Json_UNQUOTED_STRING)
	Local $Data2 = Json_Decode($Json2)

	Local $Json3 = Json_Encode($Data2, $Json_PRETTY_PRINT, "  ", "\n", "\n", ",")
	Local $Data3 = Json_Decode($Json3)

	Local $Json4 = Json_Encode($Data3, $Json_STRICT_PRINT)

	ConsoleWrite("Test3 Unquoted Result: " & $Json2 & @LF)
	ConsoleWrite("Test3 Pretty Result: " & $Json3 & @LF)
	Return ($Json1 = $Json4)
EndFunc

Func Test3()
	Local $Obj
	Json_Put($Obj, ".foo", "foo")
	Json_Put($Obj, ".bar[0]", "bar")
	Json_Put($Obj, ".test[1].foo.bar[2].foo.bar", "Test") ; dot notation

	Local $Json = Json_Encode($Obj)
	ConsoleWrite("Test3 Result: " & $Json & @LF)

	Return Json_Get($Obj, '["test"][1]["foo"]["bar"][2]["foo"]["bar"]') = "Test" ; square bracket notation
EndFunc

Func Test4()
	ConsoleWrite("Test4 will show all keys: " & @LF)
	Local $Json1 = '["100","hello world",{"key":"value","number":100}]'
	Json_Dump($Json1)
	ConsoleWrite("Test4 done." & @LF)
	Return 1
EndFunc

Func Test5()
	ConsoleWrite("Test5 test primitive/true/false/0 cases: " & @LF)
	Local $Json1 = '{"null_item": null, "zero_primitive_item": 0,"false_item": false,"true_item": true,"string_item": "This is a string","array_item": [0,1,2]}'
	Json_Dump($Json1)
	Local $result = "+-> .null_item  =Null" & @LF & _
					"+-> .zero_primitive_item  =0" & @LF & _
					"+-> .false_item  =False" & @LF & _
					"+-> .true_item  =True" & @LF & _
					"+-> .string_item  =This is a string" & @LF & _
					"+=> .array_item[0]=>0" & @LF & _
					"+=> .array_item[1]=>1" & @LF & _
					"+=> .array_item[2]=>2"
	ConsoleWrite("Test5 done and should have returned:" & @LF & $result & @LF)
	Return 1
EndFunc
