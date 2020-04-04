/*
spasm.js
/bean

spasm.js is a way to play with webassembly

it provides a command line (for input) and
a command output area for function returns

you can load multiple .wat files at a time
(from the server, perhaps later locally..)

each file has functions you can try out to
show off cool stuff we did coding wasmtext

anyways... heres how it works:

- each file gets a single page of memory
- each file also has different functions
- functions can access this memory with calls to imported javascript packages
- the memory jscall simply hands over linear blocks of memory

Notes for later:
- the JS constructor WebAssembly.Memory throws a RangeError if memory cannot be allocated.
- Also throws a RangeError if cannot grow memory more as well!
- if a file requires more memory, it gets + twice as many pages as it already had
- memory as a heap

a function pushes and pops memory (stores/loads)


Z-Expressions

We've all heard of the S-Expression, but have you ever heard of the Z-Expression??

No, I thought not. They're quite simple, and useless.

As we know, an S-Expression node is a pair.
The "car" is the head of the expression, the "cdr" is the rest of the expression.

In Z-Expressions we have similar triplet:

head is the "car"
tail is the "cdr"
root is the head of the sub expression.

Example time!

(1, 2, 3) as an S-Expression:

[1, |]
    [2, |]
        [3, /]

As a Z-Expression:

[/, 1, |]
^      [|, 2, |]
|_______|     [*, 3, /]

We use star to mean root!

Wow! So Cool!

Just kidding.

But am I?

Maybe.


Let's see, what could you do with these?

Well, let's say you have a list as a Z-Expression, the one above even.
Say you wanted to construct another list that repeats this one a few times.
With S-Expressions, you would have to recurse down in the cdr, come all the way back up, go down again, etc, etc.
Well, with Z-Expressions, there's no need, since you have a handy pointer to the root!

Here's some pseudo-code how you would do it:
Note: btw '/' means null here.

repeat copies list:

repeat 0 list = list head : null if list tail is null
repeat n list = list head : repeat n-1 list root if list tail is null
repeat n list = list head : repeat n list tail //note : operation preseveres list root

Let's run through this with repeat 2 (1, 2, 3):

repeat 2 (1,2,3) 
= 1 : repeat 2 (2,3)
= 1 : 2 : repeat 2 (3)
= 1 : 2 : 3 : repeat 1 (1,2,3)
= 1 : 2 : 3 : 1 ....
...
= 1 : 2 : 3 : 1 : 2 : 3 : repeat 0 (1,2,3)
= 1 : 2 : 3 : 1 : 2 : 3 : 1 : repeat 0 (2,3)
...
= 1 : 2 : 3 : 1 : 2 : 3 : 1 : 2 : 3 : /
= (1,2,3,1,2,3,1,2,3)

See how straight-forward that was.
Not once did we have to come up out of recursion.

Obvoiusly this has its limits, but there are some other tricks...

For one, list root just means the left-most item of the Z-Triplet [^,x,|]
It doesn't have to be the root per se...
It can be useful elsewise, for example, say we want a list that is easily reversable.
We can call it (what was root) prev now:

(1,2,3):

[|,1,|]
 |   [^, 2, |]
 |          [^, 3, /]
 |          ^
 |__________|

Now if we want a reverse version of the list we access the prev of it.
This returns the last item of the list, which we use each prev to get the next reverse item.
We stop on the one which has a null tail, since that's where we started.

We can also do real binary trees this way having the left-most item of the triplet as left child.
   0
  / \
 1   2
/\  /\
3 4 5 6

[|,  0,  |]
 [|,1,|] [|,2,|]
  .............
   [/,3,/]...............




*/
