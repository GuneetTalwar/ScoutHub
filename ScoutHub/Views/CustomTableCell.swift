//
//  customTableCell.swift
//  ScoutHub
//
//  Created by guneet talwar on 17/11/23.
//
import Foundation
import UIKit

@IBDesignable
class PaddingLabel: UILabel {
    var textEdgeInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    open override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textEdgeInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textEdgeInsets.top, left: -textEdgeInsets.left, bottom: -textEdgeInsets.bottom, right: -textEdgeInsets.right)
        return textRect.inset(by: invertedInsets)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textEdgeInsets))
    }
    
    @IBInspectable
    var paddingLeft: CGFloat {
        set { textEdgeInsets.left = newValue }
        get { return textEdgeInsets.left }
    }
    
    @IBInspectable
    var paddingRight: CGFloat {
        set { textEdgeInsets.right = newValue }
        get { return textEdgeInsets.right }
    }
    
    @IBInspectable
    var paddingTop: CGFloat {
        set { textEdgeInsets.top = newValue }
        get { return textEdgeInsets.top }
    }
    
    @IBInspectable
    var paddingBottom: CGFloat {
        set { textEdgeInsets.bottom = newValue }
        get { return textEdgeInsets.bottom }
    }
}

import Foundation
import UIKit


class CustomTableCell: UITableViewCell {
    // just to hold hosting controller
    //var host: UIHostingController<AnyView>?

    static let identifier = "CustomCell"

    let repositoryNameLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.text = "Repository Name"
        label.paddingTop = 4
        label.paddingBottom = 4
        return label
    }()
    let repositoryDescriptionLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.text = "This is the repositories description"
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        label.paddingTop = 4
        label.paddingBottom = 4
        //label.adjustsFontSizeToFitWidth = true
        return label
    }()

    let repositoryTopicLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.textColor = .white
        label.backgroundColor = .gray
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.text = "Topic"
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        //label.padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        label.paddingLeft = 10
        label.paddingRight = 10
        label.paddingTop = 4
        label.paddingBottom = 4

        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(){
        self.contentView.addSubview(repositoryNameLabel)
        self.contentView.addSubview(repositoryDescriptionLabel)
        self.contentView.addSubview(repositoryTopicLabel)

        repositoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        repositoryDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        repositoryTopicLabel.translatesAutoresizingMaskIntoConstraints = false
//        let viewsDictionary = ["label1": repositoryNameLabel, "label2": repositoryDescriptionLabel]
//        for label in viewsDictionary.keys {
//            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
//        }
//        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label1]-[label2]-[label3]-[label4]-[label5]", options: [], metrics: nil, views: viewsDictionary))
        NSLayoutConstraint.activate([
            repositoryNameLabel.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            repositoryNameLabel.bottomAnchor.constraint(equalTo: self.repositoryDescriptionLabel.topAnchor),
            repositoryNameLabel.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            repositoryNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),

            repositoryDescriptionLabel.topAnchor.constraint(equalTo: self.repositoryNameLabel.bottomAnchor),
            repositoryDescriptionLabel.bottomAnchor.constraint(equalTo: self.repositoryTopicLabel.topAnchor),
            repositoryDescriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            repositoryDescriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),

            repositoryTopicLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            repositoryTopicLabel.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            repositoryTopicLabel.topAnchor.constraint(equalTo: self.repositoryDescriptionLabel.bottomAnchor),
           // repositoryTopicLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
//            repositoryDescriptionLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
//            repositoryDescriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)

        ])

    }


}
