---
title: "April 16 to May 15 (#8 of 2024)"
date: 2024-05-17
draft: false
tags:
  - "newsletter"
  - "LLMs"
---
<p>👋👋 Hi, I'm Domingo!</p>

<p>After a fortnight's delay and with my issues around organization, time management, and procrastination more or less under control, here I am with a new issue. This time we are reviewing not one but two fortnights.</p>

<p>A small announcement: from now on, I intend to publish on Fridays, after either the first or the second fortnight of each month. Most of the newsletters I read come out on a fixed day of the week, and it seems like a good idea to try that. That way, you will know that every other Friday I will show up in your inbox. And on some Fridays when it is not due, there will be a surprise. You will see next week.</p>

<p>A lot of news in a month. Above all, a lot of new models. Let us get to it, and thank you very much for reading me.</p>

<h2>🗞 News</h2>

<p>
</p>

<p>1️⃣ On <strong>April 18</strong>, <strong>Meta</strong> released its <strong>new versions of Llama</strong>, the Meta Llama 3 models [<a href="https://llama.meta.com/llama3/">Build the future of AI with Meta Llama 3 - meta.com</a> and <a href="https://ai.meta.com/blog/meta-llama-3/">Introducing Meta Llama 3: The most capable openly available LLM to date - meta.com</a>].</p>

<p>Let us remember that Llama models are open LLMs, available to download, fine-tune, and use in any application. That said, if we use these models or create new models based on them, we will need to include the phrase “Built with Meta Llama 3” or include the name “Llama 3” at the beginning of the model name [<a href="https://llama.meta.com/llama3/license/#">META LLAMA 3 COMMUNITY LICENSE AGREEMENT - meta.com</a>].</p>

<p>Specifically, Meta has published two models, one with 8 billion parameters and another with 70 billion parameters: Llama 3 8B and Llama 3 70B. According to the benchmarks published by Meta itself, these models are the best when compared with others of similar size.</p>

<p>
<img src="/posts/del-16-de-abril-al-15-de-mayo-8-de/86510236-9946-4ad1-939b-9d645352f5d6_3840x2160.png" alt="">
</p>

<p>They are still training the larger model, with more than 400 billion parameters, called Meta Llama 3 400B+. However, they have already shared preliminary results that place it ahead of GPT-4 and on a par with Claude 3 Opus.</p>

<p>
<img src="/posts/del-16-de-abril-al-15-de-mayo-8-de/2a947743-c63f-4482-8c58-4ee6dceedc35_1632x1420.png" alt="">
</p>

<p>Performance of the latest LLMs on the most important benchmarks [<a href="https://openai.com/index/hello-gpt-4o/">Hello GPT-4o - openai.com</a>]</p>

<p>It is very interesting that these models have been built using very careful processes, for example by using high-quality datasets and texts, which have allowed them to achieve better results than much larger previous models. For example, the smaller model, Llama 3 8B, gets clearly better scores than the 70B model from a year ago, Llama 2 70B. Similarly, Llama 3 70B scores higher than GPT-3.5, with its 175 billion parameters.</p>

<p>
<img src="/posts/del-16-de-abril-al-15-de-mayo-8-de/f39565ad-44bf-4d81-aee2-b620a64d67a0_1650x588.png" alt="">
</p>

<p>Scores on the main benchmarks for Meta's models [<a href="https://github.com/meta-llama/llama3/blob/main/MODEL_CARD.md">Llama 3 Model Card - github.com</a>].</p>

<p>The size of a model matters not only for performance, but also because it determines how much space it takes up. The Llama 3 8B model is a little over 13 GB in size. In its quantized version, which reduces parameter precision to save space, it takes up roughly 4.21 GB. That size would make it possible to run it on a high-end mobile device. Although there are advanced techniques that make it possible to use models from SSD storage memory [<a href="https://www.macrumors.com/2023/12/21/apple-ai-researchers-run-llms-iphones/">Apple Develops Breakthrough Method for Running LLMs on iPhones - macrumors.com</a>], the most common approach is still that all the model weights need to be loaded into device memory in order to run it. For example, my iPhone 12 has 4 GB of RAM and could not run it. The latest models, the iPhone 15 family, have 6 GB in their basic configurations, iPhone 15 and 15 Plus, and 8 GB in their advanced configurations, 15 Pro and 15 Pro Max. The basic models would be cutting it very close, while the Pro models could run it. The ability to use a local LLM is surely going to become a differentiating factor in smartphones from now on.</p>

