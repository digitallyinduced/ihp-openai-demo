# ihp-openai-demo
Example project showing how to use GPT3.5-turbo or GPT4 inside your IHP app.

After following the steps to install [IHP](https://ihp.digitallyinduced.com/Guide/installation.html), you can run this app locally by running:

```bash
./start
```

This will automatically deal with installing all dependencies, setting up the development database and importing fixtures.

## API Key

[You need to adjust the OpenAI Secret key inside `Questions.hs` before you can try it out.](https://github.com/digitallyinduced/ihp-openai-demo/blob/main/Web/Controller/Questions.hs#L45)
