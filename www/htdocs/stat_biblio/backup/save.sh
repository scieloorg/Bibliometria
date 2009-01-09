TODAY=`date +"%Y%m%d"`
tar cvfzp stat.$TODAY.tgz *.sh *.php css html images ini javascript xml xsl
mv stat.$TODAY.tgz backup
echo Backup de $TODAY esta feito!
