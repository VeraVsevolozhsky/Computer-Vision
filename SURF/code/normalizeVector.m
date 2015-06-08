function descFeatures = normalizeVector(descFeaturesVec)
normVal      = norm(descFeaturesVec);
descFeatures = descFeaturesVec./normVal;