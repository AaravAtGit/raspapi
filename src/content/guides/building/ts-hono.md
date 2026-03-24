---
title: Typescript (with Hono)
description: Build an API with Hono, a lightweight framework (easily deployed to Workers).
order: 3
---

It's time to build an API with Typescript! Before we get started, make sure you've [installed](https://bun.com/docs/installation) `bun`. You can use `node`, but `bun` is lighter & is easier to work with in my experience.

To start off, let's create a new project with `bun create hono@latest`. One of the best parts of `hono` is how easy it is to deploy - I would suggest picking `cloudflare-workers` for ease of deployment later, but any of the other options work as well! After that's done, open up `src/index.ts`. You should see the following there:

```typescript
import { Hono } from "hono";

const app = new Hono();

app.get("/", (c) => {
  return c.text("Hello Hono!");
});

export default app;
```

Let's test it out! Run it with `bun dev`, and you'll get a nice clean port to run it on (localhost:8788 if you're using Cloudflare Workers' Wrangler).

To add more routes, just add more `app.get()`, `app.post()`, etc. calls:

```typescript
app.get("/hello", (c) => {
  return c.json({ message: "Hello, RaspAPI!" });
});

app.post("/echo", async (c) => {
  const body = await c.req.json();
  return c.json({ you: body });
});
```

## Taking input

How do we take input from users for our API? We can use query, path, and body parameters.

Query parameters are what you see after the "?" in a URL. For example, in Youtube, we have links in the form: `https://www.youtube.com/watch?v=dQw4w9WgXcQ&t=19s`. Here, `v` represents the video ID, and `t` represents the timestamp. They generally modify what you see, in some manner, so they're generally used as options.

```typescript
app.get("/double", (c) => {
  const x = Number(c.req.query("x")); // this isn't automatically validated, so it'll just be NaN if this isn't a number submitted
  return c.json({ result: x * 2 });
});
```

Path parameters are parameters of, well, the path, and are generally used for data about some specific thing (e.g. user, blog post, etc.).

Path parameters (`/hello/world`):

```typescript
app.get("/hello/:name", (c) => {
  const name = c.req.param("name");
  return c.json({ message: `Hello, ${name}!` });
});
```

Body parameters are not in the URL itself, and aren't present in GET requests. If you've got something you're sending _to_ the server, this is what you should be using.

Body parameters (POST with JSON):

```typescript
type JellyBeans = {
  flavor: string;
  color: string;
  quantity: number;
};

app.post("/eatbeans", async (c) => {
  const { flavor, color, quantity } = await c.req.json<JellyBeans>(); // this indicates the response type we should expect
  return c.json({
    message: `You ate ${quantity} ${color} ${flavor} jellybeans!`,
  });
});
```

## CORS

CORS, by defaults, prevents your API from being invoked from other browsers. If you'd like to allow this API to be used in the browser by other websites, make sure to configure this to allow it.

```typescript
import { cors } from "hono/cors";

app.use(
  cors({
    origin: "*", // customize this to only allow certain domains!
  }),
);
```

## Testing your API

Hono has a builtin helper that lets us call the app and test it without making actual network requests. Here's how we can see how it'll handle certain input. First, make a new file called `index.test.ts` right next to `index.ts`. Add the following imports:

```typescript
import { describe, it, expect } from "bun:test";
import app from "./index";

describe("GET /", () => {
  it("returns hello", async () => {
    // ^^ the label here is just a label that gets printed later
    const res = await app.request("/");
    expect(res.status).toBe(200);
    expect(await res.text()).toBe("Hello Hono!");
  });
});
```

## Deploying

Cool. Let's get our API out there now!

```bash
bun run deploy
```

Log in, follow the steps, and that's it. It'll give you a URL where it's deployed, no need to go through any other deployment steps.

Remember to check the [requirements](/guides/about) before submitting!
