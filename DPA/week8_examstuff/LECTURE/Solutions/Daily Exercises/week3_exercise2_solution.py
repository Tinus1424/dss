import numpy

def summaryStatistic(a, b, c):
    a_x = numpy.square(a - numpy.mean(a))
    b_x = numpy.abs(b - numpy.median(b))
    c_x = numpy.sqrt(numpy.abs(c - numpy.mean(c)))

    num = numpy.sum(a_x * b_x * c_x)

    a_y = numpy.square(numpy.sum(a - numpy.mean(a)))
    b_y = numpy.sum(b_x)
    c_y = numpy.sum(c_x)

    denom = a_y * b_y * c_y

    return num / denom