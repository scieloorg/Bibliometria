if p(v30) and a(v18) then 
	'd*
	<400 0>'
		v880*1.9
	'</400>
	<650 0>'
		v880*10.4
	'</650>
	<330 99>'
		e1:=l(['../tab30/tc30issn']mpu,v30,mpl),
		if e1>0 then 
			ref(['../tab30/tc30issn']
			  e1,
				if p(v222^a) then 
					mpu,v222^a,mpl
					'^i',
					if v400>'' then 
						v400 
					else, 
						if v22^a>'' then 
							v22^a 
						else 
							v22 
						fi, 
					fi, 
				else 
					if p(v2) and v2<>'' then 
						'~~2_'mpu,v2,mpl
					else
						'~~1_'mpu,v30,mpl
					fi,
				fi,
			   ) 
		else 
			'~~*_'mpu,v30,mpl
		fi,'
	</330>
	<365 0>'
		v65.4
	'</365>'
	'a35~'v35.9'~'
else
	'd*'
fi
