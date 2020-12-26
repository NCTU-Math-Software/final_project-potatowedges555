function diceGame_MonteCarlo()
    % Input : none
    % Output : the probability that Peter wins
    % Example :
    % diceGame_MonteCarlo()
    
    % initialize the variables we later need
    N = 10^7;
    counter_Pwin = 0;
    counter_Plose = 0;
    counter_same = 0;
    
    % each person throw N times, and record each time who wins
    for ii = 1:N
        throw_P = round(rand(9, 1)*3 + 1);
        throw_C = round(rand(6, 1)*5 + 1);
        
        if(sum(throw_P) > sum(throw_C))
            counter_Pwin = counter_Pwin + 1;
        elseif(sum(throw_P) < sum(throw_C))
            counter_Plose = counter_Plose + 1;
        else
            counter_same = counter_same + 1;
        end
    end
    
    % calculate the probability
    disp('probability unit : %')
    prob_Pwin = roundn(counter_Pwin / N, -9) * 100
    prob_Plose = roundn(counter_Plose / N, -9) * 100
    prob_same = roundn(counter_same / N, -9) * 100
end
