function acc = CLUSTERINGSCOREaccuracy(lab1,lab2)

len1 = length(lab1);
len2 = length(lab2);

if size(lab1,1)<size(lab1,2)
    lab1 = lab1';
end

if size(lab2,1)<size(lab2,2)
    lab2 = lab2';
end

if (len1~=len2)
    error('not the same lengths');
end

labset1 = unique(lab1);
labset2 = unique(lab2);
same1 = zeros(len1,len1);
same2 = zeros(len2,len2);
for i = 1:length(labset1),
    tmp = double(lab1==labset1(i));
    same1 = same1 + tmp*tmp';
end
for i = 1:length(labset2),
    tmp = double(lab2==labset2(i));
    same2 = same2 + tmp*tmp';
end
t1 = (sum(sum(same1))-len1)/2;
t2 = (sum(sum(~same1)))/2;
s1 = sum(sum(~(eye(len1)).*same1.*same2))/2;
s2 = sum(sum(~same1.*~same2))/2;
%[s1, s2, t1, t2]
acc = ((s1/(t1))+(s2/(t2)))/2;
