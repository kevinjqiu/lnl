# vim: set fdm=marker:
# {{{
# The Puzzle

So, this lunch and learn is about scratching the surface beneath the Python code and look at what it really does.

One of my former coworker one day posted this puzzler:

a, b = a[b] = {}, 5

# Interactive shell

First of all, this is just for fun.  No one is going to write code like that or ask that on an interview, and if you did get that on an interview, you probably
want to run away from that company.

So, it's two assignment operations rolled into one line. Does anyone want to venture a guess what the values of `a` and `b` are after the assignment?

So, for `b`, it's pretty clear. `5` is the right answer. 

The value of `a` is a trickier: `{5: ({...}, 5)}`.  It's a dictionary of one element keyed at integer `5`. The value of that dictionary element is a 2-tuple,
of which the second element is `5` but the first element is `{...}`.  So what gives?

# `dis` module

To correctly understand this code, you would need to understand operator precedence but we're going to take a different angle with this. We all know Python code is
compiled down to byte code and then the byte code is executed on the Python virtual machine similar to Java. We're going to compile this code down to byte code
and see for ourselves what this code is doing exactly.

Python, being the battery-included language it is, comes with a module to do the compilation. It's called `dis`. Here, we pipe our code into the `dis` module and see
what it spits out.

# Overview of the byte codes

ok, so this one line of Python code actually compiles down to 12 opcodes. The middle column is the name of the instruction, the column to the right
is the operands of the instruction if it takes any.

Before we dive into the opcodes, I'll quickly go over the CPython source code tree. `opcode.h` file contains the definitions of all opcodes. For instance, the `BUILD_MAP` opcode is a macro set to be `105` and so on. The main eval loop is in a file `ceval.c` in a function `PyEval_EvalFrameEx`: (line 1057)

There you see the giant switch block (line 1196) that handles the next opcode.

# Python VM overview

The next thing you need to know about the Python VM is that there are two storage within a given frame of execution: a value stack and the binding of names to objects.

# Bytecode Walkthrough

`BUILD_MAP 0` (line 2498)  --> creates a python dictionary of size 0, and push it on the value stack.

# Conclusion

So there you go. We just peeked under the hood of Python and saw how things work together. This barely scratches the surface. The opcodes in this example are quite straightforward, but hopefully through this exercise, you know where to look for CPython opcodes and the internals. 
# }}}
