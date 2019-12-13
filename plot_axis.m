function [] = plot_axis(x, y, titre, labelx, labely)

figure;

if x == 0
    plot(y);
    axis([0 length(y) min(y) max(y)]);
else
    plot(x,y);
    axis([min(x) max(x) min(y) max(y)]);
end

title(titre);
xlabel(labelx);
ylabel(labely);

end