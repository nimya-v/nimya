import Foundation
import UIKit

final class CustomNavigationBar: UIView {

    private static let NIB_NAME = "CustomNavigationBar"

    @IBOutlet private var view: UIView!
    @IBOutlet weak var leftButton: UIButton! {
        didSet {
            leftButton.backgroundColor = .clear
            leftButton.layer.cornerRadius = leftButton.frame.width / 2
            leftButton.imageView?.layer.cornerRadius = leftButton.frame.width / 2
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var rightFirstButton: UIButton!
    @IBOutlet weak var rightSecondButton: UIButton!
    @IBOutlet weak var userStatus: UILabel!
    @IBOutlet weak var btnBackButton: UIButton!
    @IBOutlet weak var backButtonWidthConstraint: NSLayoutConstraint!

    var backButtonTapped: (() -> Void)?

    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }

    var isLeftButtonHidden: Bool {
        get {
            return leftButton.isHidden
        }
        set {
            leftButton.isHidden = newValue
        }
    }

    var isRightFirstButtonEnabled: Bool {
        get {
            return rightFirstButton.isEnabled
        }
        set {
            rightFirstButton.isEnabled = newValue
        }
    }

    override func awakeFromNib() {
        initWithNib()
    }

    private func initWithNib() {

        Bundle.main.loadNibNamed(CustomNavigationBar.NIB_NAME, owner: self, options: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        self.backButtonWidthConstraint.constant = 0
        userStatus.isHidden = true
        setupLayout()
    }

    private func setupLayout() {
        NSLayoutConstraint.activate(
            [
                view.topAnchor.constraint(equalTo: topAnchor),
                view.leadingAnchor.constraint(equalTo: leadingAnchor),
                view.bottomAnchor.constraint(equalTo: bottomAnchor),
                view.trailingAnchor.constraint(equalTo: trailingAnchor)
            ]
        )
    }

    @IBAction func onBackButtonCLicked(_ sender: Any) {
        backButtonTapped?()
    }
}
