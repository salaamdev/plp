"""
1. Create a file called input.txt and write at least five lines of text into it.
2. Write a Python script to:
    - Read the contents of input.txt.
    - Count the number of words in the file.
    - Convert all text to uppercase.
    - Write the processed text and the word count to a new file called output.txt.
3. Print a success message once the new file is created.
"""

with open("input.txt", "w") as file:
    file.writelines(
        [
            "This is the first line.\n",
            "Here is the second line.\n",
            "And this is the third line.\n",
            "Fourth line is here.\n",
            "Finally, the fifth line.\n",
        ]
    )

with open("input.txt", "r") as file:
    content = file.read()
    word_count = len(content.split())
    upper_Cased = content.upper()
with open("output.txt", "w") as file:
    file.write(f"Word Count: {word_count}\n")
    file.write(f"Upper Case:\n{upper_Cased}\n")
print("File created successfully.")
