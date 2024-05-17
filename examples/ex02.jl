using Mousetrap
main() do app::Application
    window = Window(app)
    box = Box(ORIENTATION_HORIZONTAL)
    button_a = Label("A")
    button_b = Label("B")
    set_expand!(button_a, true)
    set_expand!(button_b, true)

    push_back!(box, button_a)
    push_back!(box, button_b)
    set_margin!(box, 20)
    set_expand!(box, true)
    set_child!(window, box)
    present!(window)
end
