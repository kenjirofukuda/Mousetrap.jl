## Classification

widgets = Symbol[]
event_controllers = Symbol[]
signal_emitters = Symbol[]
abstract_types = Symbol[]
types = Symbol[]
functions = Symbol[]
enums = Symbol[]
enum_values = Symbol[]
other = Symbol[]

for n in names(mousetrap)

    binding = getproperty(mousetrap, n)

    if binding isa Type
        if isabstracttype(binding)
            push!(abstract_types, n)
        elseif binding <: Widget
            push!(widgets, n)
        elseif binding <: EventController
            push!(event_controllers, n)
        elseif binding <: SignalEmitter
            push!(signal_emitters, n)
        elseif binding <: Int64
            push!(enums, n)
        else
            push!(types, n)
        end
    elseif typeof(binding) <: Function
       # if isnothing(match(r".*_signal_.*", string(binding))) # filter autogenerated signal functions
            if string(n)[1] != `@` # filter macros
                push!(functions, n)
            end
        #end
    elseif typeof(binding) <: Int64
        push!(enum_values, n)
    else
        push!(other, n)
    end
end

## Docs Common

macro document(name, string)
    :(@doc $string $name)
end

function enum_docs(name, brief, values)
    out = "# $(name)\n"
    out *= "$(brief)\n"
    out *= "## Enum Values\n"

    for value in values
        out *= "+ `$value`\n"
    end

    return out
end

macro type_constructors(constructors...)
    out = "## Constructors\n"
    if !isempty(constructors)
        out *= "```\n"
        for constructor in constructors
            out *= string(constructor) * "\n"
        end
        out *= "```\n"
    else
        out *= "(no public constructors)\n"
    end
    return out
end

macro type_fields()
    out = "## Fields\n"
    out *= "(no public fields)\n"   
    return out
end

macro type_fields(fields...)
    out = "## Fields\n"
    if !isempty(fields)
        for field in fields
            out *= "+ `$field`\n"
        end
    else
        out *= "(no public fields)\n"
    end
    return out
end

using InteractiveUtils

function abstract_type_docs(type_in, super_type, brief)

    type = string(type_in)
    out = "$brief\n"
    out *= "## Supertype\n`$super_type`\n"

    out *= "## Subtypes\n"
    for t in InteractiveUtils.subtypes(type_in)
        out *= "+ `$t`\n"
    end
    return out
end

## include

include("docs/signals.jl")
include("docs/functions.jl")
include("docs/types.jl")
include("docs/enums.jl")

@do_not_compile const _generate_function_docs = quote

    for name in mousetrap.functions

        method_list = ""
        method_table = methods(getproperty(mousetrap, name))
        for i in eachindex(method_table)
            as_string = string(method_table[i])
            method_list *= as_string[1:match(r" \@.*", as_string).offset]
            if i != length(method_table)
                method_list *= "\n"
            end
        end

        println("""
        @document $name \"\"\"
        ```
        $method_list
        ```
        TODO
        \"\"\"
        """)
    end
end

@do_not_compile const _generate_type_docs = quote
    
    for name in sort(union(
        mousetrap.types, 
        mousetrap.signal_emitters, 
        mousetrap.widgets, 
        mousetrap.event_controllers, 
        mousetrap.abstract_types    
    ))

        if name in mousetrap.types
            println("""
            @document $name \"\"\"
                ## $name

                TODO

                \$(@type_constructors(
                ))

                \$(@type_fields(
                ))
            \"\"\"
            """)
        elseif name in mousetrap.abstract_types
            println("""
            @document $name abstract_type_docs($name, Any, \"\"\"
                TODO
            \"\"\")
            """)            
        else
            super = ""

            if name in mousetrap.event_controllers
                super = "EventController"
            elseif name in mousetrap.widgets
                super = "Widget"
            elseif name in mousetrap.signal_emitters
                super = "SignalEmitter"
            else
                continue
            end
            
            println("""
            @document $name \"\"\"
                ## $name <: $super

                TODO

                \$(@type_constructors(
                ))

                \$(@type_signals($name, 
                ))

                \$(@type_fields())
            \"\"\"
            """)
        end
    end
end

@do_not_compile const _generate_enum_docs = quote
    for enum_name in mousetrap.enums
        enum = getproperty(mousetrap, enum_name)
        values = []
        for value_name in mousetrap.enum_values
            if typeof(getproperty(mousetrap, value_name)) <: enum
                push!(values, value_name)
            end
        end

        value_string = ""
        for i in 1:length(values)
            value_string *= "    :" * string(values[i])
            if i != length(values)
                value_string *= ","
            end
            value_string *= "\n"
        end

        println("""
        @document $enum_name enum_docs(:$enum_name,
            "TODO", [
        $value_string])""")

        for value in values
           println("@document $value \"TODO\"")
        end

        println()
    end
end