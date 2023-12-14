class stats_calculator:
    def clc(self, name: str, x: list[float]) -> float:
        y = 0
        if name == "average":
            z = 0
            for i in range(0, len(x)):
                z = z + x[i]
            y = z / len(x)
        elif name == "variance":
            z = 0
            for i in range(0, len(x)):
                z = z + x[i]
            k = z / len(x)
            a = 0
            for i in range(0, len(x)):
                a = a + ((x[i] - k) * (x[i] - k))
            y = a
        elif name == "standard dev":
            z = 0
            for i in range(0, len(x)):
                z = z + x[i]
            k = z / len(x)
            a = 0
            for i in range(0, len(x)):
                a = a + ((x[i] - k) * (x[i] - k))
            y = a ** .5
        elif name == "median":
            for i in range(len(x)):
                mn = i
                for j in range(i, len(x)):
                    if x[j] < x[mn]:
                        mn = j
                temp = x[i]
                x[i] = x[mn]
                x[mn] = temp
            if len(x) % 2 == 0:
                a = int(len(x) // 2)
                y = (x[a] + x[a-1])/2
            elif len(x) % 2 == 1:
                a = int(len(x) // 2)
                y = x[a]
        else:
            print("Function not found!")
            y = -1
        return y
