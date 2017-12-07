-- Main.elm
module Main exposing (..)
import Html
import Model.Model exposing (..)
import Subscriptions.Subscriptions as Subscriptions
import Update.Update as Update
import View.View as View

main : Program Never Model Msg
main =
    Html.program
        { init = Model.init                
        , view = View.view
        , update = Update.update
        , subscriptions = Subscriptions.subscriptions
        }