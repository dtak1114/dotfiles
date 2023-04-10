import openai
import os
import time
from functools import wraps
import datetime

# Set up OpenAI API key
openai.api_key = os.environ["OPENAI_API_KEY"]

# write history to a file
HISTORY_FILE = "./.gpt_history"
HISTORY_LIMIT_BYTES = 1024 * 10

# Define model and other parameters
model = "gpt-3.5-turbo"
temperature = 0
#  max_tokens = 3000

def retry(max_retries, delay, backoff):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            retries = 0
            while retries < max_retries:
                try:
                    return func(*args, **kwargs)
                except Exception as e:
                    print(f"Exception: {e}. Retrying...")
                    time.sleep(delay)
                    delay *= backoff
                    retries += 1
            raise Exception(f"Max retries exceeded: {max_retries}")
        return wrapper
    return decorator

# Define function to generate response
@retry(max_retries=3, delay=2, backoff=2)
def generate_response(messages):
    # Call the API to generate the response
    response = openai.ChatCompletion.create(
        model=model,
        messages=messages,
        temperature=temperature,
    )
    # Extract the text from the response and return it
    return response.choices[0].message.content

def generate_message(role, content):
    return {
            'role': role,
            'content': content
    }

def initialize_messages(role):
    messages = []
    messages.append(generate_message('system',role))
    return messages


def main():
    ROLE_TXT_PATH = os.path.join(os.path.dirname(__file__), 'role.txt')
    with open(ROLE_TXT_PATH) as f:
        role = f.read().strip()
    messages = initialize_messages(role)

    start = datetime.datetime.now().strftime("%d/%m/%Y %H:%M:%S")

    write_output_and_trim("===start session on {} ===\n".format(start))
    # Start the conversation loop
    while True:
        # Get user input
        user_input = input("You >> ")
        write_output_and_trim("You >> " + user_input+ "\n")
        # Add user input to the prompt
        messages.append(generate_message('user', user_input))
        # Generate response
        response = generate_response(messages)
        # print response
        print("AI >> " + response + "\n")
        write_output_and_trim("AI >> " + response+ "\n")
        # append to the messages
        messages.append(generate_message('assistant', response))

def write_output_and_trim(output,filename=HISTORY_FILE,limit=HISTORY_LIMIT_BYTES):
    if not os.path.exists(filename):
        open('myfile.txt', 'w').close()
    with open(filename, 'a') as f:
        f.write(output)
    if os.path.getsize(filename) > limit:
        with open(filename, 'r') as f:
            lines = f.readlines()
        with open(filename, 'w') as f:
            f.writelines(lines[1:])

if __name__ == '__main__':
    main()
