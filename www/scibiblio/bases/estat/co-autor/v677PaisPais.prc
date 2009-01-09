'd*','a880~'v880'~',
(
	'a677~',
		'^p',
			if v677^*='-' or v677^*='' then 
				'- NAO IDENTIFICADO' 
			else, 
				if v677^*='1' then 
					'- AUTOR INDIVIDUAL' 
				else 
					ref(['3166']l(['3166']v677^*),mpu,v1,mpl) 
				fi, 
			fi,
			',',
			x1,
			if v677^x='-' or v677^x='' then 
				'- NAO IDENTIFICADO' 
			else, 
				if v677^x='1' then 
					'- AUTOR INDIVIDUAL' 
				else 
					ref(['3166']l(['3166']v677^x),mpu,v1,mpl) 
				fi, 
			fi,
		'^i',
			if v677^*='-' or v677^*='' then 
				'- NOT IDENTIFIED' 
			else, 
				if v677^*='1' then 
					'- INDIVIDUAL AUTHOR' 
				else 
					ref(['3166']l(['3166']v677^*),mpu,v2,mpl) 
				fi, 
			fi,
			',',
			x1,
			if v677^x='-' or v677^x='' then 
				'- NOT IDENTIFIED' 
			else, 
				if v677^x='1' then 
					'- INDIVIDUAL AUTHOR' 
				else 
					ref(['3166']l(['3166']v677^x),mpu,v2,mpl) 
				fi, 
			fi,
		'^e',
			if v677^*='-' or v677^*='' then 
				'- NO IDENTIFICADO' 
			else, 
				if v677^*='1' then 
					'- AUTOR INDIVIDUAL' 
				else 
					ref(['3166']l(['3166']v677^*),mpu,v3,mpl) 
				fi, 
			fi,
			',',
			x1,
			if v677^x='-' or v677^x='' then 
				'- NO IDENTIFICADO' 
			else, 
				if v677^x='1' then 
					'- AUTOR INDIVIDUAL' 
				else 
					ref(['3166']l(['3166']v677^x),mpu,v3,mpl) 
				fi, 
			fi,
	'~'
)
