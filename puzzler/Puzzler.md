# vim: set fdm=marker:

# {{{ The puzzle
a, b = a[b] = {}, 5
# }}}

# {{{ Interactive shell
In [1]: a, b = a[b] = {}, 5

In [2]: a
Out[2]: {5: ({...}, 5)}

In [3]: b
Out[3]: 5
# }}}

# {{{ The byte code

```
 $ echo "a, b = a[b] = {}, 5" | python2 -m dis
  1           0 BUILD_MAP                0
              3 LOAD_CONST               0 (5)
              6 BUILD_TUPLE              2
              9 DUP_TOP
             10 UNPACK_SEQUENCE          2
             13 STORE_NAME               0 (a)
             16 STORE_NAME               1 (b)
             19 LOAD_NAME                0 (a)
             22 LOAD_NAME                1 (b)
             25 STORE_SUBSCR
             26 LOAD_CONST               1 (None)
             29 RETURN_VALUE
```
# }}}

# {{{ Python VM overview

```
    +---------------+
    |  value stack  |
    +---------------+
    |   object 1    |
    |   object 2    |
    +---------------+


    +----------------+
    |  name bindings |
    +----------------+
    |    a :  {}     |
    |    b :  '5'    |
    +----------------+
```

# }}}

# {{{ `BUILD_MAP 0` (line 2498)
```
  -> BUILD_MAP                0
     LOAD_CONST               0 (5)
     BUILD_TUPLE              2
     DUP_TOP
     UNPACK_SEQUENCE          2
     STORE_NAME               0 (a)
     STORE_NAME               1 (b)
     LOAD_NAME                0 (a)
     LOAD_NAME                1 (b)
     STORE_SUBSCR
     LOAD_CONST               1 (None)
     RETURN_VALUE
```
# }}}

# {{{ `BUILD_MAP 0`
```
    +---------------+
    | value stack   |
    +---------------+
    |      {}       |
    +---------------+
```
# }}}

# {{{ `LOAD_CONST 0` (line 1227)
```
     BUILD_MAP                0
  -> LOAD_CONST               0 (5)
     BUILD_TUPLE              2
     DUP_TOP
     UNPACK_SEQUENCE          2
     STORE_NAME               0 (a)
     STORE_NAME               1 (b)
     LOAD_NAME                0 (a)
     LOAD_NAME                1 (b)
     STORE_SUBSCR
     LOAD_CONST               1 (None)
     RETURN_VALUE
```
# }}}

# {{{ `LOAD_CONST 0`
```
    +---------------+
    | value stack   |
    +---------------+
    |      {}       |
    +---------------+
    |      5        |
    +---------------+
```
# }}}

# {{{ `BUILD_TUPLE 2` (line 2450)
```
     BUILD_MAP                0
     LOAD_CONST               0 (5)
  -> BUILD_TUPLE              2
     DUP_TOP
     UNPACK_SEQUENCE          2
     STORE_NAME               0 (a)
     STORE_NAME               1 (b)
     LOAD_NAME                0 (a)
     LOAD_NAME                1 (b)
     STORE_SUBSCR
     LOAD_CONST               1 (None)
     RETURN_VALUE
```
# }}}

# {{{ `BUILD_TUPLE 2`
```
    +---------------+
    | value stack   |
    +---------------+
    |   ({}, 5)     |
    +---------------+
```
# }}}

# {{{ `DUP_TOP` (line 2450)
```
     BUILD_MAP                0
     LOAD_CONST               0 (5)
     BUILD_TUPLE              2
  -> DUP_TOP
     UNPACK_SEQUENCE          2
     STORE_NAME               0 (a)
     STORE_NAME               1 (b)
     LOAD_NAME                0 (a)
     LOAD_NAME                1 (b)
     STORE_SUBSCR
     LOAD_CONST               1 (None)
     RETURN_VALUE
```
# }}}

# {{{ `DUP_TOP`
```
    +---------------+
    | value stack   |
    +---------------+
    |   ({}, 5)     |
    +---------------+
    |   ({}, 5)     |
    +---------------+
```
# }}}

# {{{ `UNPACK_SEQUENCE 2` (line 2450)
```
     BUILD_MAP                0
     LOAD_CONST               0 (5)
     BUILD_TUPLE              2
     DUP_TOP
  -> UNPACK_SEQUENCE          2
     STORE_NAME               0 (a)
     STORE_NAME               1 (b)
     LOAD_NAME                0 (a)
     LOAD_NAME                1 (b)
     STORE_SUBSCR
     LOAD_CONST               1 (None)
     RETURN_VALUE
```
# }}}

# {{{ `UNPACK_SEQUENCE 2`
```
    +---------------+
    | value stack   |
    +---------------+
    |   ({}, 5)     |
    +---------------+
    |       5       |
    +---------------+
    |      {}       |
    +---------------+
```
# }}}

# {{{ `STORE_NAME 0` (line 2168)
```
     BUILD_MAP                0
     LOAD_CONST               0 (5)
     BUILD_TUPLE              2
     DUP_TOP
     UNPACK_SEQUENCE          2
  -> STORE_NAME               0 (a)
     STORE_NAME               1 (b)
     LOAD_NAME                0 (a)
     LOAD_NAME                1 (b)
     STORE_SUBSCR
     LOAD_CONST               1 (None)
     RETURN_VALUE
```
# }}}

