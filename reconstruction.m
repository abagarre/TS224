function [B_M] = reconstruction(B_win, power_divide, N, L)


B_M = zeros(N/2,2^(power_divide+1));
B_M(:,1) = B_win(1,1:N/2);
for i = 2:2^(power_divide+1)-1
    B_M(:,i) = B_win(i,1:N/2) + B_win(i-1,(N/2+1):N);
end
B_M(:,i+1) = B_win(i,N/2+1:N);
B_M = reshape(B_M, [L,1]);

end

