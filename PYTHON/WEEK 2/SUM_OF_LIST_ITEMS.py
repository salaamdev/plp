"""
1. Write a program that accepts user input to create a list of integers. Then, compute the sum of all the integers in the list.
"""


def sum_list_integers():

    while True:
        user_input_list = (
            input("Enter Numbers Seperated By Comma (e.g 1,23,45): ").strip().split(",")
        )

        try:
            total_sum = 0
            for number in user_input_list:
                total_sum += int(number)
            return total_sum

        except ValueError:
            print("Use integers only (e.g 1,23,45). Separated By Comma (,)")


print("total sum:", sum_list_integers())
