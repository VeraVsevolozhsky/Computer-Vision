function [m_test] = FEATksA(m_test, d)

[y, index] = sort(-abs(d.select));
index = index(1:floor(size(m_test, 1)*d.rank));
m_test = m_test(index,:);
