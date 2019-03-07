primitive type FloatWK <: AbstractFloat 64 end

FloatWK(x::Float64) = reinterpret(FloatWK, x)
FloatWK(x::Float32) = reinterpret(FloatWK, Float64(x))
FloatWK(x::BigFloat) = FloatWK(Float64(x))

Float64(x::FloatWK) = reinterpret(Float64, x)
Float32(x::FloatWK) = Float32(reinterpret(Float64, x))
BigFloat(x::FloatWK) = BigFloat(Float64(x))

convert(::Type{FloatWK}, x::Float64) = FloatWK(x)
convert(::Type{FloatWK}, x::Float32) = FloatWK(x)
convert(::Type{FloatWK}, x::BigFloat) = FloatWK(x)
convert(::Type{Float64}, x::FloatWK) = Float64(x)
convert(::Type{Float32}, x::FloatWK) = Float32(x)
convert(::Type{BigFloat}, x::FloatWK) = BigFloat(x)

Base.show(io::IO, x::FloatWK) = show(io, Float32(x))
Base.string(x::FloatWK) = string(Float32(x))
Base.hash(x::FloatWK) = hash(Float64(x))
