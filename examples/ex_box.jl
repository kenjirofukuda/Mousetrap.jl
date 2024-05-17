using Mousetrap

main() do app::Application
    window = Window(app)
    # https://clemens-cords.com/mousetrap/01_manual/04_widgets/#Box
    left = Label("LEFT")
    set_margin_start!(left, 10)

    center = Label("CENTER")
    set_margin_horizontal!(center, 10)

    right = Label("RIGHT")
    set_margin_end!(right, 10)

    # create a horizontal box
    box = Box(ORIENTATION_HORIZONTAL)

    # add `left` to the start
    push_front!(box, left)

    # add `right to the end
    push_back!(box, right)

    # insert `center` after `left`
    insert_after!(box, center, left)

    # add box to window
    set_child!(window, box)
    

    present!(window)
end
