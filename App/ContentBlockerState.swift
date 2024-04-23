import SafariServices

class ContentBlockerState: ObservableObject {
  let identifier: String
  
  @Published private var state: Result<Bool, Error>? = nil
  
  private var notification: NSObjectProtocol?
  
  init(withIdentifier identifier: String) {
    self.identifier = identifier
    
    let notificationName: NSNotification.Name
    
    notificationName = UIApplication.didBecomeActiveNotification
    
    notification = NotificationCenter.default.addObserver(forName: notificationName, object: nil, queue: .main) { _ in
      self.refresh()
    }
    
    refresh()
  }
  
  deinit {
    if let observer = self.notification {
      NotificationCenter.default.removeObserver(observer)
    }
  }
  
  var isEnabled: Bool {
    switch state {
    case let .success(isEnabled):
      return isEnabled
    case .failure, nil:
      return false
    }
  }
  
  func refresh() {
    SFContentBlockerManager.getStateOfContentBlocker(withIdentifier: identifier) { state, error in
      DispatchQueue.main.async {
        if let state = state {
          self.state = .success(state.isEnabled)
        } else if let error = error {
          self.state = .failure(error)
        } else {
          self.state = nil
        }
      }
    }
  }
}
