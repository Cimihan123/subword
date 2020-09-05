


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
\r -dd --domains\t List of Domain to extract endpoints

EOF
 exit 1
}



#Single domains



Endpoints() {

    if [ $domain ];then

        echo "${Yellow}Endpoints${NC}"
        echo "\n"
        gau $domain | tee gau.txt | unfurl -u keys | tee -a wordlist.txt ; gau $domain | unfurl -u paths|tee -a ends.txt; sed 's#/#\n#g' ends.txt  | sort -u | tee -a wordlist.txt | sort -u ;rm ends.txt  | sed -i -e 's/\.css\|\.png\|\.jpeg\|\.jpg\|\.svg\|\.gif\|\.wolf\|\.bmp//g' wordlist.txt

        cat gau.txt | unfurl -u paths | awk -F'/' '{print $2}' | sort -u | sed  -e 's/\.css\|\.png\|\.jpeg\|\.jpg\|\.svg\|\.gif\|\.woff\|\.woff2\|\.bmp//g'|tee -a wordlist.txt
        cat gau.txt | unfurl -u paths | awk -F'/' '{print $3}' | sort -u | sed  -e 's/\.css\|\.png\|\.jpeg\|\.jpg\|\.svg\|\.gif\|\.woff\|\.woff2\|\.bmp//g'|tee -a wordlist.txt
        cat gau.txt | unfurl -u paths | awk -F'/' '{print $4}' | sort -u | sed  -e 's/\.css\|\.png\|\.jpeg\|\.jpg\|\.svg\|\.gif\|\.woff\|\.woff2\|\.bmp//g'|tee -a wordlist.txt
        cat gau.txt | unfurl -u paths | awk -F'/' '{print $5}' | sort -u | sed  -e 's/\.css\|\.png\|\.jpeg\|\.jpg\|\.svg\|\.gif\|\.woff\|\.woff2\|\.bmp//g'|tee -a wordlist.txt
        cat gau.txt | unfurl -u paths | awk -F'/' '{print $6}' | sort -u | sed  -e 's/\.css\|\.png\|\.jpeg\|\.jpg\|\.svg\|\.gif\|\.woff\|\.woff2\|\.bmp//g'|tee -a wordlist.txt
        cat gau.txt | unfurl -u paths | awk -F'/' '{print $7}' | sort -u | sed  -e 's/\.css\|\.png\|\.jpeg\|\.jpg\|\.svg\|\.gif\|\.woff\|\.woff2\|\.bmp//g'|tee -a wordlist.txt
        cat gau.txt | unfurl -u paths | awk -F'/' '{print $8}' | sort -u | sed  -e 's/\.css\|\.png\|\.jpeg\|\.jpg\|\.svg\|\.gif\|\.woff\|\.woff2\|\.bmp//g'|tee -a wordlist.txt
        cat gau.txt | unfurl -u paths | awk -F'/' '{print $9}' | sort -u | sed  -e 's/\.css\|\.png\|\.jpeg\|\.jpg\|\.svg\|\.gif\|\.woff\|\.woff2\|\.bmp//g'|tee -a wordlist.txt
        cat gau.txt | unfurl -u paths | awk -F'/' '{print $10}' | sort -u | sed  -e 's/\.css\|\.png\|\.jpeg\|\.jpg\|\.svg\|\.gif\|\.woff\|\.woff2\|\.bmp//g'|tee -a wordlist.txt
        cat gau.txt | unfurl -u paths | awk -F'/' '{print $11}' | sort -u | sed  -e 's/\.css\|\.png\|\.jpeg\|\.jpg\|\.svg\|\.gif\|\.woff\|\.woff2\|\.bmp//g'|tee -a wordlist.txt
        cat gau.txt | unfurl -u paths | awk -F'/' '{print $12}' | sort -u | sed  -e 's/\.css\|\.png\|\.jpeg\|\.jpg\|\.svg\|\.gif\|\.woff\|\.woff2\|\.bmp//g'|tee -a wordlist.txt
        cat gau.txt | unfurl -u paths | awk -F'/' '{print $13}' | sort -u | sed  -e 's/\.css\|\.png\|\.jpeg\|\.jpg\|\.svg\|\.gif\|\.woff\|\.woff2\|\.bmp//g'|tee -a wordlist.txt


         rm gau.txt
    fi
}



curling() {

    if [ $domain ];then
        echo "${Yellow}Curling${NC}"
        echo '\n'
        echo $domain | httpx -threads 4 -o http.txt
        cat http.txt |xargs curl | tok | tr '[:upper:]' '[:lower:]' | sort -u | tee -a words.txt
        rm http.txt
    fi
}



