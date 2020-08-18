#gau
cat 200_domains_frame.io.txt |gau| tee -a all_urls.txt

#custom-wordlist
cat 200_domains_frame.io.txt|gau | unfurl -u paths | tee -a paths-and-keys.txt

cat  200_domains_frame.io.txt |gau| unfurl -u keys | tee -a paths-and-keys.txt

sed 's#/#\n#g' paths-and-keys.txt | sort -u | tee -a wordlist.txt

#curl
cat 200_domains_frame.io.txt | curl | tee -a curled.txt

cat curled.txt | tok | tr '[:upper:]' '[:lower:]' | sort -u | tee -a wordlist.txt


#extract js files and endpoints from it

gau 200_domains_frame.io.txt | head -n 1000 | fff -s 200 -s 404


