using Mousetrap

main() do app::Application
    window = Window(app)

    # https://clemens-cords.com/mousetrap/01_manual/04_widgets/#Separator
    separator = Separator()
    set_margin!(separator, 20)
    set_expand!(separator, true)
    set_child!(window, separator)
    present!(window)
end
