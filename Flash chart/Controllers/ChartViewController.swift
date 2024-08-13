//
//  ChartViewController.swift
//  Flash chart
//
//  Created by Chandra Kiran Reddy Yeduguri on 13/04/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChartViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var msgTextField: UITextField!
    
    let db = Firestore.firestore()
    
//    var message: [Message] = [
//        Message(sender: "user1@gmail.com", body: "Hey!"),
//        Message(sender: "user2@gmail.com", body: "Hello!"),
//        Message(sender: "user1@gmail.com", body: "what's up?")
//    ]
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        tableView.delegate = self
        tableView.dataSource = self
//        title = "⚡️FlashChart"
//        navigationItem.hidesBackButton = true
        //Need to register the newly created customised cell nib
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
        
    }
    
    func loadMessages(){
//        message = []
        
        //Old way of approach
        
        //To fetch data only at once you can use .getDocuments
        //db.collection(K.FStore.collectionName).getDocuments { querySnapshot, error in
        
        //To fetch data after every msg sent to firestore use .addSnapshotListener
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { querySnapshot, error in
            
            self.messages = []
            
            if let e = error {
                print("Issue in getting file from Firestore \(e)")
            } else {
                if let snapshotDocument = querySnapshot?.documents {
                    for doc in snapshotDocument {
                        let data = doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
//                                self.tableView.scrollRectToVisible(CGRect(x: 0.0, y: self.tableView.frame.height - 1.0, width: 1.0, height: 1.0), animated: false)
                                let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
                            }
                        
                        }
                    }
                }
            }
        }
        
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = msgTextField.text, let messageSender = Auth.auth().currentUser?.email {
            //Old way of approach
            //Here we are adding time which makes easy to retive data by sorting time
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField : messageSender,
                K.FStore.bodyField : messageBody,
                K.FStore.dateField : Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error{
                    print("Issue in saving data to Firestore \(e)")
                } else {
                    print("Saved Successfully!")
                    //To clear the textfield data after message sent is successfull
                    DispatchQueue.main.async {
                        self.msgTextField.text = ""
                    }
                }
                
            }
            
            // Add a new document with a generated ID
//            do {
//                let ref = try db.collection("").addDocument(data: [
//                    K.FStore.senderField : messageSender,
//                    K.FStore.bodyField : messageBody
//                ])
//              print("Document added with ID: \(ref.documentID)")
//            } catch {
//              print("Error adding document: \(error)")
//            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}


extension ChartViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
//        cell.textLabel?.text = message[indexPath.row].body
//        return cell
        
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.messageLable.text = message.body
        
        //This is a message from current sender
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.messageLable.textColor = UIColor(named: K.BrandColors.purple)
        }
        //This is a message from opposite user
        else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.messageLable.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
        return cell
    }
}


//We can use the delegate protocol for user interaction
//extension ChartViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//    }
//}



