//
//  SmartGridView.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 05/03/2022.
//

import UIKit

class DynamicSmartView: UIView {
    
    var stack: UIStackView!
    var configured: Bool = false
    
    required init(catalog: CatalogViewModel) {
        super.init(frame: .zero)
        
        stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .fill
        stack.distribution = .fillEqually
        addSubview(stack)
        stack.fillSuperview()
        
        self.setup(catalog: catalog)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        anchor(heightConstant: 100)
    }
    
    public func setup(catalog: CatalogViewModel) {
        if configured { return }
        for data in catalog.data {
            let view = SmartGridItemView(frame: .zero)
            view.configure(data: data)
            stack.addArrangedSubview(view)
        }
        configured = true
    }
}

class SmartGridItemView: UIView {
    
    var stack: UIStackView!
    var container: UIView!
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
        
        container = UIView()
        
        imageCircleContainer = UIView()
        imageCircleContainer.backgroundColor = .white
        
        container.addSubview(imageCircleContainer)
        
        imageCircleContainer.layer.shadowColor = UIColor.black.cgColor
        imageCircleContainer.layer.shadowOpacity = 0.10
        imageCircleContainer.layer.shadowOffset = .zero
        imageCircleContainer.layer.shadowRadius = 6
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        
        imageCircleContainer.addSubview(imageView)
        
        nameLabel = UILabel()
        nameLabel.font = UIFont(name: "Almarai-Bold", size: 11)
        nameLabel.textAlignment = .center
        
        addSubview(stack)
        stack.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        stack.addArrangedSubview(container)
        stack.addArrangedSubview(nameLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageCircleContainer.anchor(
                                    centerX: container.centerXAnchor,
                                    centerY: container.centerYAnchor,
                                    widthConstant: 60,
                                    heightConstant: 60)
        
        imageView.anchor(top: imageCircleContainer.topAnchor,
                         leading: imageCircleContainer.leadingAnchor,
                         bottom: imageCircleContainer.bottomAnchor,
                         trailing: imageCircleContainer.trailingAnchor,
                         padding: .init(top: 15, left: 15, bottom: 15, right: 15))
        
        imageCircleContainer.layer.cornerRadius = 30
        
        
    }
    
    func configure(data: CatalogData) {
        imageView.load(url: URL(string: data.image!)!)
        nameLabel.text = data.name
    }
}
