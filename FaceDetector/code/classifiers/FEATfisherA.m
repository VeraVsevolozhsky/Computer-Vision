function [m_test] = FEATfisherA(m_test, F)

%[y, index] = sort(-abs(F.select));
%index = index(1:floor(size(m_test, 1)*F.rank));
m_test = m_test(F.index,:);
