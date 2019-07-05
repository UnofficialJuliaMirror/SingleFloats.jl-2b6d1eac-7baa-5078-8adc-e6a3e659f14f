import Base: promote_rule, convert

primitive type Single32 <: AbstractFloat 64 end

Single32(x::Single32) = x

Single32(x::Float64)  = reinterpret(Single32, x)
Single32(x::Float32)  = Core.Intrinsics.fpext(Single32, x)
Single32(x::Float16)  = reinterpret(Single32, Float64(x))

Base.Float64(x::Single32)  = reinterpret(Float64, x)
Base.Float32(x::Single32)  = Core.Intrinsics.fptrunc(Float32, x)
Base.Float16(x::Single32)  = Float16(Float32(x))

for st in (Int8, Int16, Int32, Int64)
    @eval begin
        (::Type{Single32})(x::($st)) = Core.Intrinsics.sitofp(Single32, x)
        promote_rule(::Type{Single32}, ::Type{$st}) = Single32
    end
end
for ut in (Bool, UInt8, UInt16, UInt32, UInt64)
    @eval begin
        (::Type{Single32})(x::($ut)) = Core.Intrinsics.uitofp(Single32, x)
        promote_rule(::Type{Single32}, ::Type{$ut}) = Single32
    end
end

for T in (Int128, UInt128)
  @eval begin
     promote_rule(::Type{Single32}, ::Type{$T}) = Single32
     Single32(x::$T) = Single32(Float64(x))
     convert(::Type{Single32}, x::$T) = Single32(x)
   end
end

Bool(x::Single32) = x==0 ? false : x==1 ? true : throw(InexactError(:Bool, Bool, x))


Base.show(io::IO, x::Single32) = show(io, Float32(x))
Base.string(x::Single32) = string(Float32(x))
Base.repr(x::Single32) = string("Single32(",repr(Float64(x)),")")

Base.widen(::Type{Single32}) = Float64
Base.widen(x::Single32) = Float64(x)

Base.hash(x::Single32) = hash(Float64(x))
Base.hash(x::Single32, h::UInt64) = hash(Float64(x), h)

Base.typemin(x::Single32)  = typemin(Float32)
Base.typemax(x::Single32)  = typemax(Float32)
Base.floatmin(x::Single32) = floatmin(Float32)
Base.floatmax(x::Single32) = floatmax(Float32)

Base.eps(::Type{Single32}) = eps(Float64)
Base.exponent(x::Single32) = exponent(Float64(x))
Base.significand(x::Single32) = significand(Float64(x))


Base.trunc(x::Single32) = Core.Intrinsics.trunc_llvm(x)
Base.floor(x::Single32) = Core.Intrinsics.floor_llvm(x)
Base.ceil(x::Single32)  = Core.Intrinsics.ceil_llvm(x)

Base.round(x::Single32, r::RoundingMode{:ToZero})  = Core.Intrinsics.trunc_llvm(x)
Base.round(x::Single32, r::RoundingMode{:Down})    = Core.Intrinsics.floor_llvm(x)
Base.round(x::Single32, r::RoundingMode{:Up})      = Core.Intrinsics.ceil_llvm(x)
Base.round(x::Single32, r::RoundingMode{:Nearest}) = Core.Intrinsics.rint_llvm(x)

Base.trunc(::Type{I}, x::Single32) where {I} = (I)(Core.Intrinsics.trunc_llvm(x))
Base.floor(::Type{I}, x::Single32) where {I} = (I)(Core.Intrinsics.floor_llvm(x))
Base.ceil(::Type{I}, x::Single32)  where {I} = (I)(Core.Intrinsics.ceil_llvm(x))

