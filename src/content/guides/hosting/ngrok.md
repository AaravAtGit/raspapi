---
title: Ngrok (selfhosted)
description: Connect your selfhosted API to the internet with Ngrok.
order: 2
---

Before we get started, I would highly recommend using other options such as Cloudflare Tunnels if you have a custom domain. Ngrok provides you only one static randomly generated subdomain (which you'll need to submit to us).

Righty on then! Let's get your API online. First, go to [Ngrok](https://ngrok.com/) and sign up for an account. Then, download the Ngrok client for your operating system. Below you'll see the Mac setup (though Windows is just as simple).

![ngrok screenshot](https://cdn.hackclub.com/019cc17a-463c-7774-8578-bef911dc9e91/Screenshot%202026-03-05%20204832.png)

If you want to make sure it's persistent, swap to Docker and run the command there (assuming you've already got Docker installed). It should look something like this (for Windows/Mac):

```bash
docker run -it -e NGROK_AUTHTOKEN=yourtokengoeshere ngrok/ngrok:latest http --url=yoursubdomaingoeshere.ngrok-free.app host.docker.internal:80
```

And... that's it! If it's not using the dev domain you see (redacted in red above), make sure to add `--url=something.ngrok-free.app` to your Ngrok command, replacing that with your actual dev domain you're provided.