# {{{ `STORE_NAME 0`
```
    +---------------+
    | value stack   |
    +---------------+
    |   ({}, 5)     |
    +---------------+
    |       5       |
    +---------------+

    +---------------+
    | name bindings |
    +---------------+
    |  a: {}        |
    +---------------+
```
# }}}

# {{{ `STORE_NAME 1` (line 2168)
```
     BUILD_MAP                0
     LOAD_CONST               0 (5)
     BUILD_TUPLE              2
     DUP_TOP
     UNPACK_SEQUENCE          2
     STORE_NAME               0 (a)
  -> STORE_NAME               1 (b)
     LOAD_NAME                0 (a)
     LOAD_NAME                1 (b)
     STORE_SUBSCR
     LOAD_CONST               1 (None)
     RETURN_VALUE
```
# }}}

# {{{ `STORE_NAME 1`
```
    +---------------+
    | value stack   |
    +---------------+
    |   ({}, 5)     |
    +---------------+

    +---------------+
    | name bindings |
    +---------------+
    |  a: {}        |
    +---------------+
    |  b:  5        |
    +---------------+
```
# }}}

# {{{ `LOAD_NAME 0` (line 2450)
```
     BUILD_MAP                0
     LOAD_CONST               0 (5)
     BUILD_TUPLE              2
     DUP_TOP
     UNPACK_SEQUENCE          2
     STORE_NAME               0 (a)
     STORE_NAME               1 (b)
  -> LOAD_NAME                0 (a)
     LOAD_NAME                1 (b)
     STORE_SUBSCR
     LOAD_CONST               1 (None)
     RETURN_VALUE
```
# }}}

# {{{ `LOAD_NAME 0`
```
    +---------------+
    | value stack   |
    +---------------+
    |   ({}, 5)     |
    +---------------+
    |    {}         |
    +---------------+

    +---------------+
    | name bindings |
    +---------------+
    |  a: {}        |
    +---------------+
    |  b:  5        |
    +---------------+
```
# }}}

# {{{ `LOAD_NAME 1` (line 2450)
```
     BUILD_MAP                0
     LOAD_CONST               0 (5)
     BUILD_TUPLE              2
     DUP_TOP
     UNPACK_SEQUENCE          2
     STORE_NAME               0 (a)
     STORE_NAME               1 (b)
     LOAD_NAME                0 (a)
  -> LOAD_NAME                1 (b)
     STORE_SUBSCR
     LOAD_CONST               1 (None)
     RETURN_VALUE
```
# }}}

# {{{ `LOAD_NAME 1`
```
    +---------------+
    | value stack   |
    +---------------+
    |   ({}, 5)     |
    +---------------+
    |    {}         |
    +---------------+
    |     5         |
    +---------------+

    +---------------+
    | name bindings |
    +---------------+
    |  a: {}        |
    +---------------+
    |  b:  5        |
    +---------------+
```
# }}}

# {{{ `STORE_SUBSCR` (line 1902)
```
     BUILD_MAP                0
     LOAD_CONST               0 (5)
     BUILD_TUPLE              2
     DUP_TOP
     UNPACK_SEQUENCE          2
     STORE_NAME               0 (a)
     STORE_NAME               1 (b)
     LOAD_NAME                0 (a)
     LOAD_NAME                1 (b)
  -> STORE_SUBSCR
     LOAD_CONST               1 (None)
     RETURN_VALUE
```
# }}}

# {{{ `STORE_SUBSCR`
```c
	TARGET_NOARG(STORE_SUBSCR)
	{
		w = TOP();
		v = SECOND();
		u = THIRD();
		STACKADJ(-3);
		/* v[w] = u */
		err = PyObject_SetItem(v, w, u);
		Py_DECREF(u);
		Py_DECREF(v);
		Py_DECREF(w);
		if (err == 0) DISPATCH();
		break;
	}
```

```
    +---------------+
    | value stack   | 
    +---------------+
    |   ({}, 5)     |  <--- u   \                        +----------------+
    +---------------+                                    |   value stack  |
    |    {}         |  <--- v  --->  v[w] = u  --->      +----------------+
    +---------------+                                    |   (empty)      |
    |     5         |  <--- w   /                        +----------------+
    +---------------+

    +---------------------------+
    | name bindings             |
    +---------------------------+
    |  a: {5: ({...},5)}        |
    +---------------------------+
    |  b:  5                    |
    +---------------------------+
```
# }}}

# {{{ `LOAD_CONST` & `RETURN_VALUE`
```
     BUILD_MAP                0
     LOAD_CONST               0 (5)
     BUILD_TUPLE              2
     DUP_TOP
     UNPACK_SEQUENCE          2
     STORE_NAME               0 (a)
     STORE_NAME               1 (b)
     LOAD_NAME                0 (a)
     LOAD_NAME                1 (b)
     STORE_SUBSCR
  -> LOAD_CONST               1 (None)
  -> RETURN_VALUE
```

Returns None
# }}}

# {{{ References

* [Philip Guo's Python Internals Lecture](https://www.youtube.com/playlist?list=PLwyG5wA5gIzgTFj5KgJJ15lxq5Cv6lo_0)
* [Python Tutor](http://www.pythontutor.com/)

# }}}
