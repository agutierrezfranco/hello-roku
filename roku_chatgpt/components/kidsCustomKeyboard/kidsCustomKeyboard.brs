sub init()
    m.appColors = getAppColors()
    m.top.keyGrid.keyDefinitionUri = "pkg:/components/KidsCustomKeyboard/KidsCustomKeyboard.json"

    keyboardPalette = createObject("roSGNode", "RSGPalette")
    keyboardPalette.colors = {
        "KeyboardColor": m.appColors.PINK
        "PrimaryTextColor":m.appColors.YELLOW,
        "FocusColor":m.appColors.YELLOW,
        "FocusItemColor": m.appColors.PINK
    }
    m.top.keyGrid.palette = keyboardPalette   

    m.top.textEditBox.voiceEnabled = true
    m.top.textEditBox.clearOnDownKey = true
    m.top.textEditBox.hintText = "Please, select one topic"

    'TextEditBox UI"
    m.top.textEditBox.hintTextColor = m.appColors.PINK
    m.top.textEditBox.textColor = m.appColors.PINK
    m.top.textEditBox.fontUri = "font:MediumBoldSystemFont"
    m.top.textEditBox.fontSize = 38

    'Input Field UI
    inputBox = m.top.textEditBox.getChildren(-1, 0)
    m.input = inputBox[4]
    m.input.blendColor =m.appColors.YELLOW

    'Input Focus UI
    inputBitmap = m.input.getChildren(-1, 0)
    inputBitmapBox = inputBitmap[0]
    inputBitmapBox.blendColor =m.appColors.YELLOW 

    inputFontStyle = m.input.getChildren(-1, 0)
    inputFontStyleSelected = inputFontStyle[0]
    inputFontStyleBox= inputFontStyleSelected.getChildren(-1, 0)
    inputFontStyleDefaultLabel = inputFontStyleBox[0]
    inputFontStyleDefaultLabel.visible = false

    m.top.textEditBox.observeField("text", "onTextChanged")
end sub

sub onTextChanged(event as object)
    print "DEBUG: onTextChanged: " ; event.getData()

    if m.top.textEditBox.text.len() > 0
        inputLabel = m.top.findNode("SimpleLabel")
        inputLabel.text = "Press & hold  to speak"
        inputLabel.color = m.appColors.PINK
        inputLabel.fontUri = "font:SmallBoldSystemFont"
        inputLabel.translation = [400, 120]
    end if

end sub

sub keySelected()
end sub