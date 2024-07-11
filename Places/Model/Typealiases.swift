import Combine

public typealias SafeCurrentValueSubject<Output> = CurrentValueSubject<Output, Never>
public typealias SafePassthroughSubject<Output> = PassthroughSubject<Output, Never>
public typealias AnySafePublisher<V> = AnyPublisher<V, Never>
