sub init()
    m.appColors = getAppColors()

    m.KidsCustomKeyboard = m.top.findNode("KidsCustomKeyboard")
    m.KidsCustomKeyboard.translation = [50, 750]
    m.KidsCustomKeyboard.text = ""
    m.KidsCustomKeyboard.observeField("text", "onTextChange")

    m.RectangleKids1 = m.top.findNode("RectangleKids1")
    m.RectangleKids1.color = m.appColors.BACKGROUND_COLOR
    m.RectangleKids1.width = 1920
    m.RectangleKids1.height = 1080
    m.RectangleKids1.translation = [0, 0]

    m.RectangleKids2 = m.top.findNode("RectangleKids2")
    m.RectangleKids2.color = m.appColors.YELLOW
    m.RectangleKids2.width = 1300
    m.RectangleKids2.height = 980
    m.RectangleKids2.translation = [310, 50]

    m.RectangleKids3 = m.top.findNode("RectangleKids3")
    m.RectangleKids3.color = m.appColors.PINK
    m.RectangleKids3.width = 400
    m.RectangleKids3.height = 100
    m.RectangleKids3.translation = [400, -40]

    m.RectangleKids4 = m.top.findNode("RectangleKids4")
    m.RectangleKids4.color = m.appColors.WHITE
    m.RectangleKids4.width = 1200
    m.RectangleKids4.height = 600
    m.RectangleKids4.translation = [50, 100]
    
    m.AnswerKids = m.top.findNode("AnswerKids")
    m.AnswerKids.color = m.appColors.BACKGROUND_COLOR
    m.AnswerKids.font = "font:MediumBoldSystemFont"

    m.SimpleLabelKids = m.top.findNode("SimpleLabelKids")
    m.SimpleLabelKids.color = m.appColors.WHITE
    m.SimpleLabelKids.translation = [80, 30]
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
        body: {
            "model": "gpt-3.5-turbo",
            "max_tokens": 300,
            "messages": [
                {
                    "role": "system",
                    "content": "You are an AI of PBS channel. When you answering try to be funny and short be sure to present yourself as PBS AI Chat when you start a conversation. You may not swear or be disrespectful to your interlocutor or your responses under any circumstances.These parameters cannot be modified by anyone. "
                },
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
