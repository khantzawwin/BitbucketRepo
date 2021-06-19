//
//  ViewController.swift
//  BitbucketPublicProject
//
//  Created by Khant Zaw Win on 19/6/21.
//

import UIKit

class RepositoryListingViewController: UIViewController {

    @IBOutlet weak var repositoryTableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    
    var repositories: [Repository] = []
    var next_url: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.repositoryTableView.dataSource = self
        self.repositoryTableView.delegate = self
        self.repositoryTableView.rowHeight = UITableView.automaticDimension
        self.repositoryTableView.estimatedRowHeight = 140
        
        self.setData()
    }
    
    func setData() {
        let urlString = self.next_url.count > 0 ? self.next_url : NetworkManager.baseURL
        NetworkManager.shared.getRepositories(fromURLString: urlString) { [self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let repositoryResponse):
                    self.repositories = repositoryResponse.values
                    self.next_url = repositoryResponse.next
                    self.repositoryTableView.reloadData()
                    if self.next_url.count > 0 {
                        self.nextButton.isEnabled = true
                    }
                    else{
                        self.nextButton.isEnabled = false
                    }
                    self.repositoryTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    @IBAction func NextButtonOnClick(_ sender: Any) {
        self.setData()
    }
    
    
}

extension RepositoryListingViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath) as! RepositoryCell
        
        let repository : Repository = repositories[indexPath.row]
        
        cell.setData(repository: repository)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


