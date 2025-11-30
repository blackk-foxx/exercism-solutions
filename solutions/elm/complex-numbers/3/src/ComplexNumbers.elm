module ComplexNumbers exposing
    ( Complex
    , abs
    , add
    , conjugate
    , div
    , exp
    , fromPair
    , fromReal
    , imaginary
    , mul
    , real
    , sub
    )


type alias Complex = { real: Float, imaginary:  Float}


fromPair : ( Float, Float ) -> Complex
fromPair (r, i) = Complex r i


fromReal : Float -> Complex
fromReal float = Complex float 0


real : Complex -> Float
real z = z.real


imaginary : Complex -> Float
imaginary z = z.imaginary


conjugate : Complex -> Complex
conjugate z = Complex z.real -z.imaginary


abs : Complex -> Float
abs z = sqrt( z.real^2 + z.imaginary^2 )


add : Complex -> Complex -> Complex
add z1 z2 = Complex (z1.real + z2.real) (z1.imaginary + z2.imaginary)


sub : Complex -> Complex -> Complex
sub z1 z2 = Complex (z1.real - z2.real) (z1.imaginary - z2.imaginary)


mul : Complex -> Complex -> Complex
mul z1 z2 = Complex
        (z1.real * z2.real - z1.imaginary * z2.imaginary)
        (z1.imaginary * z2.real + z1.real * z2.imaginary)

div : Complex -> Complex -> Complex
div z1 z2 =
    let denom = z2.real^2 + z2.imaginary^2
    in Complex
        ((z1.real * z2.real + z1.imaginary * z2.imaginary) / denom)
        ((z1.imaginary * z2.real - z1.real * z2.imaginary) / denom)

exp : Complex -> Complex
exp z = mul 
    (fromReal (e^z.real)) 
    (Complex (cos(z.imaginary)) (sin(z.imaginary)))
