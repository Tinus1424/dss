import numpy as np
from math import log

def inverse_logit(z):
    return 1/(1+ np.exp(-z))

def predict_proba(wb, X):
    return inverse_logit(X.dot(wb['w']) + wb['b'])

def predict(wb, X):
    return (predict_proba(wb, X) >= 0.5).astype('int')

def update(wb, x, y, eta):
    p = predict_proba(wb , x)
    wb["w"] += eta * (y - p) * x
    wb["b"] += eta * (y - p)
    return -y*np.log2(p) - (1 - y) * np.log2(1 - p)

def fit(wb, X, y, eta = 0.1):
    assert X.shape[0] == y.shape[0]
    return sum(update(wb, X[i,:], y[i], eta) for i in range(X.shape[0]))