<p>If you want to play around with the models, you can find them on Hugging Face [<a href="https://huggingface.co/meta-llama">Meta Llama - huggingface.co</a>] and read the post published there as well [<a href="https://huggingface.co/blog/llama3">Welcome Llama 3 - Meta’s new open LLM - huggingface.co</a>].</p>

<p>2️⃣ On <strong>April 23</strong>, <strong>Microsoft</strong> released its <strong>Phi-3 models</strong> [<a href="https://azure.microsoft.com/en-us/blog/introducing-phi-3-redefining-whats-possible-with-slms/">Introducing Phi-3: Redefining what’s possible with SLMs - microsoft.com</a> and <a href="https://arstechnica.com/information-technology/2024/04/microsofts-phi-3-shows-the-surprising-power-of-small-locally-run-ai-language-models/">Microsoft’s Phi-3 shows the surprising power of small, locally run AI language models - arstechnica.com</a>]. These are small models:</p>

<ul>
<li>
<p>Phi-3-mini, with 3.8 billion parameters and a 4,000-token context window, although Microsoft also introduced a 128K-token version called “phi-3-mini-128K”.</p>

</li>
<li>
<p>Phi-3-small, with 7 billion parameters.</p>

</li>
<li>
<p>Phi-3-medium, with 14 billion parameters.</p>

</li>
</ul>

<p>The models are described in detail in the article published on arXiv [<a href="https://arxiv.org/abs/2404.14219">Phi-3 Technical Report: A Highly Capable Language Model Locally on Your Phone</a>], where Microsoft shows that the smallest model, quantized to 4 bits, can run on an iPhone 14 Pro. It is curious that Microsoft tests its language models on Apple devices.</p>

<p>The paper also presents an evaluation of these models, showing that they achieve results on benchmarks that are similar to, or in some cases even slightly better than, other small models, and are in some cases comparable to GPT-3.5.</p>

<p>
<img src="/posts/del-16-de-abril-al-15-de-mayo-8-de/8771d844-299d-447d-9ef1-2fdd64c0e714_1876x1046.png" alt="">
</p>

<p>Results of Microsoft's small models on selected benchmarks, compared with other small models and GPT-3.5.</p>

<p>The models are also open and available on Hugging Face [<a href="https://huggingface.co/collections/microsoft/phi-3-6626e15e9585a200d2d761e3">Phi-3 family of models - huggingface.co</a>].</p>

<p>An important competition is coming in the small-model space, where Apple is already taking its first steps, as the next item shows.</p>

<p>3️⃣ On <strong>April 22</strong>, <strong>Apple</strong> published several <strong>small models</strong> called OpenELM [<a href="https://arstechnica.com/information-technology/2024/04/apple-releases-eight-small-ai-language-models-aimed-at-on-device-use/">Apple releases eight small AI language models aimed at on-device use - arstechnica.com</a> and <a href="https://arxiv.org/abs/2404.14619v1">OpenELM: An Efficient Language Model Family with Open-source Training and Inference Framework - arxiv.org</a>]. In the previous issue, we mentioned that Apple’s research department was publishing results from its first language models. Well, some of those models are already openly available on Hugging Face [<a href="https://huggingface.co/apple/OpenELM-3B-Instruct">OpenELM - huggingface.co</a>] and can now be tested by the community.</p>

<p>These are still very basic models, with rather weak results compared with models of similar size. Even though Apple has really accelerated over the last year, it is still far behind research groups such as Meta and Microsoft, which in turn remain behind Google, Anthropic, and OpenAI.</p>

<p>I did a small investigation using the Wayback Machine into how the number of researchers in Apple's Hugging Face organization has evolved, with the result shown in the following chart:</p>

<p>
<img src="/posts/del-16-de-abril-al-15-de-mayo-8-de/cc4b5853-c39b-497b-9f4a-287ae66927c1_1564x846.png" alt="">
</p>

<p>Evolution of the number of researchers in Apple's organization on Hugging Face [<a href="https://web.archive.org/web/20030315000000*/https://huggingface.co/apple">Wayback Machine - archive.org</a>].</p>

<p>The number of Apple researchers on Hugging Face has gone from just 4 two years ago to 308 on the day I am writing this. I made the chart a week ago, when there were 284 researchers. In a single week, they added another 24.</p>

