#include <cmath>
#include "complex-number.hpp"

double ComplexNumber::Modulus() {
    const double squares_sum =
        std::pow(real, 2) +
        std::pow(imaginary, 2);
    return std::sqrt(squares_sum);
}
