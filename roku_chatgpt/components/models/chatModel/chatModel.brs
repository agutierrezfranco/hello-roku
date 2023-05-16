function parseData(data as object)
    print "Parsing data..."
    items = []
    for each choice in data.choices
        items.push({ message: choice.message.content })
    end for
    m.top.data = {items: items}
end function