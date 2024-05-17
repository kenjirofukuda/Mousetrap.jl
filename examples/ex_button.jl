using Mousetrap

# https://clemens-cords.com/mousetrap/01_manual/04_widgets/#Button
main() do app::Application
    window = Window(app)

    normal = Button()
    set_child!(normal, Label("01"))

    no_frame = Button()
    set_has_frame!(no_frame, false)
    set_child!(no_frame, Label("02"))

    circular = Button()
    set_is_circular!(circular, true)
    set_child!(circular, Label("03"))

    box = CenterBox(ORIENTATION_HORIZONTAL, normal, no_frame, circular)
    set_margin!(box, 75)

    set_child!(window, box)
    present!(window)
end
