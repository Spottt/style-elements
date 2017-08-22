module Form exposing (..)

import Color
import Element exposing (..)
import Element.Attributes exposing (..)
import Element.Events
import Element.Input as Input
import Html
import Style exposing (..)
import Style.Background as Background
import Style.Border as Border
import Style.Color as Color
import Style.Font as Font
import Style.Shadow as Shadow
import Style.Transition as Transition


(=>) =
    (,)


type Styles
    = None
    | Main
    | Page
    | Box
    | Container
    | Label
    | Blue
    | BlackText
    | Crazy Other
    | Yellow
    | Grey


type Other
    = Thing Int


options =
    [ Style.unguarded
    ]


stylesheet : StyleSheet Styles variation
stylesheet =
    Style.styleSheet
        [ style None []
        , style Main
            [ Border.all 1
            , Color.text Color.darkCharcoal
            , Color.background Color.white
            , Color.border Color.lightGrey
            , Font.typeface
                [ Font.font "helvetica"
                , Font.font "arial"
                , Font.font "sans-serif"
                ]
            , Font.size 16
            , Font.lineHeight 1.3
            ]
        , style Page
            [ Border.rounded 5
            , Border.all 5
            , Border.solid
            , Color.text Color.darkCharcoal
            , Color.background Color.white
            , Color.border Color.lightGrey
            ]
        , style Label
            [ Font.size 25
            , Font.center
            ]
        , style Blue
            [ Color.text Color.white
            , Color.background Color.blue
            , Font.center
            ]
        , style Yellow
            [ Color.text Color.white
            , Color.background Color.yellow
            , Font.center
            ]
        , style Grey
            [ Color.text Color.white
            , Color.background Color.grey
            , Font.center
            ]
        , style BlackText
            [ Color.text Color.black
            ]
        , style Box
            [ Transition.all
            , Color.text Color.white
            , Color.background Color.blue
            , Color.border Color.blue
            , Border.rounded 3
            , hover
                [ Color.text Color.white
                , Color.background Color.red
                , Color.border Color.red
                , cursor "pointer"
                ]
            ]
        , style Container
            [ Color.text Color.black
            , Color.background Color.lightGrey
            , Color.border Color.lightGrey
            , hover
                [ Color.background Color.grey
                , Color.border Color.grey
                , cursor "pointer"
                ]
            ]
        , style
            (Crazy
                (Thing 5)
            )
            []
        ]


main =
    Html.program
        { init =
            ( { checkbox = False
              , lunch = Taco
              , text = "hi"
              }
            , Cmd.none
            )
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }


type Msg
    = Log String
    | Check Bool
    | ChooseLunch Lunch
    | ChangeText String


update msg model =
    case Debug.log "action" msg of
        Log str ->
            let
                _ =
                    Debug.log "form" str
            in
                ( model, Cmd.none )

        Check checkbox ->
            ( { model | checkbox = checkbox }
            , Cmd.none
            )

        ChooseLunch lunch ->
            ( { model | lunch = lunch }
            , Cmd.none
            )

        ChangeText str ->
            ( { model | text = str }
            , Cmd.none
            )


type Lunch
    = Taco
    | Burrito
    | Gyro


view model =
    Element.layout stylesheet <|
        el None [ center, width (px 800) ] <|
            column Main
                [ spacing 20 ]
                [ Input.label None [] (text "hello!") <|
                    Input.checkbox
                        { onChange = Check
                        , checked = model.checkbox
                        }
                , Input.label None [] (text "hello!") <|
                    Input.checkboxWith
                        { onChange = Check
                        , checked = model.checkbox
                        , icon =
                            \on ->
                                circle 7
                                    (if on then
                                        Blue
                                     else
                                        Grey
                                    )
                                    []
                                    empty
                        }
                , Input.label None [] (text "Lunch!") <|
                    Input.radio Container
                        [ padding 40
                        , spacing 5
                        , height (px 200)
                        ]
                        { onChange = ChooseLunch
                        , selected = Just model.lunch
                        , options =
                            [ Input.optionWith Burrito
                                (\selected ->
                                    let
                                        icon =
                                            if selected then
                                                text ":D"
                                            else
                                                text ":("
                                    in
                                        row None
                                            [ spacing 5 ]
                                            [ icon, text "burrito" ]
                                )
                            , Input.option Taco (text "Taco!")
                            , Input.option Gyro (text "Gyro")
                            ]
                        }
                , Input.label None [] (text "Lunch") <|
                    Input.radioRow Container
                        [ padding 40, spacing 20 ]
                        { onChange = ChooseLunch
                        , selected = Just model.lunch
                        , options =
                            [ Input.option Taco (text "Taco!")
                            , Input.option Gyro (text "Gyro")
                            , Input.optionWith Burrito
                                (\selected ->
                                    let
                                        icon =
                                            if selected then
                                                text ":D"
                                            else
                                                text ":("
                                    in
                                        row None
                                            [ spacing 5 ]
                                            [ icon, text "burrito" ]
                                )
                            ]
                        }
                , Input.label None [] (text "A Greeting") <|
                    Input.text None
                        []
                        { onChange = ChangeText
                        , value = model.text
                        }
                , Input.label None [] (text "A Greeting") <|
                    Input.multiline None
                        []
                        { onChange = ChangeText
                        , value = model.text
                        }
                , Input.label None [] (text "A Greeting") <|
                    Input.search None
                        []
                        { onChange = ChangeText
                        , value = model.text
                        }
                , Input.label None [] (text "My super password") <|
                    Input.password None
                        []
                        { onChange = ChangeText
                        , value = model.text
                        }
                ]