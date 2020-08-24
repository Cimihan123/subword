



Usage(){        
        while read -r line; do
                printf "%b\n" "$line"
        done  <<-EOF

\r -d --domain\t Domain to extract endpoints
\r  -l --list\t file name to extract endpoints
\r -dd --domains\t List of Domain to extract endpoints

EOF
 exit 1
}



Endpoints() {


        echo 'Endpoints'



~/go/bin/gau $domain| unfurl -u keys | tee -a wordlist.txt ; gau $domain | unfurl -u paths|tee -a ends.txt; sed 's#/#\n#g' ends.txt  | sort -u | tee -a wordlist.txt | sort -u ;rm ends.txt  | sed -i -e 's/\.css\|\.png\|\.jpeg\|\.jpg\|\.svg\|\.gif\|\.wolf\|\.bmp//g' wordlist.txt

}

loopEndpoints() {
            echo 'loopEndpoints'


for i in $(cat $domains);

do

gau $i| unfurl -u keys | tee -a wordlist.txt ; gau $i | unfurl -u paths|tee -a end.txt; sed 's#/#\n#g' end.txt  | sort -u | tee -a test.txt | sort -u ;rm end.txt  | sed -i -e 's/\.css\|\.png\|\.jpeg\|\.jpg\|\.svg\|\.gif\|\.wolf\|\.bmp//g' test.txt

done

}




curling() {
         echo 'Curling'


cat $list | httprobe | xargs curl | tok | tr '[:upper:]' '[:lower:]' | sort -u | tee -a words.txt
}



sorting() {

        sort -u words.txt wordlist.txt test.txt > wordlist
        rm words.txt  wordlist.txt test.txt

}

Main() {
    

        count=$(cat $domains | wc | awk '{print $1}')
        echo $count
 
        [ $domains != False ] && [ $list == False] && [ $domain != False ]
        {
      
                loopEndpoints
       
       

        curling 
               
     
       
        Endpoints 

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

        *)
                echo "[-] Unknown Option: $1";
                Usage;;


        



        esac
        shift 
done


Main
