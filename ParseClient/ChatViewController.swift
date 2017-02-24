//
//  ChatViewController.swift
//  ParseClient
//
//  Created by David Yuan on 2/23/17.
//  Copyright © 2017 David Yuan. All rights reserved.
//

import UIKit
import Parse
class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageField: UITextField!
    //@IBOutlet weak var textLabel: UILabel!
    @IBAction func sendButton(_ sender: Any) {
        let mess = PFObject(className: "Message")
        mess["text"] = messageField.text
        mess["user"] = PFUser.current()
        mess.saveInBackground { (bo: Bool, error: Error?) in
            
        }
        
    }
    var array: [PFObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return array.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageTableViewCell") as! messageTableViewCell
        let element = array[indexPath.row]
        let post = element.value(forKey: "text")
        
        cell.messageLabel.text = post as? String;
        return cell
    }
    func onTimer() {
        let query = PFQuery(className:"Message")
        query.whereKey("user", equalTo: PFUser.current()!)
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(objects!.count) ")
                   self.array = objects!
                
                // Do something with the found objects
                
                /*if let objects = objects {
                    for object in objects {
                        print(object.objectId)
                    }
                }*/
            } else {
                // Log details of the failure
                
            }
            self.tableView.reloadData()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
