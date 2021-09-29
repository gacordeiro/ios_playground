//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    var messages: [Message] = []
    var shouldAnimate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
        //        tableView.delegate = self
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        loadMessages()
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let body = messageTextfield.text, let sender = Auth.auth().currentUser?.email {
            messageTextfield.text = ""
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: sender,
                K.FStore.bodyField: body,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore: \(e)")
                } else {
                    DispatchQueue.main.async { self.messageTextfield.text = "" }
                }
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
    private func loadMessages() {
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
                if let e = error {
                    print("There was an issue getting data from firestore: \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        self.messages = []
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let sender = data[K.FStore.senderField] as? String, let body = data[K.FStore.bodyField] as? String {
                                let message = Message(sender: sender, body: body)
                                self.messages.append(message)
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: self.shouldAnimate)
                                    self.shouldAnimate = true
                                }
                            }
                        }
                    }
                }
        }
    }
}

//MARK: UITableViewDataSource -

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let isItMe = message.sender == Auth.auth().currentUser?.email
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = message.body
        cell.leftImageView.isHidden = isItMe
        cell.rightImageView.isHidden = !isItMe
        cell.messageBubble.backgroundColor = UIColor(named: isItMe ? K.BrandColors.lightPurple : K.BrandColors.purple)
        cell.label.textColor = UIColor(named: isItMe ? K.BrandColors.purple : K.BrandColors.lightPurple)
        return cell
    }
}

//MARK: UITableViewDelegate -
//
//extension ChatViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//    }
//}
