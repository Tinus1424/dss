import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

train_data = FILEPATH
test_data = FILEPATH
supp_data = FILEPATH

from sklearn.metrics import mean_absolute_error
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import TimeSeriesSplit
from sklearn.ensemble import RandomForestRegressor
from sklearn.model_selection import GridSearchCV

SELECT = ["UserID", "TimeUtc", "CurrentSessionLength", "LevelProgressionAmount", "QuestionType", "ResponseValue"]
FEATURES =  ["TimeUtc", "CurrentSessionLength", "LevelProgressionAmount"]

TESTSELECT = ["UserID", "TimeUtc", "CurrentSessionLength", "LevelProgressionAmount", "QuestionType"]
TARGET = ["ResponseValue"]

G = train_data
S = supp_data
GS = pd.concat([G, S])
GS = GS.reset_index()
GS = GS.sort_values(by = ["UserID"])
GS1 = GS[SELECT]
GS2 = fillLPA(GS1)
GS3 = numericalTime(GS2)
GS4 = binaryQuestion(GS3)
GS0 = scaleVariables(GS4)

pGrid = {
    "max_depth": [3, 5],
    "max_features": [2, 10],
    "min_samples_split": [10, 20]
}

rfcvList = {}
modelCV = {}
grouped = GS0.groupby("UserID")
notIncluded = {}


for UserID, data in grouped:
    data = data.reset_index()
    dataSize = len(data)
    testSize = int(dataSize * 0.7)
    if testSize < 3:
        continue
    train, test = data.iloc[:testSize], data.iloc[testSize:]
    X, y = train[FEATURES], np.ravel(train[TARGET])
    X_test, y_test = test[FEATURES], np.ravel(test[TARGET])
    
    tscv = TimeSeriesSplit(n_splits = 2)
    rf = RandomForestRegressor(criterion = "squared_error")
    rfcv = GridSearchCV(estimator = rf,
                        cv = tscv,
                        param_grid = pGrid,
                        scoring='neg_mean_absolute_error',
                        n_jobs =-1)
    rfcv = rfcv.fit(X, y)
    bestModel = rfcv.best_estimator_
    bestParams = rfcv.best_score_
    testPredict = bestModel.predict(X_test)
    testTrue = y_test
    testMAE = mean_absolute_error(testTrue, testPredict)
    rfcvList[UserID] = rfcv
    modelCV[UserID] = bestModel

grouped = GS0.groupby("UserID")
finalModel = {}
for UserID, data in grouped: 
    data = data.reset_index()
    X, y = data[FEATURES], np.ravel(data[TARGET])
    if UserID in modelCV:
        rf = modelCV[UserID]
    else:
        rf = RandomForestRegressor(max_depth = 5, max_features = 10, min_samples_split=10)
    rf.fit(X, y)
    finalModel[UserID] = rf
    
X = G0[FEATURES]
y = np.ravel(G0[TARGET])
rf1 = RandomForestRegressor(max_depth = 5, max_features = 10, min_samples_split=10)
rf1.fit(X,y)
finalModel["NoID"] = rf1

y = test_data
y1 = y[TESTSELECT]
y2 = fillLPA(y1)
y3 = numericalTime(y2)
y4 = binaryQuestion(y3)
y0 = scaleVariables(y4)

yGrouped = y0.groupby("UserID")
ypreds = []

for UserID, data in yGrouped:
    data = data.reset_index()
    data = data[FEATURES]
    if UserID in finalModel:
        userPredictions = finalModel[UserID].predict(data)
    else:
        userPredictions = finalModel["NoID"].predict(data)
    ypreds.extend(userPredictions)

np.savetxt("predicted.csv", ypreds)