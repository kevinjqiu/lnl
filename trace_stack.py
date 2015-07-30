import sys


def factorial(n):
    if n == 0:
        return 1
    return n * factorial(n-1)


def trace_stack(frame, event, arg):
    code_object = frame.f_code  # code object

    if event == 'call':
        caller = frame.f_back
        if not caller:
            return

        print ('%(caller_filename)s:%(caller_line_no)s ==> %(func_name)s:%(func_line_no)s (%(func_filename)s) '
               'with %(args)r' % dict(
                   caller_filename=caller.f_code.co_filename,
                   caller_line_no=caller.f_lineno,
                   func_name=code_object.co_name,
                   func_line_no=frame.f_lineno,
                   func_filename=code_object.co_filename,
                   args=frame.f_locals))

        return trace_stack
    elif event == 'return':
        print '%s => %s' % (code_object.co_name, arg)


if __name__ == '__main__':
    sys.settrace(trace_stack)
    print factorial(5)
