import numpy
def inverse_logit(z):
    #..................................
    return 1/(1+numpy.exp(-z))

def predict_proba(wb, X):
    #...............................
    return inverse_logit(X.dot(wb['w']) + wb['b'])

def predict(wb, X):
    #.............................
    return (predict_proba(wb, X) >= 0.5).astype('int')

def update(wb, x, y, eta):
    #.............................
    p_pred = predict_proba(wb, x)
    wb['w'] += eta*(y-p_pred)*x
    wb['b'] += eta*(y-p_pred)
    
    return -y*numpy.log2(p_pred)-(1-y)*numpy.log2(1-p_pred)

def fit(wb, X, y, eta=0.01):
    #..................................
    assert X.shape[0] == y.shape[0]
    # List comprehension
    return sum(update(wb, X[i,:], y[i], eta) for i in range(X.shape[0]))

def fit2(wb, X, y, eta=0.01):
    #..................................
    assert X.shape[0] == y.shape[0]
    # Explicit for loop
    loss = []
    for i in range(X.shape[0]):
        L = update(wb, X[i,:], y[i], eta)
        loss.append(L)
    return sum(loss)