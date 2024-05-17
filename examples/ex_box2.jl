using Mousetrap

main() do app::Application
    window = Window(app)
    # https://clemens-cords.com/mousetrap/01_manual/04_widgets/#Box
    # use convenience functions
    box = hbox(Label("LEFT"), Label("CENTER"), Label("RIGHT"))
    set_spacing!(box, 10)
    # add box to window
    set_child!(window, box)
    
    present!(window)
end
