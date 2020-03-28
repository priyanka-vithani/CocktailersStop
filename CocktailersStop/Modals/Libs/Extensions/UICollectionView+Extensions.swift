import UIKit

// MARK: - UICollectionViewCell

extension UICollectionView {
    
    func dequeueCell<T:UICollectionViewCell>(_ identifier: String? = nil, indexPath: IndexPath) -> T {
        let identifier = identifier ?? String(describing: T.self)
        let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? T
        switch cell {
        case .some(let unwrapped):  return unwrapped
        default:                    fatalError("Unable to dequeue" + T.self.description())
        }
    }
    
    func register<T:UICollectionViewCell>(_ type: T.Type, identifier: String? = nil) {
        let identifier = identifier ?? String(describing: T.self)
        register(type, forCellWithReuseIdentifier: identifier)
    }
}

// MARK: - UICollectionReusableView

extension UICollectionView {
    
    func dequeueSupplementary<T:UICollectionReusableView>(_ identifier: String? = nil, indexPath: IndexPath, kind: String) -> T {
        let identifier = identifier ?? String(describing: T.self)
        let view = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath) as? T
        switch view {
        case .some(let unwrapped):  return unwrapped
        default:                    fatalError("Unable to dequeue" + T.self.description())
        }
    }
    
    func register<T:UICollectionReusableView>(_ type: T.Type, identifier: String? = nil, kind: String) {
        let identifier = identifier ?? String(describing: T.self)
        register(type, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
    }
}
extension UICollectionView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .red
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 20)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
