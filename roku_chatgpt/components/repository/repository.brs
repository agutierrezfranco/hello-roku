sub init()
    print "DEBUG: init() - repository"
    m.appInfo = createObject("roAppInfo")
    m.httpTask = createObject("roSGNode", "httpTask")
    m.httpTask.control = "run"
end sub

sub fetchTest(request as object)
    url = urlMapper("test")
    request.addReplace("url", url)
    request.addReplace("modelType", "baseModel")
    enqueue(request)
end sub

sub fetchChatGPT(request as object)
    url = urlMapper("chat")
    headers = setHeaders()

    request.addReplace("url", url)
    request.addReplace("headers", headers)
    request.addReplace("modelType", "chatModel")
    enqueue(request)
end sub

sub enqueue(request as object)
    m.httpTask.request = request
end sub

function urlMapper(key as string)
    urls = { 
        test : "https://jonathanbduval.com/roku/feeds/roku-developers-feed-v1.json" 
        chat: "https://api.openai.com/v1/chat/completions"
    }
    if urls.doesExist(key) then
        return urls[key]
    end if
end function

function setHeaders()
    apiKey = m.appInfo.getValue("api_key")
    authorization = substitute("{0} {1}", "Bearer", apiKey)
    headers = {
        "content-type": "application/json",
        "authorization": authorization
    }
    return headers
end function