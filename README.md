# m-r (mastodon-redirect)
Since Twitter decided to block Mastodon URLs, I've created this redirect website to automatically redirect to your Mastodon profile URL.

## Website Usage
You'll need to first go to the website to generate the link, [Mastodon Redirect](https://thealiendrew.github.io/m-r/), by entering the Mastodon profile in the `@[username]@[mastodon.server]` format, and then you'll be able to generate a working URL that should avoid Twitter blocking.

- Profile URL (works on Twitter, but not all sites): `https://thealiendrew.github.io/m-r/?p=@[username]@[encoded mastodon.server instance]`
- Profile URL (`@` replaced with `%40`; works on all sites): `https://thealiendrew.github.io/m-r/?p=%40[mastodon.server]%40[encoded mastodon.server instance]`

Alteratives (doesn't work on Twitter for some reason; strips the last parameter from link):

- Username and Server URL: `https://thealiendrew.github.io/m-r/?u=[mastodon.server]&s=[encoded mastodon.server instance]`
- Username and Server URL (Alt): `https://thealiendrew.github.io/m-r/?s=[mastodon.server]&u=[encoded mastodon.server instance]`

![Preview](https://github.com/TheAlienDrew/m-r/blob/main/img/readme/preview.png)

## Updating Mastodon Servers List
When the list is out of date, you can run the following bash script, `update-mastodon-servers-list.sh`, from the root of the repo, and it should work just fine. No admin rights needed (unless you don't have `wget` and/or `curl` installed).

After running the script like so:

- `./update-mastodon-servers-list.sh`

It should have updated the [custom.js](https://github.com/TheAlienDrew/m-r/blob/main/js/custom.js) file's `mastodonServers` variable. Note, it only grabs the servers that are UP (active servers only).
