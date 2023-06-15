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
        if isnothing(match(r".*_signal_.*", string(binding))) # filter autogenerated signal functions
            if string(n)[1] != `@` # filter macros
                push!(functions, n)
            end
        end
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

macro function_docs(name, brief::String, return_t, args...)
   
    arg_list = ""
    n_args = length(args)
    for i in 1:n_args
        arg_list *= string(args[i])
        if i != n_args
            arg_list *= ", "
        end
    end
    signature = "($arg_list) -> $return_t"
   
    text = ""
    text *= "```\n"
    text *= "$name$signature\n"
    text *= "```\n"
    text *= "$brief\n"

    return :(@doc $text $name)
end

function enum_docs(name, brief, values...)
    out = "## $(name)\n"
    out *= "$(brief)\n"
    out *= "## Enum Values\n"

    for value in values
        out *= "+ `$value`\n"
    end

    return out
end

function type_brief(name, super, brief)
    out = "## $name <: $super\n"
    out *= "$brief\n"
    return out
end

struct SignalDescriptor
    id::Symbol
    signature::String
    emitted_when::String
end
const signal_descriptors = Dict{Symbol, SignalDescriptor}()

function type_signals(name, signals...)
    out = "## Signals\n"
    out *= "| Signal ID | Signature | Emitted when...|\n|---|---|---|\n"
    for id in signals
        descriptor = signal_descriptors[id]
        out *= "| `" * string(descriptor.id) * "` | `(instance::" * string(name) * ", " * descriptor.signature * "` | " * descriptor.emitted_when * "|\n"
    end
    return out
end

function type_constructors(ctors...)
    out = "## Constructors\n"
    if !isempty(constructors)
        for constructor in constructors
            out *= "+ `" * constructor * "`\n"
        end
    else
        out *= "(no public constructors)\n"
    end
end

function type_fields(fields...)
    out = "## Fields\n"
    if !isempty(fields)
        for field in fields
            out *= "+ `" * string(field[1]) * "::" * string(field[2]) * "`\n"
        end
    else
        out *= "(no public fields)\n"
    end
    return out
end

function example(string)
    return "## Example\n```julia\n$string\n```"
end

include("docs/signals.jl")
include("docs/functions.jl")
include("docs/types.jl")
include("docs/enums.jl")