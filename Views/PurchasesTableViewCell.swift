//
//  PurchasesTableViewCell.swift
//  BudgetTracker
//
//  Created by DeQuan Douglas on 9/7/21.
//

import UIKit

class PurchasesTableViewCell: UITableViewCell {
    

    //MARK: Properties
    static let identifier = "PurchasesTableViewCell"
    
    static let preferredHeight: CGFloat = 75
    
    struct ViewModel {
        let date: String
        let image: UIImage
        let description: String
        let price: String
        var uniqueLabel: Int
        
    }
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    private let categoryImage: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    //MARK: Cell Creation
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        backgroundColor = .systemBackground
        addSubview(dateLabel)
        addSubview(descriptionLabel)
        addSubview(categoryImage)
        addSubview(priceLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    
    override func layoutSubviews() {
        let imageSize = contentView.height / 1.4
        
        categoryImage.frame = CGRect(x: separatorInset.left,
                                     y: (contentView.height - imageSize) / 2,
                                     width: imageSize,
                                     height: imageSize)
        let availableWidth: CGFloat = contentView.width - separatorInset.left - imageSize - 15
        dateLabel.frame = CGRect(x: categoryImage.right + 5,
                                 y: contentView.height - 40,
                                 width: availableWidth,
                                 height: 40)
        priceLabel.sizeToFit()
        priceLabel.frame = CGRect(x: contentView.width / 1.25,
                                  y: contentView.height / 3,
                                  width: availableWidth,
                                  height: priceLabel.height)
        descriptionLabel.sizeToFit()
        descriptionLabel.frame = CGRect(x: categoryImage.right + 5,
                                        y: 4,
                                        width: availableWidth,
                                        height: descriptionLabel.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
        descriptionLabel.text = nil
        categoryImage.image = nil
    }
    
    public func configure(with viewModel: ViewModel) {
        dateLabel.text = viewModel.date
        descriptionLabel.text = viewModel.description
        categoryImage.image = viewModel.image
        priceLabel.text = viewModel.price
    }
}
