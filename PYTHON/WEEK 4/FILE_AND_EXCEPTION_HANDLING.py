def main():

    try:
        input_file = input("Enter File Name: ")
        with open(input_file, "r") as file:
            content = file.read()

        modified_content = content.upper()

        output_file = "modified_" + input_file
        with open(output_file, "w") as file:
            file.write(modified_content)
        print(f"File '{input_file}' has been modified and saved as '{output_file}'.")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
    finally:
        print("Execution completed.")


main()
