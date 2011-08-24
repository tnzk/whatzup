# Whatzup

**Whatzup** is simple file uploader via Windows Azure Blob storage on Rails.

Working demo is available [here](http://whatzup.heroku.com/). You can also set up on your server easily.

## Set up

1. Setting your account name and secret
2. Deploying
3. That's all!

### 1. Setting your account name and secret

Get your a pair of account name and secret access key. It can be obtained from [Windows Azure control panel](http://windows.azure.com).

Paste them onto 5th and 6th line.

    cred = {                        
      'production' =>               
        { name: 'your account name',
           key: 'your secret' },    
      'development' =>              
        { name: 'your account name',
           key: 'your secret'}      
    }[RAILS_ENV]                    

You can use same pair of credentials for both environment.

### 2. Deploying

Since this is simple Rails application, you can deploy this in the your way. I recommend to deploy on Heroku because I tried only there :(
