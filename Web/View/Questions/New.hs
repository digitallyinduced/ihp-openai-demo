module Web.View.Questions.New where
import Web.View.Prelude

data NewView = NewView { question :: Question }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Question</h1>
        {renderForm question}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Questions" QuestionsAction
                , breadcrumbText "New Question"
                ]

renderForm :: Question -> Html
renderForm question = formFor question [hsx|
    {textField #question}
    {submitButton}

|]