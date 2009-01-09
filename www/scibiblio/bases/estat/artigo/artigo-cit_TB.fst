1 0 v1^t  /* issn scielo - citante */

2 0 if v1^y<>'' then v1^y fi /* ano de publicacao */

3 0 if v1^c>'' and v1^c.1<>'~' then '44_'v1^c.57 fi /* revista citada - limite de 57 caracteres */

31 0 if v1^c='' and v1^i<>'' then '44_'ref(['../tab30/tc30issn']l(['../tab30/tc30issn']v1^i),mpu,v100.57,mpl) fi /* revista citada quando seleciona-se toda a colecao - limite de 57 caracteres */

4 0 if v1^a<>'' then '65_'v1^a.4 fi /* ano de publicacao da revista citada */

5 0 if v1^i<>'' then '44i_'v1^i fi /* issn da revista citada - usado em muitos nposts e citas concedidas */

