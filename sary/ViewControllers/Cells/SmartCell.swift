//
//  SmartCell.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 04/03/2022.
//

import UIKit

class SmartCell: UITableViewCell {
    
    let stack = UIStackView()
    var items: [SmartGridItemView] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = false
        selectionStyle = .none
     
        stack.axis = .horizontal
        stack.spacing = 5
        stack.alignment = .fill
        stack.distribution = .fillEqually
        contentView.addSubview(stack)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        stack.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor)
        
        
    }
    
    public func configure(catalog: Catalog) {
        for data in catalog.data {
            let view = SmartGridItemView(frame: .zero)
            view.configure(data: data)
            items.append(view)
            stack.addArrangedSubview(view)
        }
    }
}

class SmartGridItemView: UIView {
    
    var stack: UIStackView!
    var imageCircleContainer: UIView!
    var imageView: UIImageView!
    var nameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2
        stack.alignment = .fill
        stack.distribution = .fill
        
        imageCircleContainer = UIView()
        
        imageCircleContainer.layer.shadowColor = UIColor.black.cgColor
        imageCircleContainer.layer.shadowOpacity = 1
        imageCircleContainer.layer.shadowOffset = .zero
        imageCircleContainer.layer.shadowRadius = 5
        //imageCircleContainer.layer.masksToBounds = true
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        
        imageCircleContainer.addSubview(imageView)
        
        nameLabel = UILabel()
        nameLabel.font = UIFont(name: "Sari-Bold", size: 12)
        nameLabel.textAlignment = .center
        
        addSubview(stack)
        stack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        stack.addArrangedSubview(imageCircleContainer)
        stack.addArrangedSubview(nameLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageCircleContainer.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        imageCircleContainer.layer.cornerRadius = imageCircleContainer.frame.size.width / 2
        
        imageView.anchor(top: imageCircleContainer.topAnchor,
                         leading: imageCircleContainer.leadingAnchor,
                         bottom: imageCircleContainer.bottomAnchor,
                         trailing: imageCircleContainer.trailingAnchor,
                         padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    func configure(data: CatalogData) {
        imageView.load(url: URL(string: data.image!)!)
        nameLabel.text = data.name
    }
}
