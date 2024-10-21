%funkcja wyjsciowa
N = 500;
t = linspace(0, 5*pi, N); 
signal = sin(t); 
c = sqrt(3)
noise = -c+(c-(-c))*rand(1,N);
final = signal + noise;

hold on;
plot(t, final,'.');
plot(t,signal,'-')
hold off;

H_v = 1:50;

estimated=zeros(length(H_v),N)

for i = 1:length(H_v)
    H = H_v(i);
    temp = zeros(1, N);          
    for j = 1:N
        if j < H
            temp(j) = mean(final(1:j)); 
        else
            temp(j) = mean(final(j-H+1:j)); 
        end
    end
    estimated(i, :) = temp;      
end

% Wykres estymacji dla H=10 jako przykład
%{
H_example = 30;                  % wybierz H do wizualizacji
figure;
hold on;
plot(t, final, '.', 'DisplayName', 'Sygnał zaszumiony');
plot(t, estimated(H_example, :), '-', 'DisplayName', ['Estymowany sygnał dla H = ', num2str(H_example)]);
plot(t, signal, '-', 'DisplayName', 'Sygnał oryginalny');
hold off;

title(['Estymacja sygnału dla H = ', num2str(H_example)]);
xlabel('Czas (t)');
ylabel('Amplituda');
legend show;
grid on;
%}