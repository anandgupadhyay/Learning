let stream = AsyncStream {
	try? await Task.sleep(nanoseconds: 1_000_000_000)
	return Int.random(in: 1...10)
}

for await random in stream {
	print(random)
}
