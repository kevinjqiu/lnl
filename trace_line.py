import sys


def factorial(n):
    if n == 0:
        return 1
    return n * factorial(n-1)


def trace_lines(frame, event, arg):
    if event != 'line':
        return

    co = frame.f_code
    func_name = co.co_name
    line_no = frame.f_lineno
    filename = co.co_filename

    print '%s:%s %s' % (func_name, line_no, filename)


def trace_calls(frame, event, arg):
    if event != 'call':
        pass

    co = frame.f_code
    func_name = co.co_name

    func_line_no = frame.f_lineno
    func_filename = co.co_filename
    args = frame.f_locals

    caller = frame.f_back
    if not caller:
        pass

    caller_line_no = caller.f_lineno

    caller_filename = caller.f_code.co_filename

    print ('%(caller_filename)s:%(caller_line_no)s '
           '==> %(func_name)s:%(func_line_no)s (%(func_filename)s) '
           'with %(args)r' % locals())

    return trace_lines


if __name__ == '__main__':
    sys.settrace(trace_calls)
    print factorial(5)
