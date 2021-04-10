//
//  DetailViewController.swift
//  RedditApp
//
//  Created by Nayna on 4/7/21.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    @IBOutlet weak var lbl_detail: UILabel!
    @IBOutlet weak var img_detail: UIImageView!
    @IBOutlet weak var numverOfCommentLabel_detail: UILabel!
    @IBOutlet weak var upvoteLabel_detail:UILabel!
    @IBOutlet weak var descriptionLabel:UILabel!
    
    var obj: PostModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Reddit"
        navigationController?.navigationBar.barTintColor = UIColor.red
        img_detail.layer.cornerRadius = 25
        img_detail.clipsToBounds = true
        lbl_detail.text = obj.title ?? ""
        descriptionLabel.text = obj.description ?? ""
        numverOfCommentLabel_detail.text = "\(obj.num_comments ?? 0) Comments"
        upvoteLabel_detail.text = "\(obj.likes ?? 0)"
        
        if let url = URL(string: obj.image ?? "") {
            img_detail.sd_setImage(with: url) { (image, error, type, url) in
                if let image = image {
                    self.img_detail.image = image
                }
            }
        }
    }
}
