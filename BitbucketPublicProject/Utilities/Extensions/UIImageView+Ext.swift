//
//  UIImage+Ext.swift
//  BitbucketPublicProject
//
//  Created by Khant Zaw Win on 19/6/21.
//

import UIKit

extension UIImageView {
    func load(urlString: String, placeHolderImage:UIImage) {
        
        self.image = placeHolderImage
        
        NetworkManager.shared.downloadImage(fromURLString: urlString) { uiImage in
            DispatchQueue.main.async {
                guard let uiImage = uiImage else {
                    self.image = placeHolderImage
                    return
                }
                    self.image = uiImage
            }
        }
        
    }
}
