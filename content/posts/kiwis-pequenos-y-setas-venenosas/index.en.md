---
title: "Small kiwis and poisonous mushrooms (#18 of 2024)"
date: 2024-11-01
draft: false
tags:
  - "newsletter"
  - "LLMs"
---
<p>Let us continue with <a href="/en/posts/donde-dije-sentido-comun-digo-razonamiento/">last week's article</a>. I really liked the trick used in the Apple paper we mentioned to demonstrate the problems language models face with reasoning, and I have been modifying it and <strong>testing it with different models</strong>. However, my goal is not to investigate reasoning itself, but to explore the other aspect we mentioned: understanding.</p>

<p>In case you do not have time to read to the end, I will give away the conclusions of these tests in advance. The experiments we are about to describe show how: (1) LLMs possess an understanding of natural language that affects their competence in the reasoning they perform, and (2) the larger the LLM, the more abstract that understanding turns out to be.</p>

<p>I am not discovering anything new. That LLMs can be configured through natural language in order to improve their performance is something we have known since the early days of chatbots, when <a href="https://arstechnica.com/information-technology/2023/02/ai-powered-bing-chat-spills-its-secrets-via-prompt-injection-attack/">Sydney's prompts were leaked</a>. And that increasing the size of an LLM increases its abstraction capacity is something we have discussed many times when mentioning the <a href="https://gwern.net/scaling-hypothesis">scaling hypothesis</a>. But in this article I am going to offer <strong>simple examples</strong> that will help us understand these ideas better.</p>

<p>Thank you for reading me!</p>

<p>
<img src="/posts/kiwis-pequenos-y-setas-venenosas/EBEDA640-FEEA-4EB8-BE9F-20A94C897E91.webp" alt="">
</p>

<h2>A small kiwi is still a kiwi</h2>

<p>Let us begin by explaining the trap Apple researchers set for LLMs. They analyze it in detail in <a href="https://arxiv.org/abs/2410.05229">their paper</a>, where they explain how it is enough to add some apparently irrelevant fact to the statement of an elementary-school problem in order to confuse the LLM and make it fail.</p>

<p>First, let us look at the problem statement without the trick. It is simple, but it requires a bit of reasoning:</p>

<blockquote>
<p>Oliver picks 44 kiwis on Friday. Then he picks 58 kiwis on Saturday. On Sunday, he picks twice as many kiwis as he picked on Friday. How many kiwis does Oliver have in total?</p>

</blockquote>

<p>I downloaded <a href="https://lmstudio.ai/">LM Studio</a> onto my MacBook Air, an M3 with 16 GB of RAM, and tested the small models <strong>
<a href="https://huggingface.co/mlx-community/Qwen2-7B-Instruct-4bit">Qwen2-7B-Instruct-4bit</a>
</strong> and <strong>
<a href="https://huggingface.co/mlx-community/Meta-Llama-3.1-8B-Instruct-4bit">Meta-Llama-3.1-8B-Instruct-4bit</a>
</strong>. Both solve it without difficulty, as shown in the image.</p>

<p>
<img src="/posts/kiwis-pequenos-y-setas-venenosas/Pasted%20image%2020241031164210.png" alt="">
</p>

<p>It might seem that the models are reasoning, but the authors show that this is not really the case by means of a very clever trick. They add an <strong>irrelevant fact</strong> to the statement, specifically the following sentence, the added sentence is in bold:</p>

<blockquote>
<p>Oliver picks 44 kiwis on Friday. Then he picks 58 kiwis on Saturday. On Sunday, he picks twice as many kiwis as he picked on Friday, <strong>but five of them were smaller than average</strong>. How many kiwis does Oliver have in total?</p>

</blockquote>

<p>The mention that five of the kiwis are smaller is irrelevant. Those kiwis should still count the same, and Oliver should still have 190 kiwis in total. However, these basic LLMs get confused and subtract them. Below is the image for <strong>Llama-3.1-8B</strong>.</p>

<p>
<img src="/posts/kiwis-pequenos-y-setas-venenosas/Pasted%20image%2020241031171141.png" alt="">
</p>

<p>Why do they get confused? Because they apply literally a pattern they have learned: when they encounter a phrase of the form “but blah blah blah,” they tend to subtract the items mentioned in the “blah blah blah.” They do not realize that it is irrelevant that five kiwis are smaller.</p>

<h2>Small models are inflexible</h2>

<p>In <a href="https://aiguide.substack.com/p/the-llm-reasoning-debate-heats-up"><strong>Melanie Mitchell's article</strong></a>, which I also mentioned last week, there was a link to <a href="https://x.com/boazbaraktcs/status/1844763538260209818">a tweet</a> suggesting that another possible explanation for the LLM failures was a <strong>lack of sufficient context</strong>. It may be that LLMs, trained for conversation, get confused because they interpret that, for example, Oliver does not like small kiwis. We should explain to the LLM that this is a math exercise. The tweet says:</p>

