def is_triangle(sides):
    first_inequality = (sides[0] + sides[1] >= sides[2])
    second_inequality = (sides[0] + sides[2] >= sides[1])
    third_inequality = (sides[1] + sides[2] >= sides[0])
    return sides[0] > 0 and sides[1] > 0 and sides[2] > 0 and first_inequality and second_inequality and third_inequality

def equilateral(sides):
    return is_triangle(sides) and sides[0] == sides[1] and sides[1] == sides[2]


def isosceles(sides):
    return is_triangle(sides) and (sides[0] == sides[1] or sides[0] == sides[2] or sides[1] == sides[2])


def scalene(sides):
    return is_triangle(sides) and not equilateral(sides) and not isosceles(sides)
