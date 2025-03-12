"""
1. Create an empty list called my_list.
2. Append the following elements to my_list: 10, 20, 30, 40.
3. Insert the value 15 at the second position in the list.
4. Extend my_list with another list: [50, 60, 70].
5. Remove the last element from my_list.
6. Sort my_list in ascending order.
7. Find and print the index of the value 30 in my_list.
"""

my_list = []
print(my_list)
my_list += [10, 20, 30, 40]
print(my_list)
my_list.insert(1, 15)
print(my_list)

another_list = [50, 60, 70]
print(another_list)
my_list.extend(another_list)
print(my_list)
del my_list[-1]
print(my_list)
my_list.sort()
print(my_list)
print(my_list.index(30))
