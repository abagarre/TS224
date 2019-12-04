function [] = subplot_axis(x, y, val)

subplot(val);
if x == 0
    plot(y);
    axis([0 length(y) min(y) max(y)]);
else
    plot(x,y);
    axis([min(x) max(x) min(y) max(y)]);
end

end
