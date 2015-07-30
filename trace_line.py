import sys


def factorial(n):
    if n == 0:
        return 1
    return n * factorial(n-1)


def trace_lines(frame, event, arg):
    if event != 'line':  # only interested in "line" events
        return

    code_object = frame.f_code

    print '%(func_name)s:%(line_no)s %(filename)s' % dict(
        func_name=code_object.co_name,
        line_no=frame.f_lineno,
        filename=code_object.co_filename)


def trace_calls(frame, event, arg):
    if event != 'call':  # only interested in "call" events

        return

    code_object = frame.f_code

    caller = frame.f_back

    if not caller:  # stop if we're are the top frame

        return

    print ('%(caller_filename)s:%(caller_line_no)s ==> %(func_name)s:%(func_line_no)s (%(func_filename)s) '
           'with %(args)r' % dict(
               caller_filename=caller.f_code.co_filename,
               caller_line_no=caller.f_lineno,
               func_name=code_object.co_name,
               func_line_no=frame.f_lineno,
               func_filename=code_object.co_filename,
               args=frame.f_locals,
           ))

    print

    return trace_lines  # trace functions can be chained


if __name__ == '__main__':
    sys.settrace(trace_calls)
    print factorial(5)
