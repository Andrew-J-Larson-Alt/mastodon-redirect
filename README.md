# m-r (mastodon-redirect)
Since Twitter decided to block Mastodon URLs, I've created this redirect website to automatically redirect to your Mastodon profile URL.

## Website Usage
You'll need to first go to the website to generate the link, [Mastodon Redirect](https://thealiendrew.github.io/m-r/), by entering the Mastodon profile in the `@[username]@[mastodon.server]` format, and then you'll be able to generate a working URL that should avoid Twitter blocking.

Examples of generation URLs:

- Profile URL: `https://thealiendrew.github.io/m-r/?p=AlienDrew@mstdn.social`
- Username and Server URL: `https://thealiendrew.github.io/m-r/?u=AlienDrew&s=mstdn.social`
- Username and Server URL (Alt): `https://thealiendrew.github.io/m-r/?s=mstdn.social&u=AlienDrew`

Examples of redirecting URLs:

- Profile URL (works on Twitter, but not all sites): `https://thealiendrew.github.io/m-r/?p=AlienDrew@mstdn%2Esocial`
- Profile URL (`@` replaced with `%40`; works on all sites): `https://thealiendrew.github.io/m-r/?p=AlienDrew%40mstdn%2Esocial`

### Notes on crafting redirect URLs:
If you are crafing these links manually, you must:
1. replace all `.` with `%2E` in the server part of the link
2. replace all `mastodon` with `%6D%61%73%74%6F%64%6F%6E` in all parts of the link

### Notes on Twitter detection and blocks:
Twitter will block links if it senses either of the following:
- If the URL is a Mastodon server, e.g. `https://mstdn.social/`
- If `mastodon` is somewhere in the URL, e.g. `https://i.redirect.to.mastodon/...` or `https://example.com/mastodon/...`
- If a website parameter uses a Mastodon server (with or without percent encoding, is still detected), e.g. `?server=mstdn.social`

![Preview](https://github.com/TheAlienDrew/m-r/blob/main/img/readme/preview.png)

## Updating Mastodon Servers List
When the list is out of date, you can run the following bash script, `update-mastodon-servers-list.sh`, from the root of the repo, and it should work just fine. No admin rights needed (unless you don't have `wget` and/or `curl` installed).

After running the script like so:

- `./update-mastodon-servers-list.sh`

It should have updated the [custom.js](https://github.com/TheAlienDrew/m-r/blob/main/js/custom.js) file's `mastodonServers` variable. Note, it only grabs the servers that are UP (active servers only).
