---
title: "June 16 to 30 (#12 of 2024)"
date: 2024-07-05
draft: false
tags:
  - "newsletter"
---

This English version is an abridged translation of the original newsletter issue, centered on the main arguments and linked topics.

## News

### 1. Climate update

Now that summer has arrived, it seemed like a good moment to revisit the **global temperature trends** I had written about [in April](/posts/del-1-al-15-de-abril-7-de-2024/). The data, as before, came from the [Climate Reanalyzer](https://climatereanalyzer.org/) project at the University of Maine.

![](Captura%20de%20pantalla%202024-07-04%20a%20las%2012.05.10.png)

The black line for 2024 seemed to be flattening slightly, which gave some hope, and the **sea surface temperature** in the Northern Hemisphere had finally dropped below the previous year's level.

![](Captura%20de%20pantalla%202024-07-04%20a%20las%2012.13.43.png)

Was **El Niño** already fading? Were the atmospheric effects of the [Hunga Tonga eruption](/posts/del-1-al-15-de-abril-7-de-2024/) beginning to disappear? It was too early to say, but at least the graphs were momentarily less frightening.

### 2. Runway's Gen-3 Alpha

On June 17, [Runway](https://runwayml.com/) introduced its new video generation model, [**Gen-3 Alpha**](https://runwayml.com/blog/introducing-gen-3-alpha/). The clips were only a few seconds long, but their quality and coherence were impressive, clearly in the same league as the Sora demos we had discussed months earlier.

![](sora-gen3.png)

Even so, my reaction remained the same as in February: these are remarkable technical advances, but we still have **very little control over the result**, and I do not think this approach scales naturally toward making a short film or a feature film. More importantly, I am not especially interested in films generated at random from a text prompt. When I go to the cinema, I want to see something **created by people and performed by people**, or if it is animation, a coherent work shaped by human artistic decisions.

### 3. François Chollet everywhere

As a consequence of the impact of the [ARC competition](https://arcprize.org/), which I had already discussed [in the previous issue](/en/posts/del-1-al-15-de-junio-11-de-2024/), **François Chollet** started appearing in several podcasts. After listening carefully to his conversations with **Dwarkesh Patel** and **Sean Carroll**, I became a full-scale Chollet enthusiast.

The first key idea I took away from the Dwarkesh conversation is that Chollet sees LLMs as a kind of **huge interpolative memory**: a giant collection of learned patterns and programs. When we query an LLM, it interpolates among those patterns.

> The way LLMs work is that they are basically a big interpolative memory. The way you increase their capabilities is by trying to stuff as much knowledge and as many patterns into them as possible.

For Chollet, that gives LLMs real usefulness but not true general intelligence. They are good at pattern recognition and retrieval, but not at inventing new programs through search when facing novelty. In his view, **search** is indispensable for intelligence.

> To get novelty, you need search. LLMs cannot do search, they can only do interpolation.

That leads him to favor hybrid systems that combine deep learning with search and exploration.

The interview with **Sean Carroll** made the same ideas even clearer, in a more didactic form. Chollet argues that the current generation of LLMs may be approaching a kind of **plateau**, partly because of limitations in truly new training data. He also insists that AGI, even if it arrives, would still be **a tool**, not an autonomous force with goals of its own unless someone deliberately built those goals into it.

### 4. Claude 3.5 Sonnet and Gemma-2

Late June also brought two new LLM releases worth paying attention to: Anthropic launched [**Claude 3.5 Sonnet**](https://www.anthropic.com/news/claude-3-5-sonnet), and Google launched the 27B open model [**Gemma-2**](https://blog.google/technology/developers/google-gemma-2/).

The broader trend here seemed important: instead of only chasing giant flagship models, labs were also shipping **smaller models trained better**, and those smaller models were catching up surprisingly fast.

![](966072e9-3092-46d9-aa40-e2051b8de4b2_2200x1174.webp)

Anthropic's chart was especially striking because it showed Sonnet overtaking larger earlier models. The same pattern had already appeared with Gemini 1.5 Pro. The obvious question was whether scale alone still explained everything, or whether training quality and architectural refinements were starting to matter even more.

Sonnet 3.5 also shipped with **artifacts**, which made it possible to generate and run code in a side panel. I used it to build a small game that ended up as a loose variation on Pong, and the result felt genuinely impressive.

### 5. GPT-4 is no longer unique

Another reflection from those weeks: **GPT-4 no longer seemed unique**. When GPT-4 launched in March 2023, many of us wondered whether OpenAI possessed some special sauce that others would struggle to replicate. A year later, the answer increasingly looked like “no”.

![](60280659-5c6f-4d7a-b8d5-2246de11bd4a_2048x1152.jpeg)

Anthropic, Google, and Meta were already near GPT-4 territory, and in some cases they were reaching it with smaller models. That left the bigger question still open: if GPT-5 ends up being another order of magnitude larger, will that also imply another order-of-magnitude jump in intelligence?

At the time, many people expected GPT-5 to arrive with around 20T parameters, trained on far larger GPU clusters. Whether that would produce another dramatic leap or expose the limits of scaling was still unclear. The industry was betting heavily on the optimistic outcome.

### My view at that point

My own position was, and still is, cautious. I think it was **too early to draw a final conclusion**. Chollet's idea that LLMs learn program-like patterns actually leaves room for bigger models to generalize better, not just memorize more. And some of the limits pointed out by people like LeCun, especially the lack of a physical model of the world, might change once models are trained directly on richer video sequences rather than static snapshots.

But it is also possible that LeCun and Chollet are right and that we are already close to the ceiling of what transformers and current LLM techniques can do on their own.

## My two weeks

### Films

Among the films of the fortnight, the one I would highlight most is [*The Greatest Hits*](https://letterboxd.com/domingogallardo/film/the-greatest-hits/), a sweet story about love, music, and time jumps. It reminded me of other films and series I love in that same emotional register, from *Begin Again* to *Sing Street*.

![](70b37988-de18-47e5-a6a1-d3f8cbae030b_599x887.jpeg)

### TV

The TV pick of the fortnight was Apple's adaptation of **Dark Matter**. Even though the multiverse theme is already a bit overused, I thought this series handled it well, with enough invention and enough genuine narrative purpose to keep it interesting.

![](a1723ce5-ace2-42fa-9a6e-56487bac1e1d_800x1200.jpeg)

---

See you next time.

[^1]: Although the most advanced LLMs are multimodal, they have not really been trained on full video sequences, but rather on still frames extracted from video. Cinema has taught us that we need about 24 frames per second to perceive motion as continuous. LLM training may not need so many FPS, but even training on 5 or 10 FPS would require compute capacity two or three orders of magnitude larger than what is common today.
