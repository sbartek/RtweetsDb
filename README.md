# TweetsDb

This project will contain set of function to interact with a database
that save tweets.

It does the following:

* creates db;
* creates table following schema (tweets, hashes, tweetsHashes);
* updates tweets with new tweets only 

## Plan

* updates tweetsHashes with new tweets/hashes only
* return data.frame of tweets for specific hash
* and more ...

## Testing

    require('testthat')
    test_dir('tests/testthat')