<p>The question now is what models Apple is going to use in its new iPhone 16 lineup, which will launch next September and this time really should arrive full of AI-related features. According to Mark Gurman, Apple's strategy is to use its own models for APIs, both on-device and in the cloud, while presenting an assistant, or chatbot, that will come from an agreement with OpenAI.</p>

<p>
<img src="/posts/del-16-de-abril-al-15-de-mayo-8-de/16d7754f-b38c-451b-a29b-4c945e28a19c_1190x400.png" alt="">
</p>

<p>
<a href="https://x.com/markgurman/status/1789460505150792030">Mark Gurman's post on X</a> about the language models Apple is going to announce at the upcoming WWDC.</p>

<p>We will know soon, at Apple's developer conference, which will take place in less than a month [<a href="https://developer.apple.com/wwdc24/">WWDC24 - apple.com</a>], where iOS 18 and all the AI features it will include will be presented.</p>

<p>4️⃣ And now we come to the high point of the month: on <strong>May 13</strong>, <strong>OpenAI</strong> held a special event where it presented its new model: <strong>GPT-4o</strong> [<a href="https://www.youtube.com/watch?v=DQacCB9tDaw">Introducing GPT-4o - youtube.com</a>]. After the 4 comes the letter “o”, for “omni”, not the number zero.</p>

<p>This is a multimodal model from the ground up. It is a project that began more than a year ago, as its director, Prafulla Dhariwal, explained.</p>

<p>
<img src="/posts/del-16-de-abril-al-15-de-mayo-8-de/b901e2a3-d839-4ecd-899e-e45099c59eed_1180x284.png" alt="">
</p>

<p>
<a href="https://x.com/prafdhar/status/1790790264178774351">Post on X</a> from the director of the GPT-4o project at OpenAI.</p>

<p>The fact that the model is multimodal means that it was trained from scratch using text, audio, and images. Although it works with video, it has not been trained on video sequences<a class="footnote-anchor" data-component-name="FootnoteAnchorToDOM" id="footnote-anchor-1" href="#footnote-1" target="_self">1</a>. Instead, it breaks down the video it is seeing into still frames and analyzes each one. It can also produce the same kinds of elements it was trained on: text, audio, or video.</p>

<p>The version they have put into production is the one that outputs text. In the demo at the event, they showed how the model was able to generate audio. And they are still testing image generation, by the model itself rather than external models such as DALL-E, before releasing that in production.</p>

<p>At the OpenAI event, the model was shown functioning as an assistant. It is able to understand what we say, the tone in which we say it, and what we show it, and it can respond with voice. A super-natural voice that expresses emotions and congratulates and encourages us. Obviously, it was trained to resemble Scarlett Johansson in <em>Her</em>.</p>

<p>Just look at how impressive this is:</p>

<div class="native-video-embed" data-component-name="VideoPlaceholder" data-attrs="{&quot;mediaUploadId&quot;:&quot;b66aaef5-0a08-44a9-9c5b-666c646a7c4a&quot;,&quot;duration&quot;:null}">
</div>
<p>As Antonio Ortiz points out [<a href="https://cuonda.com/monos-estocasticos/el-lenguaje-de-programacion-del-futuro-es-seducir-a-scarlett-johansson">Monos estocásticos 2x17 - cuonda.com</a>], it is worth noticing the moment when the AI makes a mistake at the beginning and says it “sees the image” before the image has actually been shown to it. What becomes overwhelming comes afterward, when it apologizes and does so with a specific, completely human intonation that conveys a certain embarrassment about the mistake.</p>

<p>If we watch the video carefully, we can notice that the AI produces very different intonations throughout the conversation. It is incredible that all of this is the result of a model trained only to generate the next most likely token. We have already seen that this works with text. Now OpenAI has shown that the same idea also works when the next token can be a piece of a word, or a fragment of an image or of audio. The later fine-tuning phase is also very important, in which the model's output is adapted to the preferences we want, in what is called RLHF, Reinforcement Learning with Human Feedback.</p>

<p>Let me stress one very important thing, because there has been a lot of confusion about it. In the current ChatGPT application it is already possible to have a spoken conversation. But that is absolutely not the same thing as what GPT-4o does. What we currently have on our devices is really three different models glued together by an app: one model recognizes speech and transcribes it into text, another model, GPT-4, takes text as input and returns text, and another model transforms that response text into speech. GPT-4o is totally different. There is only a single model, a single neural network, that receives tokens in any of the modalities and outputs other tokens in response, which can be text, audio, or even an image. The neural network itself, the model itself, is what produces the intonation, and also understands it. There is no post-processing layer or specific algorithm that converts text into audio. It is astonishing.</p>

