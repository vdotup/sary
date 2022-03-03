//
//  DynamicUICell.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 03/03/2022.
//

import UIKit

class DynamicUICell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    public func configure(catalog: Catalog) {
        
        if catalog.data_type == "smart" {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.spacing = 5
            stack.alignment = .fill
            stack.distribution = .fillEqually
            stack.backgroundColor = .blue
            contentView.addSubview(stack)
            stack.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor)
            
            for data in catalog.data {
                let view = smartGridItem(data: data)
                stack.addArrangedSubview(view)
            }
        } else {
            
        }
        
    }
    
    private func smartGridItem(data: CatalogData) -> UIView {
        let view = SmartGridItemView(frame: .zero)
        view.configure(data: data)
        return view
    }
}

class SmartGridItemView: UIView {
    
    let imageCircleContainer = UIView()
    let imageView = UIImageView()
    let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.anchor(top: imageCircleContainer.topAnchor,
                         leading: imageCircleContainer.leadingAnchor,
                         bottom: imageCircleContainer.bottomAnchor,
                         trailing: imageCircleContainer.trailingAnchor)
        
//        imageCircleContainer.anchor(widthConstant: 75, heightConstant: 75)
        
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        
    }
    
    func configure(data: CatalogData) {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2
        stack.alignment = .fill
        stack.distribution = .fill
        
        imageCircleContainer.backgroundColor = .systemPink
        
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .blue
        imageView.load(url: URL(string: data.image!)!)
        
        imageCircleContainer.addSubview(imageView)
        
        nameLabel.font = nameLabel.font.withSize(10)
        nameLabel.text = data.name
        nameLabel.textAlignment = .center
        
        addSubview(stack)
        stack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        stack.addArrangedSubview(imageCircleContainer)
        stack.addArrangedSubview(nameLabel)
        
    }
}
