//
//  RepositoryCell.swift
//  BitbucketPublicProject
//
//  Created by Khant Zaw Win on 19/6/21.
//

import UIKit

class RepositoryCell: UITableViewCell {
    
    @IBOutlet weak var repositoryFullNameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var ownerAvaterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        ownerAvaterImageView.image = nil
    }
    
    func setData(repository: Repository) {
        
        self.repositoryFullNameLabel?.text = repository.full_name
        self.typeLabel?.text = "Type : \(repository.type)"
        self.createdDateLabel?.text = "Created On : \(repository.formatted_created_on())"
        self.ownerNameLabel?.text = "Owner : \(repository.owner.display_name)"
        
        self.ownerAvaterImageView.load(urlString: repository.owner.links.avatar.href, placeHolderImage: UIImage(named: "default")!)
        
    }

}
