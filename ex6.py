from math import pi, cos, sinh

def get_node(n, k):
    return 9 / 4 + 1 / 4 * cos((2 * k - 1) / (2 * n) * pi)

def get_nodes(n):
    nodes = []
    for k in range(1, n+1):
        nodes.append(get_node(n, k))
    return tuple(sorted(nodes))

def original_fun(x):
   return sinh(x) * cos(3*x)

def get_result(N):
    xnodes = list(get_nodes(N))
    ynodes = []
    for item in xnodes:
        ynodes.append(original_fun(item))

    for i in range(N):
        xnodes[i] = round(xnodes[i], 15)
    for i in range(N):
        ynodes[i] = round(ynodes[i], 15)
    xnodes = tuple(xnodes)
    ynodes = tuple(ynodes)

    nodes = tuple(zip(xnodes, ynodes))

    # result = list(xnodes)
    result = ""
    for item in nodes:
        result = "".join([result, f"{{{item[0]},{item[1]}}},"])

    print(result)

if __name__ == "__main__":
    get_result(5)
