"""
3. Write a program that uses a dictionary to store information about a person, such as their name, age, and favorite color. Ask the user for input and store the information in the dictionary. Then, print the dictionary to the console.
"""

name = input("Enter Name: ")
age = input("Enter Age: ")
color = input("Enter Favourite Color: ")

personal_info = {"Name": name, "Age": age, "Color": color}

print(personal_info)
