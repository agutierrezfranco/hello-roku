
sub init()
    repository = createObject("roSGNode", "repository")
    m.top.repository = repository

    m.testListContent = createObject("RoSGNode", "ContentNode")

    ' NOTE: The component name to load for each list item
    ' is kept in a parallel roArray for now
    m.testComponents = createObject("RoArray", 3, true)

    addListItem("PBS General Audience", "GeneralAudience")
    addListItem("PBS Kids", "Kids")

    print "TestComponents"; m.testComponents

    m.list = m.top.FindNode("TestListContent")
    m.list.content = m.testListContent

    m.list.ObserveField("itemSelected", "listItemSelected")

    ' set focus on the Scene (which will set focus on the initialFocus node)
    m.top.setFocus(true)
end sub


sub addListItem(label as string, component as string)
    testListItem = m.testListContent.createChild("ContentNode")
    testListItem.TITLE = label

    m.testComponents.Push(component)
end sub

sub listItemSelected()
    selectedItem = m.list.itemSelected
    print "-- selected item "; selectedItem

    if (selectedItem >= 0) and (selectedItem < m.testListContent.GetChildCount())
        selectedComponent = m.testComponents.GetEntry(selectedItem)
        print "SelectedComponent is "; selectedComponent

        m.list.visible = false

        m.currentTest = CreateObject("RoSGNode", selectedComponent)
        m.currentTest.id = "CURRENT_TEST"
        m.top.AppendChild(m.currentTest)

        m.currentTest.SetFocus(true)
    end if
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if press then
        if key = "back"
            if not (m.currentTest = invalid)
                print "CLEANING UP m.currentTest"
                m.top.RemoveChild(m.currentTest)
                m.currentTest = invalid

                m.list.visible = true
                m.list.SetFocus(true)

                return true
            end if
        end if
    end if
    return false
end function