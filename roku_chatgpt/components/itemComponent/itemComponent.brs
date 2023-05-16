sub init()
    m.rectangle = m.top.findNode("rectangle")
    m.label = m.top.findNode("label")
end sub

sub onContentChange(event as object)
    content = event.getData()
    m.label.text = content.text
end sub

sub focusPercentChanged(event as object)
    focusPercent = event.getData()
    if focusPercent > 0.5
        m.label.color = "#00FF00"
    else
        m.label.color = "#000000"
    end if
end sub