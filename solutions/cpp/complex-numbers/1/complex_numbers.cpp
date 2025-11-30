#include "complex_numbers.h"
#include <cmath>

namespace complex_numbers {

double Complex::abs() const {
    return sqrt(pow(real(), 2) + pow(imag(), 2));    
}

Complex Complex::conj() const {
    return {real(), -imag()};
}

Complex Complex::exp() const {
    double e = ::exp(1.0);
    double f = pow(e, real());
    return {f * cos(imag()), f * sin(imag())};
}

Complex Complex::operator + (const Complex& rhs) const {
    return {real() + rhs.real(), imag() + rhs.imag()};
}
    
Complex Complex::operator + (double rhs) const {
    return {real() + rhs, imag()};
}
    
Complex Complex::operator - (const Complex& rhs) const {
    return {real() - rhs.real(), imag() - rhs.imag()};
}
    
Complex Complex::operator - (double rhs) const {
    return {real() - rhs, imag()};
}
    
Complex Complex::operator * (const Complex& rhs) const {
    return {
        real() * rhs.real() - imag() * rhs.imag(),
        imag() * rhs.real() + real() * rhs.imag()
    };
}
    
Complex Complex::operator * (double rhs) const {
    return {real() * rhs, imag() * rhs};
}
    
Complex Complex::operator / (const Complex& rhs) const {
    auto denom = (pow(rhs.real(), 2) + pow(rhs.imag(), 2));
    return {
        (real() * rhs.real() + imag() * rhs.imag()) / denom,
        (imag() * rhs.real() - real() * rhs.imag()) / denom
    };
}
    
Complex Complex::operator / (double rhs) const {
    return {real() / rhs, imag() / rhs};
}

Complex operator + (double lhs, const Complex& rhs) {
    return {lhs + rhs.real(), rhs.imag()};
}
    
Complex operator - (double lhs, const Complex& rhs) {
    return {lhs - rhs.real(), -rhs.imag()};
}
    
Complex operator * (double lhs, const Complex& rhs) {
    return {lhs * rhs.real(), lhs * rhs.imag()};
}
    
Complex operator / (double lhs, const Complex& rhs) {
    auto denom = pow(rhs.real(), 2) + pow(rhs.imag(), 2);
    return {lhs * rhs.real() / denom, -lhs * rhs.imag() / denom};
}

    
}  // namespace complex_numbers
