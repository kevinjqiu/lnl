import sys


def factorial(n):
    if n == 0:
        return 1
    return n * factorial(n-1)


def trace_stack(frame, event, arg):
    co = frame.f_code  # code object
    func_name = co.co_name

    if event == 'call':
        func_line_no = frame.f_lineno

        func_filename = co.co_filename

        args = frame.f_locals

        caller = frame.f_back
        if not caller:
            return

        caller_line_no = caller.f_lineno

        caller_filename = caller.f_code.co_filename

        print ('%(caller_filename)s:%(caller_line_no)s '
               '==> %(func_name)s:%(func_line_no)s (%(func_filename)s) '
               'with %(args)r' % locals())

        return trace_stack
    elif event == 'return':
        print '%s => %s' % (func_name, arg)


if __name__ == '__main__':
    sys.settrace(trace_stack)
    print factorial(5)
