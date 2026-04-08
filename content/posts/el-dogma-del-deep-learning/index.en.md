---
title: "The dogma of deep learning"
date: 2024-12-18
draft: false
tags:
  - "newsletter"
---

![](Pasted%20image%2020241215092155.png)

## The McCulloch and Pitts paper

The 1943 paper by **McCulloch and Pitts**, [*A Logical Calculus of the Ideas Immanent in Nervous Activity*](https://home.csulb.edu/~cwallis/382/readings/482/mcculloch.logical.calculus.ideas.1943.pdf), was the foundational work of connectionism and of artificial neural networks, ANNs. The paper starts from what was known at the time about the operation of neurons and establishes, in a dense and highly mathematical way, an equivalence between the functioning of neurons and a **network of logical propositions** in which neurons represent variables that can only take two values, “all-or-none”, identified with the Boolean values TRUE and FALSE.

![](Pasted%20image%2020241215092106.png)

Image from the original McCulloch and Pitts paper showing neurons as logical units.

Five years earlier, in 1938, **Claude Shannon** had published at MIT his master's thesis [*A Symbolic Analysis of Relay and Switching Circuits*](https://dspace.mit.edu/handle/1721.1/11173), in which he showed how to design electrical circuits that implemented logical operations defined by Boolean algebra. This practical approach made it possible to build **devices capable of carrying out basic logical functions** such as AND, OR, and NOT, and it marked the beginning of the extraordinary 1940s, when researchers such as **Von Neumann** and **Alan Turing** designed the first digital computers.

![](Pasted%20image%2020241215122123.png)

Table from Shannon's article showing the logical operations performed by his circuits.

Although **McCulloch and Pitts** did not cite **Shannon** in their paper,[^1] it is quite likely that they were inspired by his concept of **logical circuits**. If those circuits could be the basis of the new digital computers that were beginning to appear, why could they not also be the way neurons worked? In any case, both papers became foundational and laid the groundwork for the late-1940s revolution in digital computers and for today's AI revolution. As a curiosity, both models were based on **Boolean algebra**, a theoretical system proposed a century earlier by the English mathematician **George Boole**. It is a fascinating example of how a mathematical theory that at first seems purely abstract can, a hundred years later, become the foundation of radical technological change: digital computers and artificial intelligence.

The **McCulloch-Pitts** model was later modified in several ways, the most important being the **Perceptron** introduced by **Frank Rosenblatt** in 1958. In that model, **weights** were added to the connections between neurons and an activation threshold was introduced, determining whether a neuron “fired” or not, producing a 1 or a 0, depending on the weighted sum of its inputs. If the sum exceeded the threshold, the neuron activated.

In modern neural networks this concept has evolved a great deal. Contemporary activation functions, such as sigmoid, hyperbolic tangent, or ReLU, allow neurons to take **continuous values** instead of binary ones. Sigmoid, for example, produces values in the range [0, 1], while tanh normalizes them into [-1, 1]. This evolution has given modern neural networks greater flexibility and learning capacity, making it easier to represent complex relations and to propagate errors efficiently during training.

With these modifications, with the discovery of efficient weight-update algorithms, and with the **exponential multiplication** of the number of neurons,[^2] ANNs have reached the point where, in [Ilya Sutskever's words](https://github.com/shun-liang/readable-talks-transcriptions/blob/main/neurips_2024/Vincent%20Weisser%20-%20.%40ilyasut%20full%20talk%20at%20neurips%202024%20pre-training%20as%20we%20know%20it%20will%20end%20and%20what%20comes%20next%20is%20superintelligence%20agentic%2C%20reasons%2C%20understands%20and%20is%20self%20aware.md) in his NeurIPS 2024 talk, they can do anything a human can do intuitively:

> They can do anything a human being can do in a fraction of a second.

## The human brain as an enormous artificial neural network

More than eighty years ago, in the conclusion of their paper, **McCulloch and Pitts** made bold claims equating the complete functioning of the brain with the state of their proposed network of logical neurons:

> The specification, at a given time, of the afferent stimulation and of the activity of all the constituent neurons, each with all-or-none behavior, determines the [global brain] state. **The specification of the nervous network provides the necessary law of connection, by means of which the successor state can be calculated from the description of any state.**
>
> **Every idea and every sensation** is realized through activity within that network.

The level of self-confidence and lack of humility is striking. These statements were not presented as hypotheses or future speculations, but as definitive conclusions. And yet they lacked experimental support, since they were based only on a mathematical formulation, without references to neurophysiological or cellular research backing them up.

Curiously, time may have proved them right. The idea that ANNs are a valid abstraction of natural neurons has become the **central dogma of connectionism**, as **Ilya Sutskever** described it in that same NeurIPS 2024 talk:

> It is the **central idea of deep learning**: the idea of connectionism. It is the belief that if you accept that **an artificial neuron is in some sense analogous to a biological neuron**, then you can trust that very large neural networks, even if not necessarily as large as the human brain, can be configured to perform practically all the tasks that we, as human beings, are capable of carrying out.

![](Pasted%20image%2020241216132628.png)

Ilya Sutskever at his NeurIPS 2024 plenary talk, presenting the central idea of connectionism.

Many current AI scientists share this reductionist outlook. **Oriol Vinyals**, a prominent **Google DeepMind** researcher, said in an interview on the [DeepMind podcast](https://youtu.be/78mEYaztGaw?si=LMTItsoqTGAm-DX2):

> You can imagine one neuron connected to many others, and what you essentially do is sum all the activations of the incoming neurons, multiplied by their respective weights. **That is, in essence, how a brain works**, with a bit of creative license.

One of the great strengths of this abstraction has been its **computational efficiency**. Neurons and weights can be represented as huge matrices of real numbers and processed in parallel on powerful GPUs designed for massive linear-algebra workloads. This has made it possible to train ever larger and more complex ANNs, with spectacular successes in recognizing patterns and regularities, in ways that imitate the performance of biological neural networks.

This reductionist approach is not the result of ignorance, but rather a **deliberate choice** to ignore the biological complexities underlying the behavior of natural neural systems. For example, after spending years studying the biological basis of intelligence, **Demis Hassabis** argues in [*Neuroscience-Inspired Artificial Intelligence*](https://www.cell.com/neuron/pdf/S0896-6273%2817%2930509-3.pdf) that the key is to work at the **right level of abstraction**, one that sits above the real neural substrate:

> From a practical perspective, we do not need to adhere strictly to biological plausibility in order to build AI systems. What works is ultimately what matters. Therefore, **biological plausibility is only a guide**, not a strict requirement. Our interest lies in an understanding **at the algorithmic and computational level** of the brain, leaving aside the level of biological implementation.

**Hassabis** explicitly refers to **David Marr's three levels of analysis**, and regards the lowest one, the physical mechanisms of the neural substrate, as less relevant:

> Our interest lies in the top two levels of the three levels of analysis that **Marr** proposed for understanding any complex biological system: the computational level, the goal of the system and the problem it solves, and the algorithmic level, the processes and algorithms that enable it to reach that goal. The implementation level, which deals with the specific **physical mechanisms**, **is less relevant** here.

## The rhythms of neurons

What seems less relevant to engineers and computer scientists is the everyday reality of neuroscience research. And the neuroscientific picture is completely different.

On the one hand, to **simulate the operation of a neuron in theory**, neuroscientists need complex differential equations that describe the temporal evolution of ion concentrations across cell membranes, including what happens at the synapses. Some connections reinforce the membrane potential, excitatory ones, while others inhibit it. Both types of interaction occur as part of **dynamic firing patterns** in networks of **thousands of connected neurons**. The outcome is a burst of firing, or **spikes**, from one neuron, which then become the input for many others.

![](4-Figure1-1.png)

Diagram of the temporal sequence of spikes entering a neuron and the output spike train produced by that neuron.

On the other hand, experimental advances have made it possible to observe neuronal activity directly, using techniques such as **microelectrodes**, which can record the activity of both large populations and individual neurons. These recordings have shown that neurons fire in precise temporal patterns, and that the **frequency** of those spikes can **encode information**. In neurons connected to muscles, for example, firing intensity can reflect the force required for a movement, while in other brain areas temporal patterns are associated with sensory or cognitive signals.

![](Pasted%20image%2020241218090922.png)

Temporal recording of individual neuron activity while a mouse moves along a 170 cm linear environment. Panel (G) shows spike trains from different neurons in relation to the mouse's position and speed. Each colored dot marks a firing event from a specific neuron. Panel (H) zooms in on 250 ms intervals and reveals precise temporal patterns and synchronization between neurons. This kind of activity reflects how biological neural networks organize information at precise temporal scales and exhibit rhythms that help integrate spatial and motor stimuli. György Buzsáki and Mihály Vöröslakos, [*"Brain rhythms have come of age"*](https://www.sciencedirect.com/science/article/pii/S0896627323002143), *Neuron*, April 2023.

The importance of **brain rhythms** is a growing area of interest in current neuroscience. Beyond individual firing patterns, researchers have identified **rhythmic oscillations** at frequencies such as theta, gamma, and delta that organize neural activity on broader temporal scales.

**Jeff Lichtman**, a leading Harvard neuroscientist and pioneer in connectome mapping, emphasized in a recent [*Mindscape* interview](https://www.preposterousuniverse.com/podcast/2024/12/09/298-jeff-lichtman-on-the-wiring-diagram-of-the-brain/) with **Sean Carroll** that although neuroscience has made huge strides in mapping neural connectivity, those maps cannot capture the **dynamic complexity** of the brain. As he puts it:

> Although it is possible to map the network of neural connections in great detail, those maps **do not reveal** the strength of synapses, the **nonlinearities** in cellular response, and especially the timing with which different stimuli activate a cell. There are excitatory and inhibitory inputs, as well as modulatory neurotransmitter inputs. All of that is latent in the wiring diagram, but inaccessible from it.

This temporal dimension is a physical phenomenon specific to biological neural networks, and deep-learning connectionist models cannot capture it. Its existence in the real brain suggests that it plays a fundamental role that we still do not fully understand. And, according to **Lichtman**, we do not yet understand the brain's complexity itself either:

> There are certain things in the world, and perhaps the brain is one of them, that may have no possible simplification. If there were, brains would have been simpler.

What are the brain's rhythmic oscillations for? What do they encode? How important are the different firing patterns of neurons?

In the next article we will return to these questions in more detail and I will present my favorite speculation: **consciousness** may be an emergent phenomenon of the oscillatory patterns of the brain. More specifically, **sentience** might be the result of firing patterns in biological neural networks, present in most **living beings with complex nervous systems**. Yet that capacity may remain **out of reach** for artificial systems based on algorithmic sequential processes, which by their very nature may never be able to have sensations.

---

See you next time.

[^1]: Their paper had only three references, one of them to **Russell's** *Principia Mathematica*. A young engineer in his early twenties like **Shannon**, fresh from a master's thesis, did not yet have the pedigree to appear next to those few giants.

[^2]: We have gone from the early multilayer ANN models of the 1980s, with dozens of neurons distributed across one or two layers, to tens of millions of neurons spread over roughly 100 layers in GPT-3 in the 2020s.
