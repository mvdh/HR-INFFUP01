#Final Assignment

The final assignment is to build an application (a function) that gives suggestions for words that can be layed down on a Wordfeud board, based on the users's tiles (disposal) and a prefix and/or suffix.

##The algorithm

The application first reads a file with words into a list.
Then is asks the user for the disposal (users's tiles), the prefix and the suffix (prefix and suffix can be blank).
The app then starts looking for word suggestions:

- it checks if a word matches the prefix and/or suffix
- if so, it checks if the body can be composed of the letters on the disposal (body = word without the prefix and suffix)
- if so this word is a suggestion

The app returns all the suggestions after processing the complete word list.