


Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
NC='\033[0m' # No Color


    
Usage(){        
        while read -r line; do
                printf "%b\n" "$line"
        done  <<-EOF

\r -d --domain\t Domain to extract endpoints
\r  -l --list\t file name to extract endpoints
\r -dd --domains\t List of Domain to extract endpoints
\r -wb --wayback\t Wayback to extract
EOF
 exit 1
}





Endpoints() {
        echo "${Yellow}Endpoints${NC}"
        echo "\n"
        gau $domain| unfurl -u keys | tee -a wordlist.txt ; gau $domain | unfurl -u paths|tee -a ends.txt; sed 's#/#\n#g' ends.txt  | sort -u | tee -a wordlist.txt | sort -u ;rm ends.txt  | sed -i -e 's/\.css\|\.png\|\.jpeg\|\.jpg\|\.svg\|\.gif\|\.wolf\|\.bmp//g' wordlist.txt
}


loopEndpoints() {
        echo "${Yellow}loopEndpoints${NC}"
        echo '\n'
        for i in $(cat $domains);
        do
        gau $i| unfurl -u keys | tee -a wordlist.txt ; gau $i | unfurl -u paths|tee -a end.txt; sed 's#/#\n#g' end.txt  | sort -u | tee -a test.txt | sort -u ;rm end.txt  | sed -i -e 's/\.css\|\.png\|\.jpeg\|\.jpg\|\.svg\|\.gif\|\.wolf\|\.bmp//g' test.txt
        done
}




wayback(){

        echo "${Yellow}Waybackurls"${NC}
        echo "\n"
        cat $domains | waybackurls | tee way.txt

        cat way.txt | unfurl -u keys| tee -a wayback.txt
        cat way.txt |unfurl -u paths|tee -a wayback.txt
        sed 's#/#\n#g' wayback.txt  |sort -u |tee -a waybacks.txt
        rm wayback.txt  | sed -i -e 's/\.css\|\.png\|\.jpeg\|\.jpg\|\.svg\|\.gif\|\.wolf\|\.bmp//g' waybacks.txt


    }



curling() {
        echo "${Yellow}Curling${NC}"
        echo '\n'
        cat $list | httpx -threads 4 -o httpx.txt 
        cat httpx.txt |xargs curl | tok | tr '[:upper:]' '[:lower:]' | sort -u | tee -a words.txt
        rm httpx.txt
}




jsfiles(){
        echo "${Yellow}From JS Files${NC}"
        echo '\n'
        
        gau $domain | head -n 1000 | fff -s 200 -s 404 -o out
        grep -roh "\"\/[a-zA-Z0-9_/?=&]*\"" out/ | sed -e 's/^"//' -e 's/"$//' | sort -u | tee -a words.txt



}



sorting() {
        echo "${Yellow}Sorintg${NC} "
        echo "\n"
        mkdir endpoint
        sort -u words.txt wordlist.txt test.txt waybacks.txt > endpoint/wordlist.txt
        rm words.txt  wordlist.txt test.txt waybacks.txt
}







bold=$(tput bold)



Main() {

        {
        jsfiles    
        curling
        loopEndpoints
        Endpoints
        wayback
        jsfiles
        sorting
}
}
domains=False
domain=False
list=False
while [ -n "$1" ]; do
case "$1" in
        -d|--domain)
                domain=$2
                shift ;;
        -l|--list)
                list=$2
                shift ;;
        -dd|--domains)
                domains=$2
                shift ;;
        -wb|--waybacks)
               domains=$2
               shift;;
        *)
                echo  "${Cyan}[-] Unknown Option:${NC}${Purple} $1";
                Usage;;
        esac
        shift
done
Main