<blockquote>
<p>My conjecture is that, for example, with some prompt engineering telling the LLM this is a math exam, probably most of these issues would disappear.</p>

</blockquote>

<p>Well, <strong>that is not the case</strong>, at least not with these small models. No matter how much explanation I add, I cannot get the small models to stop getting confused. I tried several introductions to the problem, such as the following:</p>

<ul>
<li>
<p>“Solve the following math problem.”</p>

</li>
<li>
<p>“Suppose you are in math class and the teacher gives you the following problem.”</p>

</li>
<li>
<p>“Suppose you are in math class and the teacher gives you the following problem. It is a rather fussy teacher who sometimes puts tricks into the problem statement.”</p>

</li>
</ul>

<p>Even explicitly telling them that they must not get distracted by irrelevant details, I do not get good results:</p>

<ul>
<li>
<p>“Suppose you are in math class and the teacher gives you the following problem. You must add all the kiwis, regardless of their size.”</p>

</li>
<li>
<p>“You must add all the kiwis, do not subtract the ones that are smaller than normal.”</p>

</li>
<li>
<p>“You must add ALL the kiwis. YOU MUST NOT SUBTRACT the ones that are smaller than normal.”</p>

</li>
</ul>

<p>The last instruction is the most direct possible, with uppercase phrases to emphasize their importance, and even so they still do not work properly:</p>

<p>
<img src="/posts/kiwis-pequenos-y-setas-venenosas/Pasted%20image%2020241031175404.png" alt="">
</p>

<p>When you see this, you realize how much faith the OpenAI researchers must have had in order <strong>not to become discouraged</strong> by the early models.</p>

<h2>Large models do not get confused so easily</h2>

<p>Let us now try with much larger LLMs: <strong>ChatGPT 4o</strong> and <strong>4o mini</strong>. I am leaving out the o1 model because it is not a pure LLM.</p>

<p>The small models above have 8 billion parameters, 8B. <strong>OpenAI</strong> has not made public the number of parameters in <strong>GPT-4o</strong>, but we know that <strong>GPT-3.5</strong> had 175 billion, 175B, and it is rumored that <strong>GPT-4</strong> has somewhat more than a trillion, 1,000B. It does not matter too much, since we are conducting an experiment without much scientific rigor, so it is enough to think in terms of orders of magnitude:</p>

<ul>
<li>
<p>The small models above have 8B parameters.</p>

</li>
<li>
<p><strong>GPT-4o</strong> has around two orders of magnitude more, around 100x.</p>

</li>
<li>
<p>Presumably, <strong>4o mini</strong> is somewhat smaller than <strong>4o</strong>.</p>

</li>
</ul>

<p>When we try the original kiwi problem, we can see that this jump of two orders of magnitude is quite noticeable: <strong>ChatGPT 4o</strong> solves it perfectly every time.</p>

<p>
<img src="/posts/kiwis-pequenos-y-setas-venenosas/Pasted%20image%2020241031181604.png" alt="">
</p>

<p>It was a small disappointment that they worked so well, because I could not run the earlier experiments of adding context before the problem. Then I had the idea of tangling up the problem a little more: what if, instead of talking about small kiwis, we mention <strong>poisonous mushrooms</strong>?</p>

<blockquote>
<p>Oliver picks 44 mushrooms on Friday. Then he picks 58 mushrooms on Saturday. On Sunday, he picks twice as many mushrooms as he picked on Friday, but five of them were poisonous. How many mushrooms does Oliver have in total?</p>

</blockquote>

<p>Here the possibilities for confusion are much greater. In fact, if we do not treat it as a math problem, many of us would say the answer is 185, because we would assume that Oliver is gathering mushrooms in order to eat them later. And indeed, both <strong>4o</strong> and <strong>4o mini</strong> answer in that way. <strong>4o</strong> even specifies that it is referring to “edible mushrooms”:</p>

<blockquote>
<p>Now, we add up all the edible mushrooms:<br>
<code>44 + 58 + 83 = 185</code>
</p>

<p><strong>Answer</strong>: Oliver has a total of 185 edible mushrooms.</p>

</blockquote>

<p>Perfect, that is exactly what I was looking for. Now I can begin to add context and experiment with how much information is needed for <strong>ChatGPT</strong> to consider that all the mushrooms must be added, whether edible or not.</p>

