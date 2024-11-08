// New way to Implement cache
class Cache<Key: Hashable, Value> {
    private var _cache: [Key: Value] = [:]
    private var lock = OSAllocatedUnfairLock()

    func get(key: Key) -> Value? {
        lock.lock()
        defer { lock.unlock() }
        return _cache[key]
    }

    func set(key: Key, value: Value) {
        lock.lock()
        defer { lock.unlock() }
        _cache[key] = value
    }
}

let cache = Cache<String, String>()

func updateCache() {
    cache.set(key: "key", value: "value")
}


//============= Previously ==================//

actor Cache<Key: Hashable, Value> {
    private var _cache: [Key: Value] = [:]

    func get(_ key: Key) -> Value? {
        return _cache[key]
    }

    func set(_ key: Key, value: Value) {
        _cache[key] = value
    }
}

let cache = Cache<String, String>()

func updateCache() async {
    await cache.set("key", value: "value")
}

