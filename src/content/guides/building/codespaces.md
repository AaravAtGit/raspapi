---
title: Codespaces
description: Set up your dev environment in the web!
order: 0
---

When developing, we've got a couple options. Codespaces is great, because it offloads all the actual computation off to a server, and you've only got to edit the code. To start, go to https://github.com, click the hamburger in the top left, and click "Codespaces".

![codespaces](https://cdn.hackclub.com/019d469b-ecc5-723b-b2b8-a1406d9a3acb/Screenshot%202026-03-31%20181356.png)

Now, select "Blank" to create a new empty codespace.

![blank](https://cdn.hackclub.com/019d469e-378a-7cc4-867c-0b405019e94f/image.png)

Feel free to customize as you see fit, but before continuing, you _must_ install Hackatime to have your time tracked! Head over to https://hackatime.hackclub.com/my/wakatime_setup, and select MacOS/Linux/Codespaces. Copy this setup script (`curl -fsSL ...`).

![hackatime](https://cdn.hackclub.com/019d46a3-b594-724c-897e-85ae60a991c2/image.png)

Paste that script into your terminal,and you'll get an interactive setup. It should look something like the below:
![termy](https://cdn.hackclub.com/019d46a7-e0c8-7fe0-8dff-ee737ed99a9d/image.png)

> **Note:** At this point, you'll be ready to take on any guide! The next few steps are only if you're coming from workshop slides.

Now, run the following command to install bun: `curl -fsSL https://bun.com/install | bash`. You'll now have to reload your window for `bun` to become available as a command.

![thing](https://cdn.hackclub.com/019d46ae-b82a-785b-b602-3c90388275fe/image.png)

You'll also need to log in to Wrangler. Run this command in your terminal: `curl -fsSL https://raspapi.hackclub.com/wrangler.sh | bash` and follow the steps. You'll log in to Cloudflare, copy the URL, and paste it back in.

Now you're ready to get going! Head back on over to the slides.
