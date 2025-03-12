"""
5. Create a program that stores a list of words. Then, use list comprehension to create a new list that contains only the words that have an odd number of characters.
"""

words = [
    "python",
    "developer",
    "matrix",
    "algorithm",
    "syntax",
    "variable",
    "function",
    "parameter",
    "integer",
    "recursion",
    "debugging",
    "compiler",
    "inheritance",
    "iteration",
    "exception",
    "library",
    "framework",
    "optimization",
    "paradigm",
    "database",
]

odd_words = [word for word in words if len(word) % 2 != 0]

print(odd_words)
