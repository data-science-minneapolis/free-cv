library(tidyverse)
library(ggplot2)
library(caret)

direc <- 'C://Users//Owner//Documents//Kaggle-Competition-for-good//'

files <- list.files('C://Users//Owner//Documents//Kaggle-Competition-for-good')

direc.files <- paste(direc, files, sep = '')

l <- list()
for(i in 1:length(direc.files)){
  l[[i]] <- read.csv(direc.files[i], stringsAsFactors = FALSE)
}

names(l) <- c('answers_scores', 'answers', 'comments', 'emails',
              'group_memberships', 'groups',
              'matches', 'professionals', 'question_scores',
              'questions', 'school_memberships',
              'students', 'tag_questions',
              'tag_users','tags')

# Not sure about missing pieces
answers <- inner_join(l$answers, l$answers_scores, by = c('answers_id' = 'id'))

# Join the answers to the professionals, 10169 professionals answered questions out of 28152
pro.ans <- inner_join(answers, l$professionals, by = c('answers_author_id' = 'professionals_id'))


# Form Questions to students dataset --------------------------------------------------

ques <- inner_join(l$questions, l$question_scores, by = c('questions_id' = 'id'))

stud.ques <- inner_join(ques, l$students, by = c('questions_author_id' = 'students_id'))

# Prepare to join answers to questions ------------------------------------

dat <-left_join(pro.ans, stud.ques, by = c('answers_question_id' = 'questions_id'))

# Clean 

