function [m_test] = pearsonfeatA(m_test, r)

[y, index] = sort(-abs(r.select));
index = index(1:floor(size(m_test, 1)*r.rank));
m_test = m_test(index,:);
