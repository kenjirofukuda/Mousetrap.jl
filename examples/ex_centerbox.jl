using Mousetrap

main() do app::Application
    window = Window(app)
    # https://clemens-cords.com/mousetrap/01_manual/04_widgets/#CenterBox
    center_box = CenterBox(ORIENTATION_HORIZONTAL)
    set_start_child!(center_box, Label("start"))
    set_center_child!(center_box, Button())
    set_end_child!(center_box, Label("end"))

    set_child!(window, center_box)
    present!(window)
end
