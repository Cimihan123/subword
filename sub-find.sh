#!/bin/bash

#amass
amass enum --passive -d $1 -o domains_$1

#assetfinder
assetfinder --subs-only $1 | tee -a domains_$1

#sublister
sublister -d $1 | tee -a domains_$1

#subfinder
subfinder -d $1 -o domains_subfinder_$1

cat domains_subfinder_$1 | tee -a domains_$1

rm domains_subfinder_$1


sort -u domains_$1 -o domains_$1

cat domains_$1 | filter-resolved | httprobe | tee -a 200_domains_$1.txt


#cert.sh
curl -s  https://crt.sh/?q\=%.$1\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | httprobe -c 50 | tee -a 200_domains_$1.txt


#riddler.io
curl -s "https://riddler.io/search/exportcsv?q=pld:$1" | grep -Po "(([\w.-]*)\.([\w]*)\.([A-z]))\w+" | sort -u | tee -a 200_domains_$1.txt


#virus_total
curl -s "https://www.virustotal.com/ui/domains/$1/subdomains?limit=40" | grep -Po "((http|https):\/\/)?(([\w.-]*)\.([\w]*)\.([A-z]))\w+" | sort -u | tee -a 200_domains_$1.txt



#CertSpotter
curl -s "https://certspotter.com/api/v0/certs?domain=$1" | grep -Po "((http|https):\/\/)?(([\w.-]*)\.([\w]*)\.([A-z]))\w+" | sort -u | tee -a 200_domains_$1.txt


#BufferOver.run
curl -s https://dns.bufferover.run/dns?q=.$1 |jq -r .FDNS_A[]|cut -d',' -f2|sort -u | tee -a 200_domains_$1.txt


#Archieve
curl -s "http://web.archive.org/cdx/search/cdx?url=*.$1/*&output=text&fl=original&collapse=urlkey" | sed -e 's_https*://__' -e "s/\/.*//" | sort -u | tee -a 200_domains_$1.txt



#JLDC
curl -s "https://jldc.me/anubis/subdomains/$1" | grep -Po "((http|https):\/\/)?(([\w.-]*)\.([\w]*)\.([A-z]))\w+" | sort -u | tee -a 200_domains_$1.txt


sort -u 200_domains_$1.txt -o $1.txt

grep $(echo $1 | awk -F"." '{print ($1)}') $1.txt| tee -a all_$1.txt

rm 200_domains_$1.txt
