
import Foundation

final class Debouncer: NSObject {
    
    private var delay: Double
    private var delegate: DebouncerDelegate?
    private weak var timer: Timer?
    
    init(delay: Double, delegate: DebouncerDelegate) {
        self.delay = delay
        self.delegate = delegate
    }
    
    public func call() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: #selector(executeCallback), userInfo: nil, repeats: false)
    }
    
    public func invalidateTimer() {
        timer?.invalidate()
    }
    
    @objc private func executeCallback() {
        delegate?.executeCallback()
    }
}

protocol DebouncerDelegate {
    func executeCallback()
}