<p>Another of the most important characteristics of the new assistant is its extremely low latency, it responds almost instantly, and the fact that it can be interrupted at any moment simply by talking to it. The AI is continuously listening to us and stops speaking at that moment in order to hear us and answer again.</p>

<p>As for text-generation performance, the resulting model is better than the latest version of GPT-4 and has gone straight to first place on all the major benchmarks and rankings. It is not the leap people were expecting from GPT-5, but there is still a lot of year left, and OpenAI will surely give us more surprises.</p>

<p>5️⃣ The day after the OpenAI event, on <strong>May 14</strong>, Google held <strong>Google I/O</strong>, its developer-focused event. It was obvious that OpenAI had scheduled its event as counter-programming against Google. And with a lot of success, given the impact of all the references to <em>Her</em> and the freshness of the OpenAI event, compared with a Google event that felt heavier, longer, and less focused.</p>

<p>In its keynote, Google presented many projects in progress [<a href="https://arstechnica.com/information-technology/2024/05/google-strikes-back-at-openai-with-project-astra-ai-agent-prototype/">Google strikes back at OpenAI with “Project Astra” AI agent prototype - arstechnica.com</a> and <a href="https://blog.google/technology/ai/google-gemini-update-flash-ai-assistant-io-2024/?utm_source=gdm&amp;utm_medium=referral&amp;utm_campaign=io24#gemini-model-updates">Gemini breaks new ground with a faster model, longer context, AI agents and more - blog.google</a>], but few finished products. Among the most interesting things were Veo, a video generator in the style of Sora, a new version of the image-generation model Imagen 3, and Project Astra, a voice-controlled assistant very similar to OpenAI's.</p>

<p>Google's assistant is also multimodal and can see the environment through the phone. They have not released it as a product yet, but they showed a recorded video, not a live demo like OpenAI did, showing how it works.</p>

<div class="native-video-embed" data-component-name="VideoPlaceholder" data-attrs="{&quot;mediaUploadId&quot;:&quot;05c977d6-9ba1-41bb-97e9-f4b07a741a02&quot;,&quot;duration&quot;:null}">
</div>
<p>Although what we see is quite spectacular, especially with the final “where did I leave my glasses?”, the interaction and the assistant's voice are not as polished as OpenAI's.</p>

<p>Google did not reveal many characteristics of the language model underlying this new AI. The only thing they said is that it is multimodal, like GPT-4o, but they did not provide many details and it has not yet been possible to try it.</p>

<p>They also presented a small update to the already existing Gemini 1.5 Pro model, which will support contexts of up to 2 million tokens, including text, images, and video. That is wild. Now that it is finally available in Europe, it is time to try it and see what it can do. It is true that it does not get as much attention as other models, Claude for instance gets talked about much more, but in the rankings it sits very high and it is one of the most advanced models around.</p>

<p>Even though they did not present too many real products, Google I/O was full of references to AI. The video TechCrunch put together and <a href="https://x.com/TechCrunch/status/1790504691945898300">posted on X</a> is very funny:</p>

<div class="native-video-embed" data-component-name="VideoPlaceholder" data-attrs="{&quot;mediaUploadId&quot;:&quot;6b623eae-8666-4fe5-a20f-7f48e357d2e3&quot;,&quot;duration&quot;:null}">
</div>
<p>6️⃣ Speaking of <strong>rankings</strong> and <strong>benchmarks</strong>, many of them have been updated lately. Let us go through them.</p>

<p>The first, one of the most widely used, is MMLU, which has just launched a new and more advanced version called MMLU-Pro [<a href="https://huggingface.co/datasets/TIGER-Lab/MMLU-Pro">MMLU-Pro - huggingface.co</a>]. It is a collection of 12,000 questions from different fields, biology, mathematics, economics, computer science, and so on. In the latest version they have increased the number of options for each question to 10. It is produced by the TIGER-Lab at the University of Waterloo.</p>

<p>The following figure shows the results of the latest model evaluation, with GPT-4o clearly in first place.</p>

