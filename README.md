# TIBBTGL 2

This stands for "Texas-Instruments-Basic Based Text Game Language 2". So, this is a language based on Texas Instrument's version of basic, and it's aimed at making text based games.

This language kind of has gotos, but it only lets you switch between files. Each file acts like a page in your game's book, and it's also kinda like a really big function. That being said, though, each page can have its own functions that are called from outside that page. For a good example of how these gotos are used, see Example-Programs/CCW (beginning with "Start.txt").

<br />

Statement are separated by line breaks, and the level of indentation defines code block starts and ends. For a good example of general syntax, you can look at Internal.txt.

Variables that start with '_' are global, meaning they carry over from page to page. Variables that start with '$' are internal variables and they usually aren't used directly. The main times you'll have to use internal variables is with functions (by reading from $Args and $Return).

<br />
<br />
<br />

## Usable statements:

- *[Var Name]* &nbsp; = &nbsp; *[Value]*
- *[Var Name]* &nbsp; [*[Integer Value (index)]*] &nbsp; [*[Integer Value (index)]*] *...* &nbsp; = &nbsp; *[Value]*
- goto &nbsp; *[Page Name]*
- do &nbsp; *[Function Name]*
- do &nbsp; *[Function Name]*, &nbsp; *[Value (arg)]*, &nbsp; *[Value (arg)]*, *...*
- *[Function Name]*
- *[Function Name]*, &nbsp; *[Value (arg)]*, &nbsp; *[Value (arg)]*, *...*
- return
- return &nbsp; *[Value]*
- if *[Value]* then
- loop
- loop &nbsp; *[Value (index var)]*, &nbsp; *[Value (end)]*
- loop &nbsp; *[Value (index var)]*, &nbsp; *[Value (start)]*, &nbsp; *[Value (end)]*
- loop &nbsp; *[Value (index var)]*, &nbsp; *[Value (start)]*, &nbsp; *[Value (end)]*, &nbsp; *[Value (increment)]*
- repeat
- break
- set &nbsp; *[Var Name]*, &nbsp; *[Value]*
- PAUSE

<br />
<br />
<br />

### Functions

You can define a function by writing "function " followed by the function name. Functions can have arguments, but they are stored in the internal var $Args. It's a good idea to always move the values from $Args to local variables since they are overwritten every time you can a function. It also gives names to each argument, making it more readable.

Example function:

```
function FizzBuzz
	InputNum = $Args[1]
	
	Output = ""
	
	if InputNum % 3 == 0 then
		Output = Output .. "Fizz"
	if InputNum % 5 == 0 then
		Output = Output .. "Buzz"
	if Output == "" then
		Output = toString InputNum
	
	return Output
```

<br />
<br />
<br />
<br />
<br />

## Details for each statement type:

<br />
<br />
<br />
<br />

### *[Var Name]* &nbsp; = &nbsp; *[Value]*
### *[Var Name]* &nbsp; [*[Integer Value (index)]*] &nbsp; [*[Integer Value (index)]*] ... &nbsp; = &nbsp; *[Value]*

<br />

Sets the variable [Var Name]'s value to [Value]. If there are square brackets following the variable name, that will be define an index.

<br />

Example:

```
a = {} // sets 'a' to be an array
a[1] = "b" // sets the first index of a to be the string "b"
```

<br />
<br />
<br />
<br />

### goto &nbsp; *[Page Name]*

<br />

Stops execution on current page and goes to the start of the page [Page Name].

<br />

Example:

```
// do game initialization...

goto Menus/MainMenu
```

<br />
<br />
<br />
<br />

### do &nbsp; *[Function Name]*
### do &nbsp; *[Function Name]*, &nbsp; *[Value (arg)]*, &nbsp; *[Value (arg)]*, *...*
### *[Function Name]*
### *[Function Name]*, &nbsp; *[Value (arg)]*, &nbsp; *[Value (arg)]*, *...*

<br />

Jumps to function [Function Name], with all trailing values as arguments. Arguments are stored in the internal variable $Args. You can also call functions in other pages.

