"""
3.Random Joke Generator 🤣
-Build a program that stores a list of jokes and randomly selects one to display every time the user runs it. Add a fun twist with jokes about Python or programming! 🐍💡
"""

import random

jokes = [
    "Why did the programmer go broke? \n→ Because he used up all his cache! 💸",
    "Why don’t Kenyans walk to work? \n→ Because by the time you reach, you’ll have sweated enough to need another shower! 😅",
    "What’s a programmer’s favorite place to hang out? \n→ The Foo Bar. 🍻",
    "Why did the Python programmer break up with Java? \n→ Because she didn’t like his class! 🤯",
    "Why did the developer go to therapy? \n→ He had too many unresolved dependencies. 😆",
    "What did the Python say when it was asked to lower the volume? \n→ \"I can't, I'm immutable!\" 🔇",
    "Why don’t skeletons fight each other? \n→ They don’t have the guts. 💀",
    "Why do Python programmers prefer dark mode? \n→ Because light attracts bugs! 🐞",
    "Why do Kenyans eat ugali with everything? \n→ Because rice is too soft to be taken seriously! 😂🍛",
    "Why don’t some couples go to the gym? \n→ Because some relationships don’t work out. 💪",
    "Why do you fear your mothers more than the police? \n→ Because your mother’s slipper has Bluetooth precision! 🥿🎯",
    "What do you call fake spaghetti? \n→ An impasta! 🍝",
    "Why do Java developers wear glasses? \n→ Because they can't C#! 👓",
    "Why don’t programmers like nature? \n→ Too many bugs. 🌲🐛",
    "Why did the scarecrow win an award? \n→ Because he was outstanding in his field! 🌾",
]

get_random_joke = random.choice(jokes)
print(get_random_joke)
