import numpy

def propPositiveSine(a):
	b = numpy.sin(a)
	c = b > 0
	return numpy.sum(c) / c.size
    