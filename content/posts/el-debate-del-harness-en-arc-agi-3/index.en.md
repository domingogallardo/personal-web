---
title: "The harness debate in ARC-AGI-3"
date: 2026-04-01
draft: false
tags:
  - "ARC-AGI"
---

The release of ARC-AGI-3 has sparked a very interesting debate about the use of harnesses. Should they be allowed in the evaluation of LLMs on ARC-AGI-3? Francois Chollet and his team have decided that they should not: they are not going to verify solutions that contain LLMs with advanced harnesses. Every model included in the official ["Verified"](https://arcprize.org/leaderboard) leaderboard, the one they run with LLMs and frontier models outside the Kaggle competition, must be executed with a minimal harness. It should contain only the basic _prompt_ needed to run the test, as defined in the [ARC-AGI-3 technical report](https://arcprize.org/media/ARC_AGI_3_Technical_Report.pdf).

> "You are playing a game. Your objective is to win. Return the exact action you want to take. The final action in your response will be executed on the next turn."

![ARC-AGI-3 system prompt](arc-agi-3-system-prompt.png)

What is the harness of an LLM system? The term (with _scaffolding_ also used at times) became popular with the arrival of advanced tools such as Claude Code or Codex App. In these tools the LLM operates inside a complex loop that manages context, performs external calls requested by the LLM itself, or updates auxiliary files where the state and memory of the whole process are kept. In more advanced versions, harnesses can even manage multi-agent systems, coordinating different LLMs to achieve a goal.

In the case of the ARC-AGI-2 competition, at the beginning of 2026 several harness + LLM systems achieved excellent results, improving greatly on what standalone LLMs could do. I wrote about that in [the previous post](/en/posts/que-nos-ensena-arc-agi-sobre-los-modelos-de-lenguaje/), where I mentioned Johan Land's [beetree/ARC-AGI project](https://github.com/beetree/ARC-AGI), which on January 5, 2026 reached 76.11% on ARC-AGI-2. The harness he used allowed a combination of GPT-5.2, Gemini-3, and Opus 4.5 inside a long-horizon reasoning loop (about 6 hours per problem), with more than 100,000 calls to Python code, visual reasoning, and a kind of "council of judges" used to evaluate solutions.

The [justification from Chollet's team](https://x.com/arcprize/status/2037377865302589564) is that evaluating LLM systems with harnesses does not provide a reliable indication of the LLM's capabilities with respect to the benchmark, because the evaluation is also including the harness itself. If a harness + LLM system solves a task, an important part of the success may come from the strategy defined by the harness, which was designed by a human team. That goes against the idea of measuring the system's _fluid intelligence_. The LLM should be the one that, on its own, [discovers the strategies defined by the harness](https://x.com/fchollet/status/2037380345436467541?s=20) and has the capabilities it provides. Something like that is what happened with ARC-AGI-2, which was first solved by mixed harness + LLM systems and then, a couple of months later, by the new frontier LLMs.

There is an economic side to the discussion that is not mentioned very often. Running an evaluation that uses harnesses is expensive because it relies heavily on the API of the latest LLM versions, the ones with the highest cost. By deciding not to include these systems in the public leaderboard, the organization is also signaling that it is not going to absorb the cost of evaluating them.

There have been [dissenting voices on X](https://x.com/scaling01/status/2036855187738943732) and at least one research team has already [achieved a respectable result](https://x.com/symbolica/status/2037322403316117831) on ARC-AGI-3 using its own harness. The [response from Arc Prize](https://x.com/arcprize/status/2037377867210973427) seems reasonable to me: the teams proposing new mixed systems should run the evaluations themselves on the public tasks, and the results should be published in a leaderboard maintained by the organization itself, the [ARC-AGI Community Leaderboard](https://arcprize.org/leaderboard/community). That way the approach and the result get visibility, but they remain separate from the official verification process and the official competition.

Mike Knoop, co-founder of Arc Prize, has also commented on [the interest of studying mixed systems](https://x.com/mikeknoop/status/2036323325912424885). A hypothetical harness + LLM that solved ARC-AGI-3 would give us clues about the capabilities still missing from base models, capabilities that might later appear in more advanced ones. These systems could also serve as a _benchmark_ for models: different models using the same harness would obtain different scores, so the harness could help us distinguish the capabilities of the models themselves.

But the fact that these systems deserve to be studied does not justify using them in the competition's official leaderboard. I agree with Chollet that the important moment will come when LLMs are able, on their own, to do what these harnesses are doing. And we can only verify that if ARC-AGI-3 is solved by the LLMs themselves, without any external help.
