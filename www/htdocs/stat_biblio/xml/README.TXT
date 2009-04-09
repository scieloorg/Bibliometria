
Esses XMLs são editados pelo shell genselbox.sh, presente neste mesmo diretório,
que é disparado pelo shell /www/scibiblio/bases/estat/artigo/genbiblio.sh, resposável por toda a atualização da
parte Servidor de XMLs que alimenta a parte cliente do Módulo de Bibliometria.


Amostras de XMLs que a aplicacao servidora deve retornar `a aplicacao cliente:

--------------------------------------------------------------------------------------------------------------
04.xml e 04_.xml


1) Estado 04 - uma pagina html que tem 2 select's e um form. Essa pagina foi
construida a partir de um XML estatico que o servidor retornou. URL:

http://tamar.bireme.br:1128/index.php?state=04&xml=http://serverofi.bireme.br:2424/xml/04.xml

Se quiser ver qual o XML que montou essa pagina, coloque &debug=xml no final do link, assim:
http://tamar.bireme.br:1128/index.php?state=04&xml=http://serverofi.bireme.br:2424/xml/04.xml&debug=xml

Note que o XML que vai aparecer tem uma estrutura do tipo:

<?xml version="1.0" encoding="iso-8859-1" ?> 
<statistics>
  <request-vars>
  <ini>
  <root>
</statistics>

A estrutura XML que o servidor retornou para a minha aplicacao cliente e´ a <root>, ou seja,
a aplicacao servidora sempre retorna um XML do tipo:

<?xml version="1.0" encoding="iso-8859-1" ?> 
<root>
	etc.
</root>


--------------------------------------------------------------------------------------------------------------

05.xml e 05_.xml

2) Estado 05 - uma pagina onde sao listadas uma ou mais tabelas. Dentro de cada
tabela temos links para as revistas dentro do site do Scielo.

O estado 05 e´ alcançado a partir do estado 04 - o usuario selecionou um ou mais
anos e uma ou mais revistas e a aplicacao servidora retornou o XML dinamico
correspondente.

Exemplo:
http://tamar.bireme.br:1128/index.php?state=05&server_form_name=%2Fcgi-bin%2Fxml%2Fscielo1_2.sh&lang=pt&YNG%5B%5D=2002&YNG%5B%5D=2001&CITED%5B%5D=ACTA+BOTANICA+BRASILICA&CITED%5B%5D=ACTA+CIRURGICA+BRASILEIRA&CITED%5B%5D=ACTA+ORTOPEDICA+BRASILEIRA

coloque &debug=xml no final do link para ver o XML:

http://tamar.bireme.br:1128/index.php?state=05&server_form_name=%2Fcgi-bin%2Fxml%2Fscielo1_2.sh&lang=pt&YNG%5B%5D=2002&YNG%5B%5D=2001&CITED%5B%5D=ACTA+BOTANICA+BRASILICA&CITED%5B%5D=ACTA+CIRURGICA+BRASILEIRA&CITED%5B%5D=ACTA+ORTOPEDICA+BRASILEIRA&debug=xml

igual ao caso anterior, teremos:

<?xml version="1.0" encoding="iso-8859-1" ?> 
<statistics>
  <request-vars>
  <ini>
  <root>
</statistics>

igual ao caso anterior, o XML que a aplicacao servidora criou esta´ dentro de
root.

Os links que levam `as revistas dentro do site do Scielo sao construidos a
partir do XML que o servidor retornou.

Note que dentro do elemento link temos necessariamente os elementos:
- label_list
- url
Opcional e´ o elemento state. Esse elemento so´ e´ necessario quando preciso
saber a qual estado estou me deslocando. Como atraves dos links dessa pagina eu
vou apenas para o site do Scielo, entao nao e´ necessario esse elemento state.




