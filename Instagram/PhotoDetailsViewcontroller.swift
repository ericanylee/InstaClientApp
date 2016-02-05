//
//  PhotoDetailsViewcontroller.swift
//  Instagram
//
//  Created by Erica Lee on 2/4/16.
//  Copyright © 2016 Erica Lee. All rights reserved.
//

import UIKit

class PhotoDetailsViewcontroller: UIViewController {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var pic: UIImageView!
    var photo: [NSDictionary]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var vc = segue.destinationViewController as PhotoDetailsViewController
        var indexPath = tableView.indexPathForCell(sender as UITableViewCell)

        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
*/
}
