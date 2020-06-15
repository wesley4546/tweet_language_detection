library(cld2)
library(stringr)
library(dplyr)

# Reads in the data
raw_twitter <- read.csv()


# This function takes in a tweet and returns "english" if its english and 
# "non-english" if its not.

check_for_english <- function(tweet) {

  # Cleans out any special characters
  cleaned_tweet <- str_replace_all(
    string = tweet,
    pattern = regex("[^a-zA-Z0-9]"),
    " "
  )

  # Detects the language
  langs_of_tweet <- detect_language_mixed(tweet)

  # Extracts only english
  english_result <- langs_of_tweet$classificaton %>%
    filter(language == "ENGLISH")
  
  # Extracts the proportions
  probablility_of_en <- english_result$proportion
  
  # Declares threshold
  probability_threshold <- 0.99
  
  # Determines if english
  if(probablility_of_en > probability_threshold){
    return("english")
  } else {
    return("non-english")
  }
  
}


# Example

new_dataframe <- 
  raw_twitter %>% 
  mutate(english = check_for_english(text))
