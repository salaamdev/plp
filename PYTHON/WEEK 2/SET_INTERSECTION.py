"""
4. Write a program that accepts user input to create two sets of integers. Then, create a new set that contains only the elements that are common to both sets.
"""


def set_intersection():
    set1 = set()
    set2 = set()
    user_input_1 = input(
        "Enter Integer Numbers Seperated By Comma (e.g 3,49,239)"
    ).split(",")
    user_input_2 = input(
        "Enter Second Integer Numbers Seperated By Comma (e.g 3,49,239)"
    ).split(",")

    for item in user_input_1:
        try:
            set1.add(int(item))
        except:
            print("Error")

    for item in user_input_2:
        try:
            set2.add(int(item))
        except:
            print("Error")

    return set1 & set2


print(set_intersection())
