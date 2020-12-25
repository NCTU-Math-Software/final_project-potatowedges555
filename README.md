# final_project-potatowedges555
final_project-potatowedges555 created by GitHub Classroom

## final project 0713316施欣宜<br>
要包含：題目、作法、有引用他人程式碼需註記

### Problem：<br>
彼得有九個四面體骰子, 每個骰子上有數字 1–4；<br>
科林有六個立方體骰子, 每個骰子上有數字 1–6.<br>
兩個人各自丟自己的骰子, 並算其總和, 總和高者贏, 若總和相同則為平局.<br>
試問彼得贏的機率為何? 請將數字四捨五入至小數點後第七位.

### Method：<br>
#### Step 1.分別計算Peter和Colin的丟骰子組合總數 
(1) 設ai為Peter的每顆骰子丟出的點數
    則 a1 + a2 + ... + a9 = sumP, 1 <= ai <= 4，1 <= i <= 9，9 <= sumP <= 36
    then p1 + p2 + ...+ pk + ... + p9 = sumP - 5 * (k) - 1 * (9-k)，0 <= k <= 9, pi = ai-5 if 1 <= i <= k；pi = ai-1 if k < i <= 9
    By 排容原理，Peter丟骰子的組合總數=nchoosek(sumP-9+9-1, sumP-9) + sigma((-1)^mod(i, 2) * nchoosek(9, i) * nchoosek(s-5*i-1*(9-i)+9-1, s-5*i-1*(9-i)))
(2) 設bi為Colin的每顆骰子丟出的點數
    後續過程類似前述
    
#### Step 2.計算Peter win, lose and 平手的狀況
(1) Peter贏的狀況
    Peter點數總和>Colin點數總和，則Peter贏
    => (Colin某點數和的組合數) * (Peter點數和>此時Colin點數和的組合)，跑迴圈(每次迴圈固定Colin的點數和)
(2) Peter輸的狀況
    Peter點數總和<Colin點數總和，則Peter輸
    => (Peter某點數和的組合數) * (Colin點數和>此時Peter點數和的組合)，跑迴圈(每次迴圈固定Peter的點數和)
(3) Peter跟Colin平手的狀況
    Petr點數總和=Colin點數總和，則兩人平手
    => (Peter某點數和的組合數) * (Colin某點數和的組合數)，跑迴圈(每次迴圈兩人點數相同)
    
#### Step 3.print Peter win, lose and 平手的機率
(1) Peter贏的機率=Peter贏的狀況/(Peter丟出的所有組合數*Colin丟出的所有組合數)
(2) Peter輸的機率=Peter輸的狀況/(Peter丟出的所有組合數*Colin丟出的所有組合數)
(3) 平手的機率=平手的狀況/(Peter丟出的所有組合數*Colin丟出的所有組合數)

#### 算出的答案
prob_Pwin = 57.3144077
prob_Plose = 35.6089753
prob_same = 7.076617
全部機率相加約為＝100%

### Executed Code：<br>
diceGame.m
