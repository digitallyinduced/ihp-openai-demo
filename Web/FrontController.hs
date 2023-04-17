module Web.FrontController where

import IHP.RouterPrelude
import Web.Controller.Prelude
import Web.View.Layout (defaultLayout)

-- Controller Imports
import Web.Controller.Questions

instance FrontController WebApplication where
    controllers = 
        [ startPage QuestionsAction
        -- Generator Marker
        , parseRoute @QuestionsController
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
