import openai
import os
import time
from functools import wraps

# Set up OpenAI API key
openai.api_key = os.environ["OPENAI_API_KEY"]

CHARACTER = ''

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

def initialize_messages():
    messages = []
    messages.append(generate_message('system',CHARACTER))
    return messages


def main():
    messages = initialize_messages()

    # Start the conversation loop
    while True:
        # Get user input
        user_input = input("You >> ")
        # Add user input to the prompt
        messages.append(generate_message('user', user_input))
        # Generate response
        response = generate_response(messages)
        # print response
        print("AI >> " + response + "\n")
        # append to the messages
        messages.append(generate_message('assistant', response))
if __name__ == '__main__':
    ROLE_TXT_PATH = os.path.join(os.path.dirname(__file__), 'role.txt')
    with open(ROLE_TXT_PATH) as f:
        CHARACTER = f.read().strip()
    main()
