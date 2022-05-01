#!/bin/bash


#httpx
go get -u -v github.com/projectdiscovery/httpx/cmd/httpx

#unfurl
go get -u github.com/tomnomnom/unfurl


#fff
go get -u github.com/tomnomnom/fff


#gau
go get -u -v github.com/lc/gau

#waybackurls
go get github.com/tomnomnom/waybackurls

#tok
wget https://raw.githubusercontent.com/tomnomnom/hacks/master/tok/main.go
go build main.go
mv main tok
sudo cp tok ~/go/bin

#wayback
go install github.com/tomnomnom/waybackurls@latest

#assetfinder
go get -u github.com/tomnomnom/assetfinder



#httpx
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

#nuclei
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest


