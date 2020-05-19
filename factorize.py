import sys
from math import sqrt


def factorize(n: int) -> tuple:
    factors: list = []
    for denominator in range(2, n // 2 + 1):
        print(f"Checking {denominator}")
        while n % denominator == 0:
           factors.append(denominator)
           n = n // denominator
    if not factors:
        factors.append(n)
    return tuple(factors)

if __name__ == "__main__":
    print(factorize(int(sys.argv[1])))
