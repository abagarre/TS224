function [H_hankel] = hankel_transform(H)


H_flip = flip(H);

for i=1:length(H_flip)-1
    diag_sum = H_flip(i);
    num = 1; num2 = 1;
    j = i+length(H_flip)+1;
    while num < length(H_flip) - i + 1
       diag_sum = diag_sum + H_flip(j);
       num = num + 1;
       j = j+length(H_flip)+1;
    end
    j = i;
    H_flip(j) = diag_sum/num;
    j = i+length(H_flip)+1;
    while num2 < length(H_flip) - i + 1
       H_flip(j) = diag_sum/num;
       num2 = num2 + 1;
       j = j+length(H_flip)+1;
    end
end

H_flip = H_flip';

for i=1:length(H_flip)-1
    diag_sum = H_flip(i);
    num = 1; num2 = 1;
    j = i+length(H_flip)+1;
    while num < length(H_flip) - i + 1
       diag_sum = diag_sum + H_flip(j);
       num = num + 1;
       j = j+length(H_flip)+1;
    end
    j = i;
    H_flip(j) = diag_sum/num;
    j = i+length(H_flip)+1;
    while num2 < length(H_flip) - i + 1
       H_flip(j) = diag_sum/num;
       num2 = num2 + 1;
       j = j+length(H_flip)+1;
    end
end

H_hankel = flip(H_flip');


end

