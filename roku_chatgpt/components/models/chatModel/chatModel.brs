function parseData(data as object)
    print "Parsing data..."
    items = []
    for each choice in data.choices
        item = { message: choice.message}
        items.push(item)
    end for
    m.top.data = {items: items}
end function