Base.round(::Type{I}, x::Single32, r::RoundingMode{:ToZero})  where {I} = (I)(Core.Intrinsics.trunc_llvm(x))
Base.round(::Type{I}, x::Single32, r::RoundingMode{:Down})    where {I} = (I)(Core.Intrinsics.floor_llvm(x))
Base.round(::Type{I}, x::Single32, r::RoundingMode{:Up})      where {I} = (I)(Core.Intrinsics.ceil_llvm(x))
Base.round(::Type{I}, x::Single32, r::RoundingMode{:Nearest}) where {I} = (I)(Core.Intrinsics.rint_llvm(x))
Base.round(::Type{I}, x::Single32) where {I} = (I)(Core.Intrinsics.rint_llvm(x))

    
Base.BigFloat(x::Single32) = BigFloat(Float64(x))
Base.Int128(x::Single32) = Int128(Float64(x))
Base.Int64(x::Single32) = Int64(Float64(x))
Base.Int32(x::Single32) = Int32(Float64(x))
Base.Int16(x::Single32) = Int16(Float64(x))

Base.promote_rule(::Type{Single32}, ::Type{Float32}) = Single32
Base.promote_rule(::Type{Single32}, ::Type{Float64}) = Single32
Base.promote_rule(::Type{Single32}, ::Type{Int32}) = Single32
Base.promote_rule(::Type{Single32}, ::Type{Int64}) = Single32


for T in (BigFloat, Float64, Float32, Float16,
          Int128, Int64, Int32, Int16, Int8,
          UInt128, UInt64, UInt32, UInt16, UInt8)
  @eval begin
    convert(::Type{Single32}, x::$T) = Single32(x)
    convert(::Type{$T}, x::Single32) = ($T)(x)    
  end
end



# comparisons
for Op in (:cmp, :(==), :(!=), :(>=), :(<=), :(>), :(<), :isless, :isequal)
    @eval begin
        $Op(x::Single32, y::Single32) = $Op(Float64(x), Float64(y))
        
        $Op(x::Single32, y::Float64) = $Op(Float64(x), y)
        $Op(x::Float64, y::Single32) = $Op(x, Float64(y))
        $Op(x::Single32, y::Float32) = $Op(Float64(x), Float64(y))
        $Op(x::Float32, y::Single32) = $Op(Float64(x), Float64(y))
        $Op(x::Single32, y::Float16) = $Op(Float64(x), Float64(y))
        $Op(x::Float16, y::Single32) = $Op(Float64(x), Float64(y))
        
        $Op(x::Single32, y::BigFloat) = $Op(Float64(x), y)
        $Op(x::BigFloat, y::Single32) = $Op(x, Float64(y))

        $Op(x::Single32, y::Int128) = $Op(Float64(x), y)
        $Op(x::Int128, y::Single32) = $Op(x, Float64(y))
        $Op(x::Single32, y::Int64)  = $Op(Float64(x), y)
        $Op(x::Int64, y::Single32)  = $Op(x, Float64(y))
        $Op(x::Single32, y::Int32)  = $Op(Float64(x), y)
        $Op(x::Int32, y::Single32)  = $Op(x, Float64(y))
        $Op(x::Single32, y::Int16)  = $Op(Float64(x), y)
        $Op(x::Int16, y::Single32)  = $Op(x, Float64(y))
        $Op(x::Single32, y::Int128) = $Op(Float64(x), y)

        $Op(x::Single32, y::UInt128) = $Op(Float64(x), y)
        $Op(x::UInt128, y::Single32) = $Op(x, Float64(y))
        $Op(x::Single32, y::UInt64)  = $Op(Float64(x), y)
        $Op(x::UInt64, y::Single32)  = $Op(x, Float64(y))
        $Op(x::Single32, y::UInt32)  = $Op(Float64(x), y)
        $Op(x::UInt32, y::Single32)  = $Op(x, Float64(y))
        $Op(x::Single32, y::UInt16)  = $Op(Float64(x), y)
        $Op(x::UInt16, y::Single32)  = $Op(x, Float64(y))
        $Op(x::Single32, y::UInt128) = $Op(Float64(x), y)
    end
end
