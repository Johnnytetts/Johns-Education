class StatsCalculator:
    @staticmethod
    def average(data: list[float]) -> float:
        if not data:
            print("Empty data list!")
            return -1
        return sum(data) / len(data)

    @staticmethod
    def variance(data: list[float]) -> float:
        if not data:
            print("Empty data list!")
            return -1
        mean = sum(data) / len(data)
        return sum((x - mean) ** 2 for x in data)

    @staticmethod
    def standard_dev(data: list[float]) -> float:
        if not data:
            print("Empty data list!")
            return -1
        mean = sum(data) / len(data)
        variance = sum((x - mean) ** 2 for x in data)
        return variance ** 0.5

    @staticmethod
    def median(data: list[float]) -> float:
        if not data:
            print("Empty data list!")
            return -1
        sorted_data = sorted(data)
        mid = len(data) // 2
        if len(data) % 2 == 0:
            return (sorted_data[mid - 1] + sorted_data[mid]) / 2
        else:
            return sorted_data[mid]


# Example usage:
data_list = [1, 2, 3, 4, 5]
print(StatsCalculator.average(data_list))
print(StatsCalculator.variance(data_list))
print(StatsCalculator.standard_dev(data_list))
print(StatsCalculator.median(data_list))
