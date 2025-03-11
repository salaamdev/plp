"""
Basic Calculator Program

Create a simple Python program that asks the user to input two numbers and a mathematical operation (addition, subtraction, multiplication, or division).
Perform the operation based on the user's input and print the result.
Example: If a user inputs 10, 5, and +, your program should display 10 + 5 = 15.
"""


def calculator():
    while True:
        try:
            first_number = int(input("Enter First Number: "))
            operator = input("Enter Operator: ")
            second_number = int(input("Enter Second Number: "))

            if operator == "+":
                return first_number + second_number
            elif operator == "-":
                return first_number - second_number
            elif operator == "*":
                return first_number * second_number
            elif operator == "/":
                if second_number == 0:
                    print("Can not divide by zero")
                    continue
                return first_number / second_number
            else:
                return "Invalid Choice"
        except ValueError:
            print("Invalid input! Please enter numeric values for the numbers.")


print("Result: ", calculator())
