# Assignment 1: Design Your Own Class 🏗️
class Superhero:
    def __init__(self, name, power, universe):
        self.name = name
        self.power = power
        self.universe = universe

    def introduce(self):
        return f"I am {self.name} from {self.universe}, and I can {self.power}!"

# Inheritance layer
class Villain(Superhero):
    def __init__(self, name, power, universe, evil_plan):
        super().__init__(name, power, universe)
        self.evil_plan = evil_plan

    def introduce(self):
        return f"I am {self.name}, the villain from {self.universe}. My evil plan is: {self.evil_plan}."

# Example usage
hero = Superhero("Flash", "run at light speed", "DC")
villain = Villain("Zoom", "manipulate time", "DC", "destroy the multiverse")

print(hero.introduce())
print(villain.introduce())

# Activity 2: Polymorphism Challenge 🎭
class Vehicle:
    def move(self):
        pass

class Car(Vehicle):
    def move(self):
        print("Driving 🚗")

class Plane(Vehicle):
    def move(self):
        print("Flying ✈️")

class Boat(Vehicle):
    def move(self):
        print("Sailing 🚤")

# Example usage
vehicles = [Car(), Plane(), Boat()]
for v in vehicles:
    v.move()