jsfiles(){


     if [  $domain ];then
        echo "${Yellow}From JS Files${NC}"
        echo '\n'
        gau $domain | head -n 1000 | fff -s 200 -s 404 -o out
        grep -roh "\"\/[a-zA-Z0-9_/?=&]*\"" out/ | sed -e 's/^"//' -e 's/"$//' | sort -u | tee -a words.txt
    fi


}


wayback(){

     if [  $domain ];then
        echo "${Yellow}Waybackurls"${NC}
        echo "\n"
        echo $domain | waybackurls | tee -a way.txt
        cat way.txt | unfurl -u keys| tee -a wayback.txt
        cat way.txt |unfurl -u paths|tee -a wayback.txt
        sed 's#/#\n#g' wayback.txt  |sort -u |tee -a waybacks.txt
        rm wayback.txt | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' | tee -a  waybacks.txt



        cat way.txt | unfurl -u paths | awk -F'/' '{print $2}' | sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' | tee -a |tee -a waybacks.txt
        cat way.txt | unfurl -u paths | awk -F'/' '{print $3}' | sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' | tee -a |tee -a waybacks.txt
        cat way.txt | unfurl -u paths | awk -F'/' '{print $4}' | sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' | tee -a |tee -a waybacks.txt
        cat way.txt | unfurl -u paths | awk -F'/' '{print $5}' | sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' | tee -a |tee -a waybacks.txt
        cat way.txt | unfurl -u paths | awk -F'/' '{print $6}' | sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' | tee -a |tee -a waybacks.txt
        cat way.txt | unfurl -u paths | awk -F'/' '{print $7}' | sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' | tee -a |tee -a waybacks.txt
        cat way.txt | unfurl -u paths | awk -F'/' '{print $8}' | sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' | tee -a |tee -a waybacks.txt
        cat way.txt | unfurl -u paths | awk -F'/' '{print $9}' | sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' | tee -a |tee -a waybacks.txt
        cat way.txt | unfurl -u paths | awk -F'/' '{print $10}'| sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' | tee -a |tee -a waybacks.txt
        cat way.txt | unfurl -u paths | awk -F'/' '{print $11}'| sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' | tee -a |tee -a waybacks.txt
        cat way.txt | unfurl -u paths | awk -F'/' '{print $12}'| sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' | tee -a |tee -a waybacks.txt
        cat way.txt | unfurl -u paths | awk -F'/' '{print $13}'| sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' | tee -a |tee -a waybacks.txt





    fi

    }




harkcrawl(){


     if [ $domain ];then
        echo "${Yellow} Hakcrawler${NC}"
        echo "\n"
        echo $domain | hakrawler -plain -usewayback -scope yolo | unfurl -u keys | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' | sort -u | tee -a words.txt
        echo $domain | hakrawler -plain -usewayback -scope yolo | unfurl -u paths| grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' | sort -u | tee -a words.txt
        rm httpx.txt
    fi
 }





#Looping


loopEndpoints() {

    if [ -f $domains ]; then
        echo "${Yellow}loopEndpoints${NC}"
        echo '\n'
        for i in $(cat $domains);
        do
        gau $i| tee -a gau.txt |  unfurl -u keys | tee -a wordlist.txt ; gau $i | unfurl -u paths|tee -a end.txt; sed 's#/#\n#g' end.txt  | sort -u | tee -a test.txt | sort -u ;rm end.txt  | sed -i -e 's/\.css\|\.png\|\.jpeg\|\.jpg\|\.svg\|\.gif\|\.wolf\|\.bmp//g' test.txt              
        done


        cat gau.txt | unfurl -u paths | awk -F'/' '{print $2}' | sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp'|tee -a wordlist.txt
        cat gau.txt | unfurl -u paths | awk -F'/' '{print $3}' | sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp'|tee -a wordlist.txt
        cat gau.txt | unfurl -u paths | awk -F'/' '{print $4}' | sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp'|tee -a wordlist.txt
        cat gau.txt | unfurl -u paths | awk -F'/' '{print $5}' | sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp'|tee -a wordlist.txt
        cat gau.txt | unfurl -u paths | awk -F'/' '{print $6}' | sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp'|tee -a wordlist.txt
        cat gau.txt | unfurl -u paths | awk -F'/' '{print $7}' | sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp'|tee -a wordlist.txt
        cat gau.txt | unfurl -u paths | awk -F'/' '{print $8}' | sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp'|tee -a wordlist.txt
        cat gau.txt | unfurl -u paths | awk -F'/' '{print $9}' | sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp'|tee -a wordlist.txt
        cat gau.txt | unfurl -u paths | awk -F'/' '{print $10}'| sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp'|tee -a wordlist.txt
        cat gau.txt | unfurl -u paths | awk -F'/' '{print $11}'| sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp'|tee -a wordlist.txt
        cat gau.txt | unfurl -u paths | awk -F'/' '{print $12}'| sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp'|tee -a wordlist.txt
        cat gau.txt | unfurl -u paths | awk -F'/' '{print $13}'| sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp'|tee -a wordlist.txt

        rm gau.txt

    fi
 }




