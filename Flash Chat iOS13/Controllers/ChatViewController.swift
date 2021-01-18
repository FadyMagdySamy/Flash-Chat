//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Fady Magdy on 18/01.2021.
//
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    var messages :[Message] = [Message(sender: "1@2.com", body: "Hey!"),
                               Message(sender: "a@b.com", body: "Hello!"),
                               Message(sender: "1@2.com", body: "what's up!")]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadMessages()
        
    }
    
    func loadMessages()  {
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener{ (querySnapshot, error) in
            self.messages = []
            if let e = error{
                print(e.localizedDescription)
            }
            else{
                if let snap = querySnapshot?.documents{
                    for x in snap{
                        let data = x.data()
                        if let messageSender = data[K.FStore.senderField] as? String ,let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            
                            self.messages.append(newMessage)
                            self.messageTextfield.text = ""
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                
                                
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text,let messageSender = Auth.auth().currentUser?.email{
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField : messageSender,
                                                                      K.FStore.dateField:Date().timeIntervalSince1970,
                                                                      K.FStore.bodyField:messageBody]) { (error) in
                if let e = error{
                    print(e.localizedDescription)
                }
                else{
                    print("success")
                }
            }
            
            
        }
    }
    
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            print("log out successfully")
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            
        }
    }
    
}

extension ChatViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell =  tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)  as! MessageCell
        
        if message.sender == Auth.auth().currentUser?.email{
            cell.rightImageView.isHidden = true
            cell.leftImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        }else{
            cell.rightImageView.isHidden = false
            cell.leftImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
        
        
        cell.label.text = message.body
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
}




