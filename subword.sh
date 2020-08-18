#!/bin/bash

#amass
amass enum --passive -d $1 -o domains_$1

#assetfinder
assetfinder --subs-only $1 | tee -a domains_$1

#sublister
python3 /home/kiran/Documents/tools/Sublist3r/sublist3r.py -d $1 | tee -a domains_$1

#subfinder
subfinder -d $1 -o domains_subfinder_$1

cat domains_subfinder_$1 | tee -a domains_$1
sort -u domains_$1 -o domains_$1

cat domains_$1 | filter-resolved | httprobe | tee -a 200_domains_$1.txt

#cert.sh
curl -s  https://crt.sh/?q\=%.$1\&output\=json | jq -r '.[].name_value' | sed 's/\*\.//g' | sort -u | httprobe -c 50 | tee -a 200_domains_$1.txt

#rapid-dns

curl -s "https://rapiddns.io/subdomain/$1?full=1" | grep -oP '_blank">\K[^<]*'  | grep -v http |sort -u | tee -a 200_domains_$1.txt

sort -u 200_domains_$1.txt -o 200_domains_$1.txt


rm domains_subfinder_$1

#---------------------------------------------------------------------------------#
#--------------------------endpoints + urls -part---------------------------------#
#---------------------------------------------------------------------------------#

#gau
cat 200_domains_$1.txt | gau | tee -a all_urls.txt

#wayback urls
cat 200_domains_$1.txt | waybackurls | tee -a all_urls.txt

sort -u all_urls.txt -o all_urls.txt

#custom-wordlist
cat 200_domains_$1.txt| gau | unfurl -u paths | tee -a paths-and-keys.txt
cat  200_domains_$1.txt | gau | unfurl -u keys | tee -a paths-and-keys.txt

sed 's#/#\n#g' paths-and-keys.txt | sort -u | tee -a wordlist.txt

#curl
cat 200_domains_$1.txt | xargs curl | tee -a curled.txt
cat curled.txt | tok | tr '[:upper:]' '[:lower:]' | sort -u | tee -a wordlist.txt


sort -u wordlist.txt -o wordlist.txt

#js-files
cat all_urls.txt | fff -s 200 -s 404
grep -orh "\"\/[a-zA-Z0-9_/?=&]*\"" out/  | sed -e 's/^"//' -e 's/"$//' | sort -u  | tee -a wordlist.txt


rm curled.txt
rm paths-and-keys.txt
