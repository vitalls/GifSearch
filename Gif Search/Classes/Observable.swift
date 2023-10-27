class Observable<T> {
    typealias Listener = (T) -> Void
    var value: T {
        didSet {
            self.listener?(self.value)
        }
    }
    
    init(_ value:T) {
        self.value = value
    }
    
    private var listener: Listener?
    
    func bind(_ listener: @escaping Listener){
        self.listener = listener
    }
}
