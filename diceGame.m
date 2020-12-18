function diceGame()
    % Input : none
    % Output : the probability that Peter wins
    % Example :
    % diceGame()
    
    % initialize the variables we later need
    P_comb = [];
    counter_P = 1;
    C_comb = [];
    counter_C = 1;
    
    % Step 1 : Calculate the numbers of Peter's and Colin's dice throwing combinition
    for s = 6:8
        C_comb(counter_C) = nchoosek(s-6+6-1, s-6);
        for ii = 1:6
            tempC = 0;
            if(s-6 >=  4* ii) % ii個骰子>=4
                disp('yes')
                tempC = nchoosek(6, ii) * nchoosek(s-6-4*ii+6-1, s-6-4*ii);
                sign = mod(ii, 2)*(-1);
                C_comb(counter_C) = C_comb(counter_C) - sign*tempC;
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
            if(s-6 >=  4* ii) % ii個骰子>=4
                disp('yes')
                tempC = nchoosek(6, ii) * nchoosek(s-6-4*ii+6-1, s-6-4*ii);
                sign = mod(ii, 2)*(-1);
                C_comb(counter_C) = C_comb(counter_C) - sign*tempC;
            else
                break
            end
        end
        disp(['n_C:', num2str(counter_C + 5), 'num:', num2str(C_comb(counter_C))])
        counter_C = counter_C + 1;
        
        P_comb(counter_P) = nchoosek(s-9+9-1, s-9);
        for ii = 1:9
            tempP = 0;
            if(s-9 >=  4* ii) % ii個骰子>=4
                disp('yes')
                tempP = nchoosek(9, ii) * nchoosek(s-9-4*ii+9-1, s-9-4*ii);
                sign = mod(ii, 2)*(-1);
                P_comb(counter_P) = P_comb(counter_P) - sign*tempP;
            else
                break
            end
        end
        disp(['n_P:', num2str(counter_P + 8), 'num:', num2str(P_comb(counter_P))])
        counter_P = counter_P + 1;
    end
    
    % Step 2 : Calculate the number of Peter wins
    sum_Pwin = 0;
    % Case I
    sum_Pwin = sum_Pwin + sum(C_comb(1:3)) * sum(P_comb); % 若C總和落在6~8，則P不管怎樣都贏
    % Case II
    for s = 9:36 % 每次迴圈固定C總和
        sum_Pwin = sum_Pwin + sum(P_comb(s-7:36-8));
    end
    
    % Step 3 : Print the probability that Peter wins
    format long g % 取消科學記號表示數值
    ans = roundn(sum_Pwin / (sum(P_comb) + sum(C_comb)), -7)
end


%{
平局：a1+a2+a3+...+a9 = b1+b2+...+b6
P勝：a1+a2+...+a9 > b1+...+b6
C勝：a1+...+a9 < b1+...+b6

&&&控制程式在1min.內跑完
step1：
先找出Peter跟Colin分別的所有骰子總和各有多少可能性C(n+#dice-1, n)
注意：Peter骰子的點數範圍須限制在1～4間，Colin骰子的點數範圍須限制在1～6間(用排容原理)
雖然不可能同時所有骰子都>4或=0，但只要是有至少一個出現>4或=0的狀況就都要扣掉
&&& a1+...+a9 = 35，但ai有可能是>4的數字
a1+...+a9 = s1, 9 <= s1 <= 36, 1 <= ai <= 4
>> p1+...+p9 = s1-9, 0 <= pi <= 3, pi = ai-1
>> C(s1-9+9-1, s1-9) - sigma(一個骰子>3) + sigma(兩個骰子>3)-....-sigma(九個骰子>3)
   q1+p2+...+p9 = s1-9-4, qi >= 4, qi = pi-4
b1+...+b6 = s2, 6 <= s2 <= 36, 1 <= bi <= 4
>> m1+...+m6 = s2-6, 1 <= mi <= 3, mi = bi-1
>> C(s2-6+6-1, s2-6) - sigma(一個骰子>3) + sigma(兩個骰子>3)-....-sigma(六個骰子>3)
   n1+m2+...+m6 = s2-4, ni >= 4, ni = mi-4
則遊戲結局有total = # of Peter's comb. + # of Colin's comb.那麼多種

step2：
CaseI - 
Colin總和＝6～8，則Peter不管丟什麼都會贏
CaseII - 
Colin丟>=9，則用loop固定Colin骰子總和，算Peter win共幾種可能性
			  
step3：
算Peter win機率
%}
