//
//  ViewController.swift
//  RedditApp
//
//  Created by Nayna on 4/7/21.
//

import UIKit
import SVProgressHUD
import SDWebImage

class ViewController: UIViewController {
    
    var data: [PostModel] = []
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utility.showProgress()
        PostRequest.getDataApiCall { (list) in
            Utility.dismissProgress()
            self.data = list
            self.table.reloadData()
        }
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DataTableViewCell
        let obj = self.data[indexPath.row]
        
        cell.commentLabel.text = "\(obj.num_comments ?? 0) comments"
        cell.upvoteLabel.text =  "\(obj.likes ?? 0)"
        
        cell.titleLabel?.text = obj.title
        cell.feedImage.layer.cornerRadius = 25
        cell.feedImage.clipsToBounds = true
        if let url = URL(string: obj.image ?? "") {
            cell.feedImage.sd_setImage(with: url) { (image, error, type, url) in
                if let image = image {
                    cell.feedImage.image = image
                }
            }
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        let obj = self.data[indexPath.row]
        vc.obj = obj
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