<br />

Example:

```
function DoubleNumber
	return $Args[1] * 2

do DoubleNumber, 128
p $Return

do OtherFunctions.HalfNumber, $Return
p $Return
```

<br />
<br />
<br />
<br />

### return
### return &nbsp; *[Value]*

<br />

Returns from the current function and sets $Return to [Value] (if used). Only one return value can be passed since you can return multiple values by putting them into an array.

See above statement for example.

<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />
<br />

## Evaluator functions:

Basic math:

- [Integer, Float] &nbsp; + &nbsp; [Integer, Float] &nbsp; -> &nbsp; [Integer, Float]
- [Integer, Float] &nbsp; - &nbsp; [Integer, Float] &nbsp; -> &nbsp; [Integer, Float]
- [Integer, Float] &nbsp; * &nbsp; [Integer, Float] &nbsp; -> &nbsp; [Integer, Float]
- [Integer, Float] &nbsp; / &nbsp; [Integer, Float] &nbsp; -> &nbsp; [Float]
- [Integer, Float] &nbsp; % &nbsp; [Integer, Float] &nbsp; -> &nbsp; [Integer, Float]
- [Integer, Float] &nbsp; ^ &nbsp; [Integer, Float] &nbsp; -> &nbsp; [Integer, Float]

More math:

- round &nbsp; [Integer, Float] &nbsp; -> &nbsp; [Integer]
- ceil &nbsp; [Integer, Float] &nbsp; -> &nbsp; [Integer]
- floor &nbsp; [Integer, Float] &nbsp; -> &nbsp; [Integer]
- sqrt &nbsp; [Integer, Float] &nbsp; -> &nbsp; [Float]
- abs &nbsp; [Integer, Float] &nbsp; -> &nbsp; [Integer, Float]

Comparing:

- [Value] &nbsp; == &nbsp; [Value] &nbsp; -> &nbsp; [Bool]
- [Value] &nbsp; ~= &nbsp; [Value] &nbsp; -> &nbsp; [Bool]
- [Value] &nbsp; > &nbsp; [Value] &nbsp; -> &nbsp; [Bool]
- [Value] &nbsp; < &nbsp; [Value] &nbsp; -> &nbsp; [Bool]
- [Value] &nbsp; >= &nbsp; [Value] &nbsp; -> &nbsp; [Bool]
- [Value] &nbsp; <= &nbsp; [Value] &nbsp; -> &nbsp; [Bool]

Boolean:

- not &nbsp; [Value] &nbsp; -> &nbsp; [Bool]
- [Value] &nbsp; and &nbsp; [Value] &nbsp; -> &nbsp; [Value]
- [Value] &nbsp; or &nbsp; [Value] &nbsp; -> &nbsp; [Value]
- [Bool] &nbsp; xor &nbsp; [Bool] &nbsp; -> &nbsp; [Bool]

Bitwise:

- NOT &nbsp; [Integer] &nbsp; -> &nbsp; [Integer]
- [Integer] &nbsp; AND &nbsp; [Integer] &nbsp; -> &nbsp; [Integer]
- [Integer] &nbsp; OR &nbsp; [Integer] &nbsp; -> &nbsp; [Integer]
- [Integer] &nbsp; XOR &nbsp; [Integer] &nbsp; -> &nbsp; [Integer]

Extra functions:

- typeOf &nbsp; [Array] &nbsp; -> &nbsp; [String]
- lengthOf &nbsp; [Array] &nbsp; -> &nbsp; [Integer]
- isInt &nbsp; [Integer, Float] &nbsp; -> &nbsp; [Bool]
- toString &nbsp; [Value] &nbsp; -> &nbsp; [String]
- toNum &nbsp; [Value] &nbsp; -> &nbsp; [Integer, Float]
- toFraction &nbsp; [Integer, Float] &nbsp; -> &nbsp; [String]
- toBool &nbsp; [Value] &nbsp; -> &nbsp; [Bool]