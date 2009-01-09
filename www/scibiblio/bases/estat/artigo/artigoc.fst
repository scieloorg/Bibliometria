1 0 v880*1.9  /* issn scielo - citante */

2 0 v880*10.4 /* ano de publicacao */

12 0 v880*1.9,v880*10.4

13 0 v880*1.9'44_'if p(v30) and a(v18) then proc('d30<30 99>',e1:=l(['../tab30/tc30issn']mpu,v30,mpl),if e1>0 then ref(['../tab30/tc30issn']e1,if p(v222^a) then mpu,v222^a else if p(v2) then '~~2_'v2 else '~~1_'v1 fi, fi,mpl) else '~~*_'v30 fi,'</30>'),if v30>'' then v30 fi, fi /* chave para listar citados ou citantes */

4 0 '65_'v65.4 /* ano de publicacao da revista citada */

444 0 '44_'if p(v30) and a(v18) then proc('d30<30 99>',e1:=l(['../tab30/tc30issn']mpu,v30,mpl),if e1>0 then ref(['../tab30/tc30issn']e1,if p(v222^a) then mpu,v222^a else if p(v2) then '~~2_'v2 else '~~1_'v1 fi, fi,mpl) else '~~*_'v30 fi,'</30>'),if v30>'' then v30 fi, fi /* revista citada - sem limite= 60 caracteres - usando ../tab30/tc30issn */

446 0 '44_'if p(v30) and a(v18) then ,if v30>'' then v30.46 fi, fi /* revista citada - limitada a 46 caracteres - usando ../tab30/tc30issn */

44 0 '44i_'ref(['../tab30/tc30issn']l(['../tab30/tc30issn']mpu,v30),if v400>'' then v400 else, if v22^a>'' then v22^a else v22 fi, fi) /* issn da revista citada - usado em muitos nposts */

401 0 v880*10.4'44_'if p(v30) and a(v18) then ,if v30>'' then v30.46 fi, fi /* chave para cálculo da Meia-Vida e Fator de Impacto */

402 0 v880*10.4'44_'if p(v30) and a(v18) then ,if v30>'' then v30.46 fi, fi'65_'v65.4 /* chave para cálculo do num. de cits. recebidas - Meia-Vida */

403 0 v880*10.4'_'v880*1.9 /* chave para cálculo do num. de cits. concedidas - lista de dados fonte */

