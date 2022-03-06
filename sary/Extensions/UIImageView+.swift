//
//  UIImageView.swift
//  sary
//
//  Created by Abdurrahman Alfudeghi on 03/03/2022.
//

import UIKit

extension UIImageView {
    func load(url: URL, completion: (() -> ())? = nil) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        if let completion = completion {
                            completion()
                        }
                    }
                }
            }
        }
    }
}
