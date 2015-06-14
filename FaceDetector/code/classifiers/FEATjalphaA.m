function [m_test] = FEATjalphaA(m_test, param)

m_test=(diag(sqrt(abs(param.alpha)))*m_test);