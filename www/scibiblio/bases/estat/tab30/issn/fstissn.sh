
mx /bases/estat/tab30/issn/issn1 "fst=1 0 @fstissn.pft" fullinv=fstissn tell=50000

mx /bases/estat/tab30/issn/issn1 "fst=1 4 v222^a" fullinv=fstissn2 tell=50000

#CIPAR=/bases/estat/tab30/rogerio/fstissn.cip; export CIPAR
 
#mx /bases/jlistissn/issn1 "fst=1 4 v222^a' 'v222^b" fullinv=fstissn3

#/utl/cisis/mx /bases/jlistissn/issn1 "fst=@fstissn.fst" fullinv=fstissn4 tell=50000
#/utl/cisis/mx fstissn4 btell=0  "bool=RES$ (F) REVIEW$ (F) PARASITOL$" +hits "proc=@select.prc" append=tabout4 -all now
