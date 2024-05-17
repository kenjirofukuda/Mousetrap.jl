using Mousetrap

main() do app::Application
    window = Window(app)
    # https://clemens-cords.com/mousetrap/01_manual/04_widgets/#HeaderBar

    # access windows header bar instance
    header_bar = get_header_bar(window)

    # hide title buttons
    set_layout!(header_bar, ":")

    # hide default title by replacing it with an empty label
    set_title_widget!(header_bar, Label(""))

    present!(window)
end
