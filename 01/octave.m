clear;
pkg load statistics;

M=dlmread("bacground_gamma_radiation_7s_per_measure.csv",',',1,0);

gamma_ticks=M(:,2);

number_of_ticks = (0:max(gamma_ticks))';

ticks_dist=histc(gamma_ticks,number_of_ticks);

measurements_no=length(gamma_ticks);


m=mean(gamma_ticks);
variance=var(gamma_ticks);

deg_of_freedom = length(ticks_dist)-2;

P_i = poisspdf(number_of_ticks,m);
nP_i = P_i*measurements_no;

square_dev=((ticks_dist - nP_i).^2) ./ nP_i;
chi2_val = sum(square_dev);



alfa = 0.05;

chi2_critical= chi2inv(1-alfa,deg_of_freedom);

p_value = 1-chi2cdf(chi2_val,deg_of_freedom);

fprintf('Średnia m: %.4f\n',m);
fprintf('Wariancja: %.4f\n',variance);
fprintf('Statystyka chi2: %.4f\n', chi2_val);
fprintf('Wartość krytyczna chi2 (dla alfa=%.2f): %.4f\n', alfa, chi2_critical);
fprintf('P-value: %.4f\n', p_value);

if chi2_val < chi2_critical
    fprintf('Hipoteza o zgodności z rozkładem Poissona przyjęta.\n');
else
    fprintf('Hipoteza odrzucona.\n');
end

tab=[number_of_ticks, ticks_dist, P_i, nP_i, square_dev];

fname='dane_rozkladu.csv';
file=fopen(fname,'w');
fprintf(file,'"liczba zliczen","rozklad doswiadczalny","prawdopodobiensto Poissona","rozkład teoretyczny", "względne odchylenie kwadratów"\n');
fclose(file);
dlmwrite(fname, tab,'-append');
  



data = [ticks_dist, nP_i];

figure;
set(gca, 'FontName', 'Times New Roman', 'FontSize', 16);
b=bar(number_of_ticks, data);

set(b(1), 'FaceColor', '#000000');
set(b(2), 'FaceColor', '#f37b21');

xlabel('Liczba zarejestrowanych impulsów','FontName', 'Times New Roman', 'FontSize', 16);
ylabel('Liczba wystąpień','FontName', 'Times New Roman', 'FontSize', 16);

lgd = legend('Rozkład doświadczalny', 'Rozkład teoretyczny');
set(lgd, 'FontName', 'Times New Roman', 'FontSize', 12, 'Location', 'northeast');