<p>
<img src="/posts/del-16-de-abril-al-15-de-mayo-8-de/41375f47-6e4a-414a-ab69-1dbf70c32e89_1979x1180.png" alt="">
</p>

<p>
<a href="https://x.com/WenhuChen/status/1790597967319007564">Wenhu Chen's post on X</a> with the latest MMLU-Pro benchmark results.</p>

<p>Another type of ranking is the LMSys arena [<a href="https://chat.lmsys.org/?leaderboard">LMSYS Chatbot Arena Leaderboard - lmsys.org</a>], where the score is obtained from head-to-head matchups between pairs of models. Users give them prompts, read their answers, and then choose a winner. We can see that the clear winner is once again GPT-4o, under the codename it used for a few days, im-also-a-good-gpt2-chatbot, some distance ahead of another leading group formed by versions of GPT-4, Gemini-1.5-pro, and Claude-3-opus.</p>

<p>
<img src="/posts/del-16-de-abril-al-15-de-mayo-8-de/c811fc0b-9fb6-43c4-913c-980a6773a6f6_1200x700.jpeg" alt="">
</p>

<p>Another very interesting chart is the one Maxime Labonne publishes regularly on X, in which you can see how models evolve over time. On the vertical axis he places the score obtained in LMSys-Arena, and on the horizontal axis the date the model was released. He also marks closed models in red and open ones in green. This makes it possible to analyze how the different types of models progress.</p>

<p>
<img src="/posts/del-16-de-abril-al-15-de-mayo-8-de/6fe32617-c940-4d96-9368-bd6f01200d23_3493x2402.jpeg" alt="">
</p>

<p>We can observe some very interesting things. For example, Meta's strongest current model, Llama-3 70B, is at the level of GPT-4 from a year ago. One year seems to be the time it takes for OpenAI's advances to diffuse into open models. I suppose the same will continue to happen in the future, and that by June 2025 we will see open models similar to the current GPT-4o. Another interesting thing to notice is that the upper curve keeps rising, which brings us to the next item.</p>

<p>7️⃣ The whole industry remains convinced that <strong>the scaling hypothesis</strong> [<a href="https://gwern.net/scaling-hypothesis">The scaling hipothesis - gwern.net</a>] is true, and that larger models trained on larger and more varied datasets will obtain considerably better results. There are many ongoing investments, from Microsoft, OpenAI, Meta, and others, in building enormous data-processing centers, and even in building power plants to feed those centers.</p>

<p>For example, in the interesting interview with Dario Amodei [<a href="https://podcasts.apple.com/es/podcast/the-ezra-klein-show/id1548604447?i=1000652234981">What if Dario Amodei Is Right About A.I. - apple.com</a>] on the New York Times podcast <em>The Ezra Klein Show</em>, Anthropic's CEO shows himself to be fully convinced of this scaling hypothesis and talks about figures of 10 billion dollars to train future models:</p>

<blockquote>
<p>"We are going to have to make bigger models that use more compute per iteration. We are going to have to run them for longer while feeding them more data. And that amount of chips multiplied by the time we run things on them essentially translates into a monetary value, because these chips are rented by the hour. That is the most common model for doing it. So current models cost on the order of 100 million dollars to train, give or take a factor of two or three. The models that are currently being trained, and that will come out at various points later this year or early next year, are closer to costing a billion dollars. So that is already happening. And then I think in 2025 and 2026, we get closer to five or ten billion.</p>

<p>So is it going to be 100 billion dollars? I mean, very quickly, the financial firepower you need to create one of these is going to exclude anyone except the biggest players."</p>

</blockquote>

<p>Mark Zuckerberg, Meta's CEO, is somewhat more cautious in the interview on Dwarkesh Patel's podcast [<a href="https://www.dwarkeshpatel.com/p/mark-zuckerberg">Mark Zuckerberg - Llama 3, Open Sourcing USD 10b Models, &amp; Caesar Augustus - dwarkeshpatel.com</a>]:</p>

