__precompile__()

module GtkUtilities

using Cairo, Gtk.ShortNames, Colors

using Graphics

export
    # Link
    AbstractState,
    State,
    link,
    disconnect,
    get,
    set!,
    set_quietly!,
    widget,
    id,
    lLabel,
    lEntry,
    lScale,
    # GUIData
    guidata,
    trigger,
    # Rubberband
    rubberband_start,
    # PanZoom
    Interval,
    interior,
    fullview,
    panzoom,
    panzoom_key,
    panzoom_mouse,
    set_coords

include("link.jl")
using .Link
include("guidata.jl")
using .GuiData
include("rubberband.jl")
using .RubberBands
include("panzoom.jl")
using .PanZoom
import .PanZoom: interior, fullview   # for extensions

function Base.copy!{C<:Colorant}(ctx::CairoContext, img::AbstractArray{C})
    save(ctx)
    Cairo.reset_transform(ctx)
    image(ctx, image_surface(img), 0, 0, width(ctx), height(ctx))
    restore(ctx)
end
Base.copy!(c::Canvas, img) = copy!(getgc(c), img)
function Base.fill!(c::Canvas, color::Colorant)
    ctx = getgc(c)
    w, h = width(c), height(c)
    rectangle(ctx, 0, 0, w, h)
    set_source(ctx, color)
    fill(ctx)
end

image_surface{C<:Color}(img::AbstractArray{C}) = CairoImageSurface(reinterpret(UInt32, convert(Matrix{RGB24}, img)), Cairo.FORMAT_RGB24)
image_surface{C<:Colorant}(img::AbstractArray{C}) = CairoImageSurface(reinterpret(UInt32, convert(Matrix{ARGB32}, img)), Cairo.FORMAT_ARGB32)

"""
Summary of features in GtkUtilities:

- `rubberband_start`: initiate rubber band selection
- `guidata`: associate user data with on-screen elements

Each of these has detailed help available, e.g., `?guidata`.
""" GtkUtilities

end # module
