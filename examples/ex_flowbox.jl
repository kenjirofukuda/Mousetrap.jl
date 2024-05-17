using Mousetrap

main() do app::Application
    window = Window(app)
    # https://clemens-cords.com/mousetrap/01_manual/04_widgets/#FlowBox
    flow_box = FlowBox(ORIENTATION_VERTICAL)
    for i in 1:7 
        push_back!(flow_box, Label(string(i)))
    end
    set_child!(window, flow_box)
    present!(window)
end