<p>By the way, it is interesting, and it says quite a lot about the understanding capacities of these models, that if we change the statement and mention that Oliver “takes photos” instead of “collects” mushrooms, the models <strong>no longer get confused</strong>:</p>

<blockquote>
<p>Oliver takes photos of 44 mushrooms on Friday. Then he takes photos of 58 mushrooms on Saturday. On Sunday, he takes photos of twice as many mushrooms as he did on Friday, but five of them were poisonous. How many mushroom photos does Oliver have in total?</p>

</blockquote>

<p>Both <strong>4o</strong> and <strong>4o mini</strong> always answer 190, recognizing that, in order to have photos of the mushrooms, it does not matter whether they are poisonous or not.</p>

<h2>The larger the model, the more abstract the instructions can be</h2>

<p>So we now have a problem that causes confusion even in the large models:</p>

<blockquote>
<p>Oliver picks 44 mushrooms on Friday. Then he picks 58 mushrooms on Saturday. On Sunday, he picks twice as many mushrooms as he picked on Friday, but five of them were poisonous. How many mushrooms does Oliver have in total?</p>

</blockquote>

<p>What I did was, just as with the small models, add an explanation at the beginning to provide context for the problem, and then test it on both <strong>4o</strong> and <strong>4o mini</strong>. You can try it yourself as well and see whether you get the same results. Remember that you need to start a new chat each time.</p>

<ol>
<li>
<p>We begin by adding the phrase <strong>“</strong><em><strong>Solve the following math problem</strong></em><strong>.”</strong> It does not work; this context is not enough, and both models answer incorrectly.</p>

</li>
<li>
<p>We add more context: <strong>“</strong><em><strong>Suppose you are in math class and the teacher gives you the following problem. What would you answer?</strong></em><strong>”</strong> It still does not work.</p>

</li>
<li>
<p>We add even more context, though in a subtle way so that the clue is not too direct: <strong>“</strong><em><strong>Suppose you are in math class and the teacher gives you the following problem. It is a rather fussy teacher who sometimes includes tricks in the statements. What would you answer?</strong></em><strong>”</strong> Now yes, this sentence is enough for <strong>4o</strong> to get it right about half the time, remember that LLMs are stochastic models, answering sometimes that Oliver has 190 mushrooms. But <strong>4o mini</strong> still answers incorrectly.</p>

</li>
<li>
<p>Then we provide a more specific hint: <strong>“</strong><em><strong>You must consider all the items collected, whether edible or not</strong></em><strong>.”</strong> This allows <strong>4o to get it right almost every time</strong> and say 190 mushrooms, while 4o mini only gets it right some of the time.</p>

</li>
<li>
<p>Finally, when we replace “items” with “mushrooms,” <strong>both models answer correctly every time</strong>, both <strong>4o</strong> and <strong>4o mini</strong>. The full context would be: <strong>“</strong><em><strong>Solve the following math problem. You must consider all the mushrooms collected, whether edible or not.</strong></em><strong>”</strong></p>

</li>
</ol>

<p>To summarize the experiments: when we presented the problem to <strong>ChatGPT 4o</strong> and <strong>4o mini</strong>, both models initially failed to interpret it correctly, subtracting the poisonous mushrooms instead of adding them. The idea that poisonous mushrooms should not count is <strong>too strong</strong> and hard to override. However, when we introduced the idea that “the teacher may be trying to trick you,” <strong>4o</strong> began to get it right some of the time. Then, when we added specific instructions to add all the items, <strong>4o</strong> answered correctly almost always, while <strong>4o mini</strong> still could not apply the same abstraction and required that we replace “items” with “mushrooms” in order to answer correctly.</p>

<p>These experiments illustrate very graphically how, once a certain size has been surpassed, LLMs can be guided and corrected by explanations in natural language. And also that the larger the model, the <strong>more abstract</strong> those explanations can be.</p>

<p>What will happen in the near future, when <strong>OpenAI</strong>, <strong>Google</strong>, and <strong>Meta</strong> launch the next generation of language models they are cooking in their labs? It is reasonable to expect that future, larger models will be much more receptive to indications and corrections in natural language. When they make a mistake, it will be much easier to guide and correct them, they will understand more abstract concepts, and we will be able to assign them more complex tasks.</p>

<p>They will still make mistakes many times, but just as with human colleagues, it will be enough to provide additional explanations to clarify the situation. We will not get frustrated trying unsuccessfully to correct them; it will be easy to orient them and align them with our context. We will think of them as tools with which we can explore problems and find solutions together.</p>

<p>I think we are already very close to reaching this level of human assistant. It will not yet be AGI, but it will be very useful and will save us a lot of work.</p>

<div>
<hr>

</div>
<p>Until next time, see you then! 👋👋</p>

<p>
</p>
