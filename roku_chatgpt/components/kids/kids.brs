sub init()
    m.appColors = getAppColors()

    m.KidsCustomKeyboard = m.top.findNode("KidsCustomKeyboard")
    m.KidsCustomKeyboard.translation = [200, 750]
    m.KidsCustomKeyboard.text = ""
    m.KidsCustomKeyboard.observeField("text", "onTextChange")

    m.RectangleKids1 = m.top.findNode("RectangleKids1")
    m.RectangleKids1.color = m.appColors.BACKGROUND_COLOR
    m.RectangleKids1.width = 1920
    m.RectangleKids1.height = 1080
    m.RectangleKids1.translation = [0, 0]

    m.RectangleKids2 = m.top.findNode("RectangleKids2")
    m.RectangleKids2.color = m.appColors.YELLOW
    m.RectangleKids2.width = 1200
    m.RectangleKids2.height = 980
    m.RectangleKids2.translation = [360, 50]

    m.RectangleKids3 = m.top.findNode("RectangleKids3")
    m.RectangleKids3.color = m.appColors.PINK
    m.RectangleKids3.width = 400
    m.RectangleKids3.height = 100
    m.RectangleKids3.translation = [200, -40]

    m.RectangleKids4 = m.top.findNode("RectangleKids4")
    m.RectangleKids4.color = m.appColors.WHITE
    m.RectangleKids4.width = 800
    m.RectangleKids4.height = 600
    m.RectangleKids4.translation = [200, 100]
    
    m.AnswerKids = m.top.findNode("AnswerKids")
    m.AnswerKids.color = m.appColors.BACKGROUND_COLOR
    m.AnswerKids.font = "font:MediumBoldSystemFont"

    m.SimpleLabelKids = m.top.findNode("SimpleLabelKids")
    m.SimpleLabelKids.color = m.appColors.WHITE
    m.SimpleLabelKids.translation = [90, 30]
    m.SimpleLabelKids.fontUri = "font:MediumBoldSystemFont"
    m.SimpleLabelKids.text = "ASK PBS KIDS"
end sub   

sub onTextChange(event as object)
    m.AnswerKids.text = "Generating..."

    text = event.getData()
    httpNode = createObject("roSGNode", "httpNode")
    httpNode.observeField("response", "onHttpResponse")
    request = {
        httpNode: httpNode,
        method: "POST",
        headers: {
            "content-type": "application/json",
            "authorization": "Bearer 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"
        }
        body: {
            "model": "gpt-3.5-turbo",
            "messages": [
                {
                    "role": "user",
                    "content": text
                }
            ]
        }
    }

    repository = m.top.getScene().repository
    repository.callFunc("fetchChatGPT", request)
end sub

sub onHttpResponse(event as object)
    response = event.getData()
    print "DEBUG: Kids - ", response
    if response.data <> invalid
        items = response.data.items
        message = items[0].message
    else
        message = "OOPS! PBS Chat is currently unavailable."
    end if
    updateAnswerLabel(message)
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if key = "OK" and m.KidsCustomKeyboard.text.len() > 1 
        ' updateQuestionLabel(m.KidsCustomKeyboard.text)
        return true
    end if
end function

function updateQuestionLabel(label as string)
    m.QuestionKids = m.top.findNode("QuestionKids")
    m.QuestionKids.text = ""
    m.QuestionKids.text = label
    m.QuestionKids.color = m.appColors.PINK
    m.QuestionKids.fontUri = "font:MediumBoldSystemFont"
    print "DEBUG: Kids - ", label
    updateAnswerLabel()
end function    

function updateAnswerLabel(text = "" as string)
    m.AnswerKids.text = text
    print "DEBUG: Kids - ", text
end function
