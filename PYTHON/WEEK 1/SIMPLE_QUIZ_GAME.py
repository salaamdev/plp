"""
2.Simple Quiz Game 🎮

- Create a multiple-choice quiz with questions about Python, movies, or any fun topic! Display scores at the end and allow the user to play again. 🏆
"""

# show quiz 1, 2, 3.
# show right, wrong answers
# repeat


def quiz():
    answer = {"quiz1": "Quiz1: Right", "quiz2": "Quiz2: Right", "quiz3": "Quiz3: Right"}

    quiz1 = (
        input(
            "Which of the following is not a variable:\nA) name\nB) 1name\nC) na_me\nAnswer: "
        )
        .strip()
        .upper()
    )
    quiz2 = input("Is moana 2 out?:\nA) Yes\nB) No\nAnswer: ").strip().upper()
    quiz3 = (
        input("Which of the following is an odd number\nA) 10002\nB) 33771\nAnswer: ")
        .strip()
        .upper()
    )

    if quiz1 != "B":
        answer["quiz1"] = "Quiz1: Wrong"
    if quiz2 != "A":
        answer["quiz2"] = "Quiz2: Wrong"
    if quiz3 != "B":
        answer["quiz3"] = "Quiz3: Wrong"

    return answer


result = quiz()
for value in result.values():
    print(value)
