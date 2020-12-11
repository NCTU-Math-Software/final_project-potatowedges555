function diceGame()
    P_comb = [];
    counter_P = 1;
    C_comb = [];
    counter_C = 1;
    
    % Step 1
    for s = 6:8
        C_comb(counter_C) = nchoosek(s+6-1, s);
        counter_C = counter_C + 1;
    end
    for s = 9:36
        P_comb(counter_P) = nchoosek(s+9-1, s)
        C_comb(counter_C) = nchoosek(s+6-1, s);
        counter_P = counter_P + 1;
        counter_C = counter_C + 1;
    end
    
    % Step 2
    sum_Pwin = 0;
    % Case I
    sum_Pwin = sum_Pwin + sum(C_comb(1:3)) * sum(P_comb); % 若C總和落在6~8，則P不管怎樣都贏
    % Case II
    for s = 9:36 % 每次迴圈固定C總和
        sum_Pwin = sum_Pwin + sum(P_comb(s-7:36-8));
    end
    
    % Step 3
    format long g % 取消科學記號表示數值
    ans = roundn(sum_Pwin / (sum(P_comb) + sum(C_comb)), -7);
end


%{
平局：a1+a2+a3+...+a9 = b1+b2+...+b6
P勝：a1+a2+...+a9 > b1+...+b6
C勝：a1+...+a9 < b1+...+b6

&&&控制程式在1min.內跑完
step1：
先找出Peter跟Colin分別的所有骰子總和各有多少可能性C(n+#dice-1, n)
&&& a1+...+a9 = 35，但ai有可能是>4的數字
a1+...+a9 = s1, 9 <= s1<= 36
b1+...+b6 = s2, 6 <= s2<= 36
則遊戲結局有total = # of Peter's comb. + # of Colin's comb.那麼多種

step2：
CaseI - 
Colin總和＝6～8，則Peter不管丟什麼都會贏
CaseII - 
Colin丟>=9，則用loop固定Colin骰子總和，算Peter win共幾種可能性
			  
step3：
算Peter win機率
%}
