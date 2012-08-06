import Data.Char
import Data.List
import Data.Maybe

--------------------------------
------ How the application works
--------------------------------

{-
	ALGORITHM:
		1. It first reads the file with words into a list of words
		2. Then it askes the user for his/her:
			- disposal (user's letters), 
			- the prefix,
			- and the suffix (prefix and suffix may be blank)
		3. Then the app starts searching suggestions:
			for every word in the wordlist:
			- it checks if a word matches the prefix and/or suffix
			- if so, it checks if the body can be composed of the letters on the disposal
				(body = word without the prefix and suffix)
			- if so this word is a suggestion
		4. After processing the word list the app return all the suggestions and prints them
	
	
	NOTES:
		1. The param 'wL' is often used and is an abbrevation of 'wordList'
		2. The param 'w' is often used and is an abbrevation of 'word'
		3. The global variable 'path' for the word list file might be updated to run this program
		
		
	OPTIMIZATIONS:
		1. Characters in the word list that are not in [a..z] must be replaced/stripped
-}	
	
	
---------------
------ WordFeud
---------------


-- Find all word suggestions
wordSuggestions :: [String] -> [(Char, Int)] -> String -> String -> [String]
wordSuggestions wL disposal prefix suffix  = [ w | w <- wL, isSuggestion w disposal prefix suffix ]


-- Check if a word is a suggestion
isSuggestion :: String -> [(Char, Int)] -> String -> String -> Bool
isSuggestion w disposal prefix suffix 
	| 	isPrefixOf prefix w && 
		isSuffixOf suffix w && 
		canMakeBody (body w (length prefix) (length suffix)) disposal = True
	| otherwise = False

	
-- Check if the user has the chars to make the body (= word without prefix and suffix)
canMakeBody :: String -> [(Char, Int)] -> Bool
canMakeBody [] _ = False -- No body, so useless to check
canMakeBody _ [] = False -- No letters on disposal, so body cannot be made
canMakeBody b disposal = and [(charOnDisposal charCount disposal) | charCount <- (countAll b)]


-- Checks if the disposal has (enough of) a char
charOnDisposal :: (Char, Int) -> [(Char, Int)] -> Bool
charOnDisposal charCount disposal
	| disposalCharCount >= snd charCount = True
	| otherwise = False 
		where disposalCharCount = fromMaybe 0 (lookup (fst charCount) disposal)	
		
		
------------
------ Utils
------------


-- Count the occurences of all different values in a list
-- Example: "abab" results in [('a', 2), ('b', 2)]
countAll :: Ord a => [a] -> [(a, Int)]
countAll [] = []
countAll x =  [(head(y), length y) | y <- (group(sort x))]


-- Lower case a word list
wordListToLower :: [String] -> [String]
wordListToLower wL = map (map toLower) wL


-- Strip prefix and suffix from a list (by length)
body :: String -> Int -> Int -> String
body w lPrefix lSuffix = drop lPrefix (take (length w - lSuffix) w)


-------------------
------ Application
-------------------

-- The path to the file with words 
path = "vocab-nl.txt"

-- Read the words of the word file into a list
getWords :: IO [String]
getWords = do
	contents <- readFile path
	return (lines contents)
	
-- The application starts here	
main = do
	wL <- getWords
	putStrLn "Welke letters heb je tot je beschikking?"
	disposal <- getLine
	putStrLn "Wat is de prefix?"
	prefix <- getLine
	putStrLn "Wat is de suffix?"
	suffix <- getLine
	mapM_ putStrLn (wordSuggestions (wordListToLower wL) (countAll disposal) prefix suffix)