loopWayback(){

     if [ -f $domains ];then
        echo "${Yellow}loopWaybackurls"${NC}
        echo "\n"
        cat $domains | waybackurls | tee way.txt

        cat way.txt | unfurl -u keys| tee -a wayback.txt
        cat way.txt |unfurl -u paths|tee -a wayback.txt
        sed 's#/#\n#g' wayback.txt  |sort -u |tee -a waybacks.txt
        rm wayback.txt  | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' | tee -a waybacks.txt



        cat way.txt | unfurl -u paths | awk -F'/' '{print $2}' | sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' |tee -a waybacks.txt
        cat way.txt | unfurl -u paths | awk -F'/' '{print $3}' | sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' |tee -a waybacks.txt
        cat way.txt | unfurl -u paths | awk -F'/' '{print $4}' | sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' |tee -a waybacks.txt
        cat way.txt | unfurl -u paths | awk -F'/' '{print $5}' | sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' |tee -a waybacks.txt
        cat way.txt | unfurl -u paths | awk -F'/' '{print $6}' | sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' |tee -a waybacks.txt
        cat way.txt | unfurl -u paths | awk -F'/' '{print $7}' | sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' |tee -a waybacks.txt
        cat way.txt | unfurl -u paths | awk -F'/' '{print $8}' | sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' |tee -a waybacks.txt
        cat way.txt | unfurl -u paths | awk -F'/' '{print $9}' | sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' |tee -a waybacks.txt
        cat way.txt | unfurl -u paths | awk -F'/' '{print $10}'| sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' |tee -a waybacks.txt
        cat way.txt | unfurl -u paths | awk -F'/' '{print $11}'| sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' |tee -a waybacks.txt
        cat way.txt | unfurl -u paths | awk -F'/' '{print $12}'| sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' |tee -a waybacks.txt
        cat way.txt | unfurl -u paths | awk -F'/' '{print $13}'| sort -u | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' |tee -a waybacks.txt

        rm way.txtss
    fi

    }






loopcurling() {

     if [ -f $domains ];then

        echo "${Yellow}loopCurling${NC}"
        echo '\n'
        cat $domains | httpx -threads 4 -o httpx.txt
        cat httpx.txt |xargs curl | tok | tr '[:upper:]' '[:lower:]' | sort -u | tee -a words.txt
    fi
}

loopHarkcrawl(){


    if [ -f $domains ];then
        echo "${Yellow}loopHakcrawler${NC}"
        echo "\n"
        cat httpx.txt | hakrawler -plain -usewayback -scope yolo | unfurl -u keys | grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp' | sort -u  | tee -a words.txt
        cat httpx.txt | hakrawler -plain -usewayback -scope yolo | unfurl -u paths| grep -v '.css\|.png\|.jpeg\|.jpg\|.svg\|.gif\|.woff\|.woff2\|.bmp'| sort -u  |tee -a words.txt
        rm httpx.txt
    fi
 }




loopSorting() {

     if [ -f $domains ];then
        echo "${Yellow}Single Sorintg${NC} "
        echo "\n"
        mkdir endpoint
        sort -u words.txt wordlist.txt test.txt waybacks.txt > endpoint/wordlist.txt
        rm words.txt  wordlist.txt test.txt waybacks.txt

    fi
}


singleSorting() {

    if [  $domain ];then
        echo "${Yellow}Loop Sorintg${NC} "
        echo "\n"
        mkdir endpoint
        sort -u words.txt wordlist.txt waybacks.txt > endpoint/wordlist.txt
        rm words.txt  wordlist.txt waybacks.txt
    fi
}








bold=$(tput bold)



sigleMain() {


        echo 'Single starts'

        #single
            harkcrawl
            Endpoints
            jsfiles
            curling
            wayback








        #sorting
        singleSorting


}

loopMain(){

        echo 'Looping starts'
        #loop
        loopcurling
        loopHarkcrawl
        loopEndpoints
        loopWayback


        #sorting
        loopSorting



}



while [ -n "$1" ]; do
case "$1" in
        -d|--domain)
                domain=$2
                shift ;;
        -dd|--domains)
                domains=$2
                shift ;;
        *)
                echo  "${Cyan}[-] Unknown Option:${NC}${Purple} $1";
                Usage;;
        \?)
                echo  "${Cyan}[-] Unknown Option:${NC}${Purple} $1";
                Usage;;
        esac
        shift
done





if [ "$2"=$domains ];then

    loopMain

elif [ "$2"=$domain ];then

    sigleMain
fi
