using Mousetrap

main() do app::Application
    window = Window(app)

    # https://clemens-cords.com/mousetrap/01_manual/04_widgets/#Separator
    hr = Separator()
    set_expand_horizontally!(hr, true)
    set_expand_vertically!(hr, false)
    set_size_request!(hr, Vector2f(
        0,  # width: any 
        3   # height: exactly 3 px
    ))
    set_child!(window, hr)
    present!(window)
end
