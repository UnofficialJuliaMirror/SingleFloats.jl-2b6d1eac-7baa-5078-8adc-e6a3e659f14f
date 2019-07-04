import Base: cmp, ==, !=, >=, >, <=, <, isless, isequal
import Base: +, -, *, /, \, %, √, ÷
import Base.Math: ^, sqrt, cbrt, ∛, div, rem, fld, mod, cld, hypot, min, max, minmax, rad2deg, deg2rad, mod2pi, rem2pi
import Base: abs, abs2, sign, copysign, flipsign, floor, ceil, trunc, round, divrem, fldmod, clamp
import Base: exp, exp2, exp10, expm1, log, log2, log10, log1p, 
             sin, cos, tan, csc, sec, cot, asin, acos, atan, acsc, asec, acot,
             sinh, cosh, tanh, csch, sech, coth, asinh, acosh, atanh, acsch, asech, acoth

# comparisons
for Op in (:cmp, :(==), :(!=), :(>=), :(<=), :(>), :(<), :isless, :isequal)
    @eval begin
        $Op(x::Single32, y::Single32) = Single32($Op(Float64(x), Float64(y)))
        $Op(x::Single32, y::Float64) = Single32($Op(Float64(x), y))
        $Op(x::Float64, y::Single32) = Single32($Op(x, Float64(y)))
        $Op(x::Single32, y::Float32) = Single32($Op(Float64(x), Float64(y)))
        $Op(x::Float32, y::Single32) = Single32($Op(Float64(x), Float64(y)))
        $Op(x::Single32, y::Float16) = Single32($Op(Float64(x), Float64(y)))
        $Op(x::Float16, y::Single32) = Single32($Op(Float64(x), Float64(y)))
        $Op(x::Single32, y::BigFloat) = Single32($Op(Float64(x), Float64(y)))
        $Op(x::BigFloat, y::Single32) = Single32($Op(Float64(x), Float64(y)))
        $Op(x::Single32, y::Int64) = Single32($Op(Float64(x), Float64(y)))
        $Op(x::Int64, y::Single32) = Single32($Op(Float64(x), Float64(y)))
        $Op(x::Single32, y::Int32) = Single32($Op(Float64(x), Float64(y)))
        $Op(x::Int32, y::Single32) = Single32($Op(Float64(x), Float64(y)))
        $Op(x::Single32, y::Int16) = Single32($Op(Float64(x), Float64(y)))
        $Op(x::Int16, y::Single32) = Single32($Op(Float64(x), Float64(y)))
        $Op(x::Single32, y::Int128) = Single32($Op(Float64(x), Float64(y)))
        $Op(x::Int128, y::Single32) = Single32($Op(Float64(x), Float64(y)))
    end
end

# unary
for Op in (:+, :-, :sqrt, :cbrt, :rad2deg, :deg2rad, :mod2pi, :rem2pi, :abs, :abs2, :sign, :floor, :ceil, :trunc, :round)
    @eval $Op(x::Single32) = Single32($Op(Float64(x)))
end
for Op in (:exp, :exp2, :exp10, :expm1, :log, :log2, :log10, :log1p,
           :sin, :cos, :tan, :csc, :sec, :cot, :asin, :acos, :atan, :acsc, :asec, :acot,
           :sinh, :cosh, :tanh, :csch, :sech, :coth, :asinh, :acosh, :atanh, :acsch, :asech, :acoth)
    @eval $Op(x::Single32) = Single32($Op(Float64(x)))
end
# binary
for Op in (:+, :-, :*, :/, :\, :^, :div, :rem, :fld, :mod, :cld, :hypot, :min, :max, :minmax, :divrem, :fldmod, :copysign, :flipsign)
    @eval $Op(x::Single32, y::Single32) = Single32($Op(Float64(x), Float64(y)))
end
# trinary
for Op in (:clamp,)
    @eval $Op(x::Single32, y::Single32, z::Single32) = Single32($Op(Float64(x), Float64(y), Float64(z)))
end

Base.fma(x::Single32, y::Single32, z::Single32) = Single32(fma(Float64(x), Float64(y), Float64(z)))
Base.fma(x::Single32, y::Single32, z::T) where {T<:IEEEFloat} = Single32(fma(Float64(x), Float64(y), Float64(z)))
Base.fma(x::Single32, y::T, z::Single32) where {T<:IEEEFloat} = Single32(fma(Float64(x), Float64(y), Float64(z)))
Base.fma(x::T, y::Single32, z::Single32) where {T<:IEEEFloat} = Single32(fma(Float64(x), Float64(y), Float64(z)))
Base.fma(x::Single32, y::T, z::T) where {T<:IEEEFloat} = Single32(fma(Float64(x), Float64(y), Float64(z)))
Base.fma(x::T, y::Single32, z::T) where {T<:IEEEFloat} = Single32(fma(Float64(x), Float64(y), Float64(z)))
Base.fma(x::T, y::T, z::Single32) where {T<:IEEEFloat} = Single32(fma(Float64(x), Float64(y), Float64(z)))

Base.muladd(x::Single32, y::Single32, z::Single32) = Single32(muladd(Float64(x), Float64(y), Float64(z)))
Base.muladd(x::Single32, y::Single32, z::T) where {T<:IEEEFloat} = Single32(muladd(Float64(x), Float64(y), Float64(z)))
Base.muladd(x::Single32, y::T, z::Single32) where {T<:IEEEFloat} = Single32(muladd(Float64(x), Float64(y), Float64(z)))
Base.muladd(x::T, y::Single32, z::Single32) where {T<:IEEEFloat} = Single32(muladd(Float64(x), Float64(y), Float64(z)))
Base.muladd(x::Single32, y::T, z::T) where {T<:IEEEFloat} = Single32(muladd(Float64(x), Float64(y), Float64(z)))
Base.muladd(x::T, y::Single32, z::T) where {T<:IEEEFloat} = Single32(muladd(Float64(x), Float64(y), Float64(z)))
Base.muladd(x::T, y::T, z::Single32) where {T<:IEEEFloat} = Single32(muladd(Float64(x), Float64(y), Float64(z)))
