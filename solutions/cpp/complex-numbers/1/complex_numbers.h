#pragma once

namespace complex_numbers {

class Complex {
public:
    Complex(double real, double imag): _real(real), _imag(imag) {}
    double real() const {return _real;}
    double imag() const {return _imag;}
    double abs() const;
    Complex conj() const;
    Complex exp() const;
    Complex operator + (const Complex& rhs) const;
    Complex operator + (double rhs) const;
    Complex operator - (const Complex& rhs) const;
    Complex operator - (double rhs) const;
    Complex operator * (const Complex& rhs) const;
    Complex operator * (double rhs) const;
    Complex operator / (const Complex& rhs) const;
    Complex operator / (double rhs) const;
private:
    double _real;
    double _imag;
};

Complex operator + (double lhs, const Complex& rhs);
Complex operator - (double lhs, const Complex& rhs);
Complex operator * (double lhs, const Complex& rhs);
Complex operator / (double lhs, const Complex& rhs);

}  // namespace complex_numbers
