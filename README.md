# mastodon-redirect
Since Twitter decided to block Mastodon URLs, I've created this redirect website to automatically redirect to your Mastodon profile URL.

## Website Usage
You can either go to the website, [Mastodon Redirect](https://thealiendrew.github.io/mastodon-redirect/), directly and enter the Mastodon profile in the `@[username]@[mastodon.server]` format. Or you can use the url in the following fashion to auto redirect:

- Profile URL (works on Twitter, but not all sites): `https://thealiendrew.github.io/mastodon-redirect/?p=@AlienDrew@mstdn.social`
- Profile URL (`@` replaced with `%40`; works on all sites): `https://thealiendrew.github.io/mastodon-redirect/?p=%40AlienDrew%40mstdn.social`

Alteratives (doesn't work on Twitter for some reason; strips the last parameter from link):

- Username and Server URL: `https://thealiendrew.github.io/mastodon-redirect/?u=AlienDrew&s=mstdn.social`
- Username and Server URL (Alt): `https://thealiendrew.github.io/mastodon-redirect/?s=mstdn.social&u=AlienDrew`

![Preview](https://github.com/TheAlienDrew/mastodon-redirect/blob/main/img/readme/preview.png)

## Updating Mastodon Servers List
When the list is out of date, you can run the following bash script, `update-mastodon-servers-list.sh`, from the root of the repo, and it should work just fine. No admin rights needed (unless you don't have `wget` and/or `curl` installed).

After running the script like so:

- `./update-mastodon-servers-list.sh`

It should have updated the [custom.js](https://github.com/TheAlienDrew/mastodon-redirect/blob/main/js/custom.js) file's `mastodonServers` variable. Note, it only grabs the servers that are UP (active servers only).
