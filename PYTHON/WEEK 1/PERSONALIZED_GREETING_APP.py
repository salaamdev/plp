"""
1.Personalized Greeting App 👋

- Create a program that asks for the user’s name and favorite color, then prints a personalized greeting like: “Hello, [Name]! Your favorite color, [Color], is awesome!”```
"""


def greetings():
    name = input("Enter Name: ")
    color = input("Enter Color: ")
    return f"Hello, {name}! Your favorite color, {color}, is awesome!"


print(greetings())
