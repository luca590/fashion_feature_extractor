#!/bin/sh

if [ -e ../temp.json ]; then
    rm ../temp.json
fi

if [ -e ../proccessed_tweets.csv ]; then
    rm ../processed_tweets.csv
fi

touch ../processed_tweets.csv

echo "Looping through all CSV files"
for csv in ../data/*.csv; do
    echo "Now looping through $csv"
    while read line; do
        echo "Scraping $line"
        twitterscraper "$line" --limit 5 --output ../temp.json
	python ../process_twitter_json.py "$line" ../temp.json --output >> ../processed_tweets.csv
        rm ../temp.json
    done < $csv
done
