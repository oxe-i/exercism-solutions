def is_triangle(sides):
    return sides.count(0) == 0 and sum(sides) >= 2 * max(sides)

def equilateral(sides):
    return is_triangle(sides) and sides.count(sides[0]) == 3


def isosceles(sides):
    return is_triangle(sides) and (sides.count(sides[0]) >= 2 or sides.count(sides[1]) >= 2)


def scalene(sides):
    return is_triangle(sides) and not equilateral(sides) and not isosceles(sides)
