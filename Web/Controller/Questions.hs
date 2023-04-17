module Web.Controller.Questions where

import Web.Controller.Prelude
import Web.View.Questions.Index
import Web.View.Questions.New

import qualified IHP.OpenAI as GPT

instance Controller QuestionsController where
    action QuestionsAction = autoRefresh do
        questions <- query @Question
            |> orderByDesc #createdAt
            |> fetch
        render IndexView { .. }

    action NewQuestionAction = do
        let question = newRecord
                |> set #question "What makes haskell so great?"
        render NewView { .. }

    action CreateQuestionAction = do
        let question = newRecord @Question
        question
            |> fill @'["question"]
            |> validateField #question nonEmpty
            |> ifValid \case
                Left question -> render NewView { .. } 
                Right question -> do
                    question <- question |> createRecord
                    setSuccessMessage "Question created"

                    fillAnswer question

                    redirectTo QuestionsAction

    action DeleteQuestionAction { questionId } = do
        question <- fetch questionId
        deleteRecord question
        setSuccessMessage "Question deleted"
        redirectTo QuestionsAction

fillAnswer :: (?modelContext :: ModelContext) => Question -> IO (Async ())
fillAnswer question = do
    -- Put your OpenAI secret key below:
    let secretKey = "sk-XXXXXXXX"

    -- This should be done with an IHP job worker instead of async
    async do 
        GPT.streamCompletion secretKey (buildCompletionRequest question) (clearAnswer question) (appendToken question)
        pure ()

buildCompletionRequest :: Question -> GPT.CompletionRequest
buildCompletionRequest Question { question } =
    -- Here you can adjust the parameters of the request
    GPT.newCompletionRequest
        { GPT.maxTokens = 512
        , GPT.prompt = [trimming|
                Question: ${question}
                Answer:
        |] }

-- | Sets the answer field back to an empty string
clearAnswer :: (?modelContext :: ModelContext) => Question -> IO ()
clearAnswer question = do
    sqlExec "UPDATE questions SET answer = '' WHERE id = ?" (Only question.id)
    pure ()

-- | Stores a couple of newly received characters to the database
appendToken :: (?modelContext :: ModelContext) => Question -> Text -> IO ()
appendToken question token = do
    sqlExec "UPDATE questions SET answer = answer || ? WHERE id = ?" (token, question.id)
    pure ()
