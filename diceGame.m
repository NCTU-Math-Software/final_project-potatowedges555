function diceGame2()
    % Input : none
    % Output : the probability that Peter wins
    % Example :
    % diceGame()
    
    % initialize the variables we later need
    P_comb = zeros([36 1]);
    counter_P = 9;
    C_comb = zeros([36 1]);
    counter_C = 6;
    for ii = 1:9
        P_9choosek(ii) = nchoosek(9, ii);
        if(ii <= 6)
            C_6choosek(ii) = nchoosek(6, ii);
        end
    end
    
    % Step 1 : Calculate the numbers of Peter's and Colin's dice throwing combinition
    for s = 6:8
        C_comb(counter_C) = nchoosek(s-6+6-1, s-6);
        for ii = 1:6
            tempC = 0;
            condition = s-7*ii-1*(6-ii);
            if(condition >= 0)
                tempC = C_6choosek(ii) * nchoosek(condition+6-1, condition);
                sign = (-1)^mod(ii, 2);
                disp(['C_comb now:', num2str(C_comb(counter_C)),'tempC:', num2str(tempC)])
                C_comb(counter_C) = C_comb(counter_C) + sign * tempC;
                disp(['ii:', num2str(ii), 'tempC:', num2str(tempC), 'tempC_n:', num2str(condition+6-1), 'temp_C_k:', num2str(condition)])
            else
                break
            end
        end
        disp(['n_C:', num2str(counter_C + 5), 'num:', num2str(C_comb(counter_C))])
        counter_C = counter_C + 1;
    end
    for s = 9:36
        C_comb(counter_C) = nchoosek(s-6+6-1, s-6);
        for ii = 1:6
            tempC = 0;
            condition = s-7*ii-1*(6-ii);
            if(condition >= 0)
                tempC = C_6choosek(ii) * nchoosek(condition+6-1, condition);
                sign = (-1)^mod(ii, 2);
                disp(['C_comb now:', num2str(C_comb(counter_C)),'tempC:', num2str(tempC)])
                C_comb(counter_C) = C_comb(counter_C) + sign * tempC;
                disp(['ii:', num2str(ii), 'tempC:', num2str(tempC), 'tempC_n:', num2str(condition+6-1), 'temp_C_k:', num2str(condition)])
            else
                break
            end
        end
        disp(['n_C:', num2str(counter_C), 'num:', num2str(C_comb(counter_C))])
        counter_C = counter_C + 1;
        
        P_comb(counter_P) = nchoosek(s-9+9-1, s-9);
        for ii = 1:9
            tempP = 0;
            condition = s- 5*ii-1*(9-ii);
            if(condition >= 0)
                tempP = P_9choosek(ii) * nchoosek(condition+9-1, condition);
                sign = (-1)^mod(ii, 2);
                disp(['P_comb now:', num2str(P_comb(counter_P)),'tempP:', num2str(tempP)])
                P_comb(counter_P) = P_comb(counter_P) + sign * tempP;
                disp(['ii:', num2str(ii), 'tempP:', num2str(tempP), 'tempP_n:', num2str(condition+9-1), 'temp_P_k:', num2str(condition)])
            else
                break
            end
        end
        disp(['n_P:', num2str(counter_P), 'num:', num2str(P_comb(counter_P))])
        counter_P = counter_P + 1;
    end
    
    % Step 2 : Calculate the number of Peter wins
    sum_Pwin = 0;
    sum_Plose = 0;
    sum_same = 0;
    % Case I : C=6~8, P=any possible sum
    sum_Pwin = sum_Pwin + sum(C_comb(6:8)) * sum(P_comb); % 若C總和落在6~8，則P不管怎樣都贏
    disp('P:')
    disp(P_comb)
    disp('C:')
    disp(C_comb)
    % Case II, III and IV：(C>=9 and P win) or (C>=9 and P lose) or(平手)
    for s = 9:36 % 每次迴圈固定C/P總和
        sum_Pwin = sum_Pwin + sum(P_comb(s+1:36)) * sum(C_comb(s));
        sum_Plose = sum_Plose + sum(C_comb(s+1:36)) * sum (P_comb(s));
        sum_same = sum_same + C_comb(s) * P_comb(s);
    end
    
    % Step 3 : Print the probability that Peter wins
    format long g % 取消科學記號表示數值
    disp(['sum_Pcomb:', num2str(sum(P_comb)), 'sum_Ccomb:', num2str(sum(C_comb))])
    disp(['sum_Pwin:', num2str(sum_Pwin), 'sum_Plose:', num2str(sum_Plose), 'sum_same:', num2str(sum_same)])
    prob_Pwin = roundn(sum_Pwin / sum(P_comb) / sum(C_comb), -9) * 100
    prob_Plose = roundn(sum_Plose / sum(P_comb) / sum(C_comb), -9) * 100
    prob_same = roundn(sum_same / sum(P_comb) / sum(C_comb), -9) * 100
    sum_prob = prob_same + prob_Plose + prob_Pwin
end
