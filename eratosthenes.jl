"""
Copyright 2020 Philip Mortimer

This file is part of Philip Mortimer Example Programs.

Philip Mortimer Example Programs is free software: you can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the License,
or (at your option) any later version.

Philip Mortimer Example Programs is distributed in the hope that it will be
useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Philip Mortimer Example Programs.  If not, see
<https://www.gnu.org/licenses/>.
"""

# N such that the largest prime in the sequence will not exceed N.
const N = 500

# Specifies how many numbers are to be printed on each line
# when printing the prime numbers.
const NUMBERS_PER_LINE = 20

"""
    eratosthenes(ch, n)

Generate a sequence of prime numbers using the sieve of Eratosthenes
algorithm. It is based on https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes.

The sequence consists of all primes in the range 2..max prime inclusive where
max prime is the largest prime which does not exceed n.

# Arguments
- `ch`: channel to which the primes are to be output.
- `n`: the largest prime in the sequence will be the largest prime <= n.
"""
function eratosthenes(ch, n)
    @assert (n >= 2) "n must be >= 2"

    # isprime array is initially filled with true values, but the function will
    # set isprime[i] to false if i is not prime.
    isprime = fill(true, 1, n)

    # Find the primes.
    max_i = Int(trunc(sqrt(n)))
    for i in 2:max_i
        if isprime[i]
            for j in range(i*i, stop=lastindex(isprime), step=i)
                isprime[j] = false
            end
        end
    end

    # Output the primes.
    for i in 2:lastindex(isprime)
        if isprime[i]
            put!(ch, i)
        end
    end
end

eratosthenes(n::T) where {T <: Integer} = Channel{T}(ch -> eratosthenes(ch, n))

function printprimes(n, numbers_per_line)
    @assert (numbers_per_line >= 1) "numbers_per_line must be >= 1"

    println("Prime numbers between 2 and $n are as follows:\n")
    count = 0
    for prime in eratosthenes(n)
        if count == 0
            print(prime)
        elseif count % numbers_per_line == 0
            print("\n$prime")
        else
            print(" $prime")
        end
        count += 1
    end
    println("\n\n$count prime numbers were generated.")
end

printprimes(N, NUMBERS_PER_LINE)
