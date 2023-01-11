//
//  TestView.swift
//  Weather
//
//  Created by Filosuf on 30.12.2022.
//

import UIKit

final class TestTwoView: UIView {
    // MARK: - Properties
    lazy var thumbView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let padding: CGFloat = 2
    var isOn = true

    private var thumbLeadingConstraint: NSLayoutConstraint!

    //MARK: - LifeCicle
    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = .white
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tap)
        layout()
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        isOn = !isOn
        self.layoutIfNeeded()
        UIView.animate(withDuration: 2) { [self] in
            self.thumbLeadingConstraint.constant = isOn ? bounds.size.width / 2 : padding
            self.layoutIfNeeded()
        }
    }

    private func layout() {

        addSubview(thumbView)

        thumbLeadingConstraint = thumbView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding)

        NSLayoutConstraint.activate([
            thumbView.heightAnchor.constraint(equalTo: heightAnchor, constant: -padding * 2),
            thumbView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            thumbLeadingConstraint,
            thumbView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
