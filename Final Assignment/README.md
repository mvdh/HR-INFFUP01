# Final Assignment

    Build an application that prompts words that can be layed down on a Wordfeud board, based on the users's tiles (disposal) and a prefix and/or suffix.

## The algorithm

The application first reads a file with words into a list.
Then is asks the user for the disposal (users's tiles), the prefix and the suffix (prefix and suffix can be blank).
The app starts filtering the word list, based on a few predicates:

- Does it the word match the prefix and/or suffix?
- Can the body be composed of the tiles (letters) on the disposal? The body is the word without the prefix and suffix

The app returns all the words that satisfy the aforementioned predicates.