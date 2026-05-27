%% For loop Rand checker


% x = 345;
% if x == 345
%     disp("True")
% end

counter = 0;
counter2 = 0;
counter3 = 0;
for r = rand(1, 100)

    if r > 0.5
        counter = counter + 1;
    elseif r < 0.2
        counter2 = counter2 + 1;
    else
        counter3 = counter3 + 1;
    end
end

disp("The number of values greater than 0.5 is: " + counter)
disp("The number of values greater than 0.2 is: " + counter2)
disp("The number of values in between 0.2 and 0.5 is: " + counter3)
% disp(counter)



%% While Loop

% counter4 = 0;
x = 0;
while x <= 5
    x = x + 0.25;  % x: 4.75 -> 5 -> 5.25
    disp(x) % disp(5) disp(5.25)
end


%% Break and Continue
% for i = 1:10
%     if i == 4
%         continue
%     end
%     disp(i)
% end


% for i = 1:10
%     if i == 4
%         disp("Hurrah! we found 4!")
%         break
%     end
%     disp("Sad! We didn't find 4 yet.")
% end


%% AND, OR operator

% 'even' or 'odd'
for i = 1:10
   
    % if i == 2
    %     disp("EVEN 2")
    % elseif i == 4
    %     disp("EVEN 4")
    % elseif i == 6
    %     disp("EVEN 6")
    % elseif i == 8
    %     disp("EVEN 8")
    % elseif i == 10
    %     disp("EVEN 10")
    % end


    if i == 2 || i==4 || i==6 || i==8 || i==10
        disp("EVEN " + i)
    end
end


% check if a number is divisible by 3 and 5 both