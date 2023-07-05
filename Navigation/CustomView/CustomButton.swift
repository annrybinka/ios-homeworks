import UIKit

final class CustomButton: UIButton {
    
    private let title: String
    private let titleColor: UIColor
    private let tapAction: (() -> Void)
    
    init(title: String, titleColor: UIColor, tapAction: @escaping () -> Void) {
        self.title = title
        self.titleColor = titleColor
        self.tapAction = tapAction
        super.init(frame: .zero)
        
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.setBackgroundImage(UIImage(named: "blue"), for: .normal)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        self.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        self.tapAction()
    }
}
