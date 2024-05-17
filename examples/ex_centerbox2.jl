using Mousetrap

main() do app::Application
    window = Window(app)
    # https://clemens-cords.com/mousetrap/01_manual/04_widgets/#CenterBox
    # one liner
    center_box = CenterBox(ORIENTATION_HORIZONTAL,
                           Label("start"), Button(), Label("end"))
    set_child!(window, center_box)
    present!(window)
end
