sub init()
    m.appColors = getAppColors()

    m.rectangle = m.top.findNode("rectangle")
    m.rectangle.color = m.appColors.BACKGROUND_COLOR

    m.label = m.top.findNode("label")
    m.label.color = m.appColors.WHITE
    m.label.font = "font:SmallBoldSystemFont"
end sub

sub onContentChange(event as object)
    content = event.getData()
    m.label.text = content.text
end sub

sub focusPercentChanged(event as object)
    focusPercent = event.getData()
    if focusPercent > 0.5
        m.label.color = m.appColors.BACKGROUND_COLOR
        m.rectangle.color = m.appColors.LIGHT_BLUE_FOCUS
    else
        m.label.color = m.appColors.WHITE
        m.rectangle.color = m.appColors.BACKGROUND_COLOR
    end if
end sub