using Mousetrap

# https://clemens-cords.com/mousetrap/01_manual/04_widgets/#Button
main() do app::Application
    window = Window(app)

    # https://clemens-cords.com/mousetrap/01_manual/04_widgets/#ToggleButton
    toggle_button = ToggleButton()
    connect_signal_toggled!(toggle_button) do self::ToggleButton
        println("state is now: $(get_is_active(self))")
    end
    set_child!(window, toggle_button)
    present!(window)
end
