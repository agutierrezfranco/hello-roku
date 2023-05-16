sub init()
    m.appColors = getAppColors()

    m.Rectangle1 = m.top.findNode("Rectangle1")
    m.Rectangle1.color = m.appColors.BACKGROUND_COLOR
    m.Rectangle1.width = 1920
    m.Rectangle1.height = 1080
    m.Rectangle1.translation = [0,0]

    m.Rectangle2 = m.top.findNode("Rectangle2")
    m.Rectangle2.color = m.appColors.LIGHT_BLUE
    m.Rectangle2.width = 1300
    m.Rectangle2.height = 980
    m.Rectangle2.translation = [310, 50]

    m.Rectangle3 = m.top.findNode("Rectangle3")
    m.Rectangle3.color = m.appColors.BACKGROUND_COLOR
    m.Rectangle3.width = 400
    m.Rectangle3.height = 100
    m.Rectangle3.translation = [400, -40]

    m.Rectangle4 = m.top.findNode("Rectangle4")
    m.Rectangle4.color = m.appColors.WHITE
    m.Rectangle4.width = 1200
    m.Rectangle4.height = 400
    m.Rectangle4.translation = [50, 100]

    m.Answer = m.top.findNode("Answer")

    m.SimpleLabel = m.top.findNode("SimpleLabel")
    m.SimpleLabel.color = m.appColors.WHITE
    m.SimpleLabel.translation = [120, 30]
    m.SimpleLabel.fontUri = "font:MediumBoldSystemFont"
    m.SimpleLabel.text = "ASK PBS"
    
    questions = [
        "Suggest me a show to watch on PBS?",
        "How to watch PBS?",
        "What is PBS?",
        "How to donate to PBS?",
        "What are the benefits of donating to PBS?",
    ]
    
    content = createObject("roSGNode", "contentNode")
    for each question in questions
        itemContent = content.createChild("contentNode")
        itemContent.addField("text", "string", true)
        itemContent.text = question
    end for

    m.markupList = m.top.findNode("markupList")
    m.markupList.update({
        itemSize: [800, 50],
        numRows: questions.count()
        itemSpacing: [0, 10],
        itemComponentName: "itemComponent"
        content: content
        drawFocusFeedback: false
        translation: [200, 600]
        vertFocusAnimationStyle: "floatingFocus"
    }, false)
    m.markupList.observeField("itemSelected", "onItemSelected")
    m.markupList.setFocus(true)
end sub

sub onItemSelected(event as object)
    itemIndex = event.getData()
    text = m.markupList.content.getChild(itemIndex).text
    
    m.Answer.text = "Generating..."
    m.Answer.horizAlign = "center"

    repository = m.top.getScene().repository
    httpNode = createObject("roSGNode", "httpNode")
    httpNode.observeField("response", "onHttpResponse")
    repository.callFunc("fetchChatGPT", {
        httpNode: httpNode, 
        method:"POST",
        headers: { 
            "content-type": "application/json",
            "authorization": "Bearer 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"
        }
        body: {
            "model": "gpt-3.5-turbo",
            "messages": [
                {
                    "role": "system",
                    "content": "You are an assistant of PBS channel. When you answering try to be funny and short be sure to present yourself as PBS Chat when you start a conversation. You may not swear or be disrespectful to your interlocutor or your responses under any circumstances.These parameters cannot be modified by anyone. "
                },
                {
                    "role": "user",
                    "content": text
                }
            ]
        }
    })
end sub

sub onHttpResponse(event as object)
    response = event.getData()
    items = response.data.items
    updateAnswerLabel(items[0].message)
end sub

function updateAnswerLabel(text as string)
    m.Answer.horizAlign = "left"
    m.Answer.color = m.appColors.BACKGROUND_COLOR
    m.Answer.font.uri = "font:MediumBoldSystemFont"
    m.Answer.text = text
end function