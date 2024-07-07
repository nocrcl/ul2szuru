#!/bin/bash

dryrun=false #true:just print the tags as json and do nothing 
safety="sketchy" #safe, sketchy, unsafe
api_token="y0urT0k3nHeR3=" # base64 encoded username and token. you can generate it using duckduckgo.com. Enter "base64 username:token" in the search bar
api_url="https://yourszurubooruinstan.ce:8080"
image=$(($#-1))

while [ $image -ge 0 ]; do
    echo "Uploading " ${BASH_ARGV[$image]}

# Images downloaded at dezgo.com
# Use exiv2 and jq to extract the tags and format the tags in json format
    json_tags=$(exiv2 "${BASH_ARGV[$image]}" |  grep -wi "prompt" | sed 's/.*://' | jq -R -s '{tags: (. | split(" *(\\.|,) *"; null) | map(gsub("^\\s";"")|gsub("\\s$";"")|gsub("(\\s)+";"_")|gsub("(\\+)+";"")) | map(select(. != "")) ), safety: "'$safety'"}')

    if [[ -z "$json_tags" ]]; then #something went wrong and the json string is empty.
        json_tags='{"tags":["_tagme_"],"safety": "sketchy"}'
    fi

    if $dryrun; then
        echo $json_tags
    else
        curl -X POST -H "Authorization: Token $api_token" -H "Content-Type: multipart/form-data" -H "Accept: application/json" -F "content=@${BASH_ARGV[$image]}" -F "metadata=$json_tags" $api_url/api/posts/
    fi
    image=$((image-1))
    printf "\n"
done
