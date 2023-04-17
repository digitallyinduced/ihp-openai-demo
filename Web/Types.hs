module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types

data WebApplication = WebApplication deriving (Eq, Show)

data QuestionsController
    = QuestionsAction
    | NewQuestionAction
    | CreateQuestionAction
    | DeleteQuestionAction { questionId :: !(Id Question) }
    deriving (Eq, Show, Data)
