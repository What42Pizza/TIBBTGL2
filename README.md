# TIBBTGL 2

This stands for "Texas-Instruments-Basic Based Text Game Language 2". So, this is a language based on Texas Instrument's version of basic, and it's aimed at making text based games. This language kind of has gotos, but it only lets you switch between files. Each file acts like a page in the game's book, and it's also kinda like a really big function. For a good example of how these gotos are used, see Examples-Programs/CCW (beginning with "Start.txt").

<br />
<br />
<br />

Here's all the types of statements you can use:

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
<br />
<br />

### Details for each statement type:

<br />
<br />
<br />
<br />

#### *[Var Name]* &nbsp; = &nbsp; *[Value]*
#### *[Var Name]* &nbsp; [*[Integer Value (index)]*] &nbsp; [*[Integer Value (index)]*] ... &nbsp; = &nbsp; *[Value]*

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

#### goto &nbsp; *[Page Name]*

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

#### do &nbsp; *[Function Name]*
#### do &nbsp; *[Function Name]*, &nbsp; *[Value (arg)]*, &nbsp; *[Value (arg)]*, *...*
#### *[Function Name]*
#### *[Function Name]*, &nbsp; *[Value (arg)]*, &nbsp; *[Value (arg)]*, *...*

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

#### return
#### return &nbsp; *[Value]*

<br />

Returns from the current function and sets $Return to [Value] (if used). Only one return value can be passed since you can return multiple values by putting them into an array.

See above statement for example.