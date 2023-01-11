//
//  CustomSwitch.swift
//  Weather
//
//  Created by Filosuf on 14.12.2022.
//

import UIKit

class CustomSwitch: UIControl {

    public var onTintColor = UIColor(red: 144/255, green: 202/255, blue: 119/255, alpha: 1)
    public var offTintColor = UIColor.lightGray
    public var cornerRadius: CGFloat = 0.5

    public var thumbTintColor = UIColor.white
    public var onThumbMaskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    public var offThumbMaskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]

    public var padding: CGFloat = 1

    public var isOn = true
    public var animationDuration: Double = 0.5


    //Labels
    public lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.text = "Right"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()

    public lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.text = "Left"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()

    public var labelOverlapsThumb = false
    public var onThumbLabelTextColor = UIColor.black
    public var offThumbLabelTextColor = UIColor.black
    public var areLabelsShown = false

    private var thumbView = UIView()
    private var isAnimating = false

    private var thumbLeadingConstraint: NSLayoutConstraint!

    private func clear() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }

    //MARK: - Methods
    func setupUI() {
        clear()
        clipsToBounds = false
        thumbView.backgroundColor = thumbTintColor
        thumbView.isUserInteractionEnabled = false
        setShadow(for: thumbView)
        setupLabels()
        layout()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        if !isAnimating {
            layer.cornerRadius = self.bounds.size.height * cornerRadius
            thumbView.layer.cornerRadius = thumbView.frame.height * cornerRadius
            updateView()
        }
    }

    private func updateView() {
        backgroundColor = isOn ? onTintColor : offTintColor

        // thumb management
        thumbLeadingConstraint.constant = isOn ? frame.width / 2 : padding
        thumbView.layer.maskedCorners = isOn ? onThumbMaskedCorners : offThumbMaskedCorners

        // labels management
        if self.labelOverlapsThumb {
            self.leftLabel.textColor = self.isOn ? self.offThumbLabelTextColor : self.onThumbLabelTextColor
            self.rightLabel.textColor = self.isOn ? self.onThumbLabelTextColor : self.offThumbLabelTextColor
        }

    }

    private func animate() {
        isOn = !isOn
        isAnimating = true
        layoutIfNeeded()
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: [UIView.AnimationOptions.curveEaseOut, UIView.AnimationOptions.beginFromCurrentState],
                       animations: {
            self.updateView()
            self.layoutIfNeeded()
        }, completion: { _ in
            self.isAnimating = false
            self.sendActions(for: UIControl.Event.valueChanged)
        })
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        animate()
        return true
    }

    private func setupLabels() {
        guard areLabelsShown else {
            rightLabel.alpha = 0
            leftLabel.alpha = 0
            return
        }
        rightLabel.alpha = 1
        leftLabel.alpha = 1
    }

    private func setShadow(for thumbView: UIView) {
        thumbView.layer.shadowColor = UIColor.black.cgColor
        thumbView.layer.shadowRadius = 1.5
        thumbView.layer.shadowOpacity = 0.4
        thumbView.layer.shadowOffset = CGSize(width: 0.75, height: 2)
    }

    private func layout() {
        addSubview(thumbView)

        if labelOverlapsThumb {
            addSubview(leftLabel)
            addSubview(rightLabel)
        } else {
            insertSubview(leftLabel, belowSubview: thumbView)
            insertSubview(rightLabel, belowSubview: thumbView)
        }

        [thumbView, leftLabel, rightLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        thumbLeadingConstraint = thumbView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding)

        NSLayoutConstraint.activate([
            thumbView.heightAnchor.constraint(equalTo: heightAnchor, constant: -padding * 2),
            thumbView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            thumbLeadingConstraint,
            thumbView.centerYAnchor.constraint(equalTo: centerYAnchor),

            leftLabel.heightAnchor.constraint(equalTo: heightAnchor),
            leftLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            rightLabel.heightAnchor.constraint(equalTo: heightAnchor),
            rightLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            rightLabel.leadingAnchor.constraint(equalTo: centerXAnchor),
            rightLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

}
