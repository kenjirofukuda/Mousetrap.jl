using Mousetrap

image_path() = 
    joinpath(dirname(dirname(pathof(Mousetrap))), "favicon.png")

main() do app::Application
    window = Window(app)

    # https://clemens-cords.com/mousetrap/01_manual/04_widgets/#ImageDisplay
    if true 
        image_display = ImageDisplay()
        create_from_file!(image_display, image_path())
    else
        # equivalent to
        image_display = ImageDisplay(image_path())
    end
    set_child!(window, image_display)
    present!(window)
end