<div id="youtube2-bc6uFV9CJGg" class="youtube-wrap" data-attrs="{&quot;videoId&quot;:&quot;bc6uFV9CJGg&quot;,&quot;startTime&quot;:null,&quot;endTime&quot;:null}" data-component-name="Youtube2ToDOM">
<div class="youtube-inner">
<iframe src="https://www.youtube-nocookie.com/embed/bc6uFV9CJGg?rel=0&amp;autoplay=0&amp;showinfo=0&amp;enablejsapi=0" frameborder="0" loading="lazy" gesture="media" allow="autoplay; fullscreen" allowautoplay="true" allowfullscreen="true" width="728" height="409">
</iframe>
</div>
</div>
<blockquote>
<p>"This is one of the big questions, right? [the exponential growth in model performance] I think nobody really knows. One of the hardest things to plan around is an exponential curve. How long will it keep going? I think it is probable enough that we will keep advancing that it is worth investing the 10 billion, or more than 100 billion dollars, into building the infrastructure and assuming that if it keeps going, you will get really amazing things that will make incredible products. I do not think anyone in the industry can tell you with certainty that it will continue scaling at this rate. In general, in history, you run into bottlenecks at certain points. Right now there is so much energy behind this that perhaps those bottlenecks will be overcome fairly quickly. I think that is an interesting question."</p>

</blockquote>

<p>And regarding the size of future models and whether Meta will also release them openly:</p>

<blockquote>
<p>"We have a roadmap of new releases that are going to bring multimodality, more multilingual capability, and larger context windows as well. Hopefully, at some point later this year, we will be able to release the 405 billion parameter model."</p>

</blockquote>

<blockquote>
<p>"Obviously we are very in favor of open source, but I have not committed to releasing absolutely everything we do. Basically I am strongly inclined to think that open source will be good for the community and also for us because we will benefit from the innovations. However, if at some point there is a qualitative change in what the thing is capable of doing, and we feel that it would not be responsible to make it open source, then we will not do it. It is very hard to predict."</p>

</blockquote>

<h2>👷‍♂️ My thirty days</h2>

<p>Even though a whole month has passed since the previous issue, I do not have many updates to share. Not in books, I am still with <em>The Dark Forest</em> and have not progressed very much, and not in the things I have been tinkering with.</p>

<p>I am going to highlight the two films I liked most out of everything we watched.</p>

<h3>📺 Two films</h3>

<p>Two very different films, but I liked both of them a lot<a class="footnote-anchor" data-component-name="FootnoteAnchorToDOM" id="footnote-anchor-2" href="#footnote-2" target="_self">2</a>.</p>

<p>The first is <strong>All of Us Strangers</strong>, by <strong>Andrew Haigh</strong>, with tremendous performances by <strong>Andrew Scott</strong> and <strong>Paul Mescal</strong>. A very personal and profound film, moving and thought-provoking. And with a soundtrack full of evocative songs for those of us who were young in the 1980s.</p>

<p>
<img src="/posts/del-16-de-abril-al-15-de-mayo-8-de/86dea0b3-54c5-4ed7-afa3-2e01371b8cf7_800x1200.jpeg" alt="">
</p>

<p>And the second is <strong>Kingdom of the Planet of the Apes</strong>, by <strong>Wes Ball</strong>. A return to adventure and to the themes I find most interesting in the saga: the formation of ape society, its relationship with humans, the inverted power relations between apes and humans, and the rewriting of history by the victors.</p>

<p>Some scenes reminded me of the original Charlton Heston film, and I had the feeling that the story is moving in that direction. I want more.</p>

<p>
<img src="/posts/del-16-de-abril-al-15-de-mayo-8-de/7b58adec-d6b4-4c60-862d-6ebe33c7e49f_809x1200.jpeg" alt="">
</p>

<p>And that is it for this month. Until the next fortnight, see you then! 👋👋</p>

<div class="footnote" data-component-name="FootnoteToDOM">
<a id="footnote-1" href="#footnote-anchor-1" class="footnote-number" contenteditable="false" target="_self">1</a>
<div class="footnote-content">
<p>At present there is no language model that has been trained on video sequences. There is currently no computing power available to carry out such training. Perhaps it will happen with GPT-6 or GPT-7, and that really would be revolutionary, because a model of that kind could learn and generalize how the real world works, the physics implicit in the motion of objects. And in turn, it could apply those concepts to the other modalities, for example by understanding spatial relations better when we talk about far/near or left/right.</p>

</div>
</div>
<div class="footnote" data-component-name="FootnoteToDOM">
<a id="footnote-2" href="#footnote-anchor-2" class="footnote-number" contenteditable="false" target="_self">2</a>
<div class="footnote-content">
<p>My daughter Lucía is going to scold me for not including <strong>Challengers</strong>, but she already knows why 😂. I promise to comment on the film the next time I watch it ❤️.</p>

</div>
</div>
