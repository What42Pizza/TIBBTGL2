# TIBBTGL2

This stands for "Texas-Intruments-Basic Based Text Game Language 2". So, this is a language based on Texas Instrument's version of basic, and it's aimed at making text based games. This language kind of has gotos, but it only lets you switch between files. Each file acts like a page in the game's book, and it's also kinda like a really big function. For a good example of how these gotos are used, see Examples-Programs/CCW (beginning with "Start.txt".

<br />
<br />
<br />

Here's all the types of statements you can use:

- *[Var Name]*  =  *[Value]*
- *[Var Name]* [] [] *...*  =  *[Value]*
- do *[Function Name]*
- do *[Function Name]*, *[Value (arg)]*, *[Value (arg)]*, *...*
- *[Function Name]*
- *[Function Name]*, *[Value (arg)]*, *[Value (arg)]*, *...*
- if *[Value]* then
- loop
- loop *[Value (index var)]*, *[Value (end)]*
- loop *[Value (index var)]*, *[Value (start)]*, *[Value (end)]*
- loop *[Value (index var)]*, *[Value (start)]*, *[Value (end)]*, *[Value (increment)]*
- repeat
- break
- goto