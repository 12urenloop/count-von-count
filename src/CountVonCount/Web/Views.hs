{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -fno-warn-unused-do-bind #-}
module CountVonCount.Web.Views
    ( index
    , monitor
    , management
    ) where

import Control.Monad (forM_)

import Text.Blaze (Html, (!))
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A

import CountVonCount.Persistence
import CountVonCount.Types
import CountVonCount.Web.Helpers

template :: Html -> Html -> Html
template title content = H.docTypeHtml $ do
    H.head $ do
        H.title title
        javascript "/js/jquery-1.7.1.min.js"
        javascript "/js/jquery.flot.min.js"
        stylesheet "/css/screen.css"

    H.body $ do
        H.div ! A.id "header" $
            H.div ! A.id "navigation" $ do
                link_to "/monitor"    "Monitor"
                link_to "/management" "Management"
                link_to "/bonus"      "Bonus"

        H.div ! A.id "content" $
            content

        H.div ! A.id "footer" $ ""

index :: Html
index = template "Home" "Hello world"

monitor :: [Team] -> Html
monitor teams = template "Monitor" $ H.div ! A.id "monitor" $ do
    H.h1 "Scores"
    forM_ teams $ \team -> H.div ! A.class_ "team"
            !  H.dataAttribute "team-id" (H.toValue $ teamId team) $ do
        H.h2 $ H.toHtml $ teamName team
        H.div ! A.class_ "laps" $ H.toHtml $ teamLaps team
        H.div ! A.class_ "speed" $ ""
    javascript "/js/monitor.js"

management :: [(Ref Team, Team, Maybe Baton)] -> [Baton] -> Html
management teams batons = template "Teams" $ H.div ! A.id "management" $ do
    H.div ! A.id "secondary" $ do
        H.h1 "Free batons"
        forM_ batons $ \baton -> H.div ! A.class_ "baton" $ do
            H.toHtml $ batonName baton
            " ("
            H.toHtml $ batonMac baton
            ")"

    H.h1 "Teams"
    forM_ teams $ \(ref, team, assigned) -> H.div ! A.class_ "team" $ do
        let assignUri = "/team/" ++ refToString ref ++ "/assign"

        H.toHtml $ teamName team

        H.form ! A.action (H.toValue assignUri) ! A.method "post" $ do
            H.select ! A.name "baton" $ do
                case assigned of
                    Just baton ->
                        H.option ! A.value (macValue baton)
                                 ! A.selected "selected" $
                            H.toHtml (batonName baton)
                    _          ->
                        H.option ! A.value "" ! A.selected "selected" $ ""

                forM_ batons $ \baton ->
                    H.option ! A.value (macValue baton) $
                        H.toHtml (batonName baton)

            H.input ! A.type_ "submit" ! A.value "Assign"
  where
    macValue = H.toValue . batonMac
