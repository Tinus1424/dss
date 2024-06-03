import numpy as np
from sklearn.metrics.pairwise import paired_cosine_distances
from sklearn.feature_extraction.text import CountVectorizer
from scipy.sparse import hstack


def majority(train, test):
    # .................................................................

    classes, counts = np.unique(train, return_counts=True)
    classes_test, counts_test = np.unique(test, return_counts=True)
    maj = np.argmax(counts)
    return counts_test[maj]/np.sum(counts_test)


def features_mean(signal):
    #...............................
    return signal.mean(axis=2)



        
def features(signal, functions):
#.........................................    
    return np.concatenate([ function(signal, axis=2) for function in functions ], axis=1)        


def counts(train_text, test_text):
#........................................    
    #Use the object `sklearn.preprocessing.text.CountVectorizer` to extract word counts 
    #from the first column and the second column of the same-or-different dataset. 
    
    vec1 = CountVectorizer()
    vec2 = CountVectorizer()

    train_counts1 = vec1.fit_transform(train_text[:,0])
    train_counts2 = vec2.fit_transform(train_text[:,1])
    test_counts1 = vec1.transform(test_text[:,0])
    test_counts2 = vec2.transform(test_text[:,1])
    #Then use the function `scipy.sparse.hstack` to create a single matrix which holds 
    #word counts for both the first and the second sentence.

    train_counts = hstack([train_counts1, train_counts2])
    test_counts = hstack([test_counts1, test_counts2])
    
    
    return (train_counts, test_counts)

def cosine_feat(train_text, test_text):
    vec = CountVectorizer()
    train_counts = vec.fit_transform(np.hstack([train_text[:,0], train_text[:,1]]))
    train_counts1 = train_counts[:train_text.shape[0],:]
    train_counts2 = train_counts[train_text.shape[0]:,:]
    test_counts1 = vec.transform(test_text[:,0])
    test_counts2 = vec.transform(test_text[:,1])
    train_sim = 1-paired_cosine_distances(train_counts1, train_counts2)
    test_sim = 1-paired_cosine_distances(test_counts1, test_counts2)
    return (train_sim, test_sim)