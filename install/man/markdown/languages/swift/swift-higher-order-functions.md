# Swift Higher-Order Functions

## `map`

	let squares = values.map { $0 * $0 }

## `compactMap`

	let keys: [String?] = ["Tom", nil, "Peter", nil, "Harry"]
	let validNames = keys.compactMap { $0 }

## `flatMap`

	let results = [[5,2,7], [4,8], [9,1,3]]
	let allResults = results.flatMap { $0 }

## `filter`

	let even = digits.filter { $0 % 2 == 0 }

## `reduce`

	let items = [2.0,4.0,5.0,7.0]
	let total = items.reduce(10.0, +)

## `forEach`

	numbers.forEach { $0.isMultiple(of: 2) ? print("\($0) is even") : print("\($0) is odd") }

## `contains`

Returns a boolean.

	let hasNumbersLessThan5 = numbers.contains { $0 < 5 }

## `removeAll`

	numbers.removeAll { $0 < 10 }

## `sorted`

	let sorted = toSort.sorted { $0 > $1 }

## `split`

	let message = "Hello World!"
	let result = message.split { $0 == " " }
	print(result)
	// Prints ["Hello", "World!"]
