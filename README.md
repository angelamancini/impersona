Impersona
=========

Copy Deployments, Arrays and Servers with settings from one RightScale account to another

##How to use
1. Rename rightscale_config.yml.tmpl to rightscale_config.yml
2. Fill in RightScale email and password
3. Fill out each account name and account number for any account you wish to use.
In the Rightscale url, the account number is the number after `acct/`. Example: `https://us-3.rightscale.com/acct/xxxx/deployments`. `xxxx` is your account number. Name is just a friendly name for you to remember which account is what.
3. Run `bundle install`
4. In terminal, run `rails s`
5. Go to http://localhost:3000
