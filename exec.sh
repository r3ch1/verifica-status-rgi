#!/bin/bash
if [ "$1" == '' ]
then
  echo "SEM NUMERO DE PROCESSO"
  exit 1
fi
rm -rf tmp/*
curl 'http://10ri-rj.com.br/Consultas.asp' \
  -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7' \
  -H 'Accept-Language: pt-BR,pt;q=0.9,en-US;q=0.8,en;q=0.7' \
  -H 'Cache-Control: max-age=0' \
  -H 'Connection: keep-alive' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Cookie: ASPSESSIONIDCATQTART=FPCNAEDDPAOHNJOEHPGKBFDG; ASPSESSIONIDQASSTCQR=DMAJBONDLJDHPGLIEGCOBJPI; ASPSESSIONIDSAQTRAQQ=OGACIINBIMCNACHOEPABMFLP; ASPSESSIONIDCCQQRDTQ=KDELGJHCGGIAJIPJJGKHOBON; ASPSESSIONIDCCQSQBQS=CILPOKMDMGNEPONDIKNDPOOP; ASPSESSIONIDCCRSTASR=JPJLLGHAPPNNCCLNCEGKJFLN; ASPSESSIONIDCAQTRCRT=NNGJAAHCNMLFLLHBONMKDEGP; ASPSESSIONIDCCRQQAQT=JPMPJLBDDJLICMFFCBMOBDAA' \
  -H 'Origin: http://10ri-rj.com.br' \
  -H 'Referer: http://10ri-rj.com.br/talao.asp' \
  -H 'Upgrade-Insecure-Requests: 1' \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36' \
  --data-raw "tipo=registro&txtregistro=${1}" \
  --insecure > tmp/passo1.html

sed -n "/DADOS/,/DADOS/p" tmp/passo1.html > tmp/rgi.html

rm -rf tmp/passo1.html

lynx tmp/rgi.html --dump > tmp/clear.txt

notify-send -u critical -i /usr/share/icons/gnome/24x24/actions/go-home.png "Atualização de RGI" "$(cat tmp/clear.txt)"
