module Settings where

import qualified Conduit.Model as Model
import Control.Monad (forM_)
import Data.Proxy
import Data.Text
import Lucid
import Lucid.Htmx
import Lucid.Htmx.Servant
import Lucid.Hyperscript (useHyperscript, __, _hs)
import Servant
import Servant.Auth
import Servant.Auth.Server
import Servant.HTML.Lucid (HTML)
import Servant.Htmx
import Servant.Links
import Servant.Server

data Settings = Settings Model.User

instance ToHtml Settings where
  toHtml (Settings (Model.User bio email userID imageUrl username)) =
    div_ [class_ "settings-page"] $
      div_ [class_ "container page"] $
        div_ [class_ "row"] $
          div_ [class_ "col-md-6 offset-md-3 col-xs-12"] $ do
            h1_ [class_ "text-xs-center"] "Your Settings"
            form_ $ do
              fieldset_ $ do
                fieldset_ [class_ "form-group"] $
                  input_
                    [ class_ "form-control",
                      type_ "text",
                      placeholder_ "URL of profile picture",
                      value_ imageUrl
                    ]
                fieldset_ [class_ "form-group"] $
                  input_
                    [ class_ "form-control form-control-lg",
                      type_ "text",
                      placeholder_ "Your Name",
                      value_ username
                    ]
                fieldset_ [class_ "form-group"] $
                  textarea_
                    [ class_ "form-control form-control-lg",
                      rows_ "8",
                      placeholder_ "Short bio about you"
                    ]
                    $ toHtml bio
                fieldset_ [class_ "form-group"] $
                  input_
                    [ class_ "form-control form-control-lg",
                      type_ "text",
                      placeholder_ "Email",
                      value_ email
                    ]
                fieldset_ [class_ "form-group"] $
                  input_
                    [ class_ "form-control form-control-lg",
                      type_ "password",
                      placeholder_ "New Password"
                    ]
                button_ [class_ "btn btn-lg btn-primary pull-xs-right"] "Update Settings"
              hr_ []
              button_ [class_ "btn btn-outline-danger", hxPostSafe_ logoutLink, hxTarget_ "#content-slot"] $ "Or click here to logout."
  toHtmlRaw = toHtml