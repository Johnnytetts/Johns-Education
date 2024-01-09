class StatsCalculator:
    @staticmethod
    def calculate_average(numbers: list[float]) -> float:
        if not numbers:
            print("Input list is empty!")
            return -1
        return sum(numbers) / len(numbers)

    @staticmethod
    def calculate_variance(numbers: list[float]) -> float:
        n = len(numbers)
        if n < 2:
            return 0

        mean = StatsCalculator.calculate_average(numbers)
        variance = sum((num - mean) ** 2 for num in numbers) / n
        return variance

    @staticmethod
    def calculate_standard_deviation(numbers: list[float]) -> float:
        variance = StatsCalculator.calculate_variance(numbers)
        return variance ** 0.5

    @staticmethod
    def calculate_median(numbers: list[float]) -> float:
        sorted_numbers = sorted(numbers)
        n = len(sorted_numbers)
        if n % 2 == 0:
            middle = n // 2
            return (sorted_numbers[middle] + sorted_numbers[middle - 1]) / 2
        else:
            return sorted_numbers[n // 2]
