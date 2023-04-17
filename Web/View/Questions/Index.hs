module Web.View.Questions.Index where
import Web.View.Prelude

data IndexView = IndexView { questions :: [Question]  }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <h1>Questions & Answers<a href={pathTo NewQuestionAction} class="btn btn-primary ms-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Question</th>
                        <th>Answer</th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach questions renderQuestion}</tbody>
            </table>
            
        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Questions" QuestionsAction
                ]

renderQuestion :: Question -> Html
renderQuestion question = [hsx|
    <tr>
        <td>{question.question}</td>
        <td>
            {question.answer |> nl2br}
        </td>
        <td><a href={DeleteQuestionAction question.id} class="js-delete text-muted">Delete</a></td>
    </tr>
|]