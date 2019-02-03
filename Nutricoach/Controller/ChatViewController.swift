//
//  ChatViewController.swift
//  Nutricoach
//
//  Created by Milan Vidojevic on 10/25/18.
//  Copyright © 2018 Milan Vidojevic. All rights reserved.
//

import UIKit
import MessageKit
import MessageInputBar
import Firebase

class ChatViewController: MessagesViewController, UITextFieldDelegate, MessageInputBarDelegate {

    var userID = Auth.auth().currentUser?.uid
    private var messages: [Message] = []
    var database = Database.database().reference()
    var displayName : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        userID = Auth.auth().currentUser?.uid
        database = Database.database().reference()
        
        database.child("users").child(userID!).child("hasUnreadMessages").setValue("false")
        fetchMessages()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    //TODO: fetch messages and add them to [messages] Array
    func fetchMessages(){
        database.child("users").child(userID!).child("messages").observe(.childAdded) { (snapshot) in
            let text = snapshot.childSnapshot(forPath: "text").value as! String
            let senderID = snapshot.childSnapshot(forPath: "senderID").value as! String
            let timestamp = snapshot.childSnapshot(forPath: "timestamp").value as! String
            let date = Date(timeIntervalSince1970: TimeInterval("\(timestamp)")!)
            
            let message = Message(sender: Sender(id: senderID, displayName: ""), messageId: snapshot.key, sentDate: date, kind: MessageKind.text(text))
            self.insertNewMessage(message)
        }
    }
    
    private func insertNewMessage(_ message: Message) {
        
        messages.append(message)
        messagesCollectionView.reloadData()
        
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToBottom(animated: true)
        }
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        let message = ["text": text, "senderID": userID!, "timestamp": "\(NSDate().timeIntervalSince1970)"]
        database.child("users").child(userID!).child("messages").childByAutoId().setValue(message)
        inputBar.inputTextView.text = ""
    }
    
}

extension ChatViewController: MessagesDataSource {
    
    func currentSender() -> Sender {
        return Sender(id: userID!, displayName: displayName)
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
}

extension ChatViewController: MessagesDisplayDelegate{
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath,
                         in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? UIColor(red:0.00, green:0.52, blue:1.00, alpha:1.0) : UIColor(red:0.94, green:0.94, blue:0.94, alpha:1.0)
    }
    
    func shouldDisplayHeader(for message: MessageType, at indexPath: IndexPath,
                             in messagesCollectionView: MessagesCollectionView) -> Bool {
        
        return false
    }

    func messageStyle(for message: MessageType, at indexPath: IndexPath,
                      in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(corner, .pointedEdge)
    }
    
}

extension ChatViewController: MessagesLayoutDelegate{
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath,
                    in messagesCollectionView: MessagesCollectionView) -> CGSize {
        
        return .zero
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        avatarView.isHidden = true
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.textMessageSizeCalculator.incomingAvatarSize = .zero
        }
    }
    
    func footerViewSize(for message: MessageType, at indexPath: IndexPath,
                        in messagesCollectionView: MessagesCollectionView) -> CGSize {
        
        return CGSize(width: 0, height: 0)
    }
    
    func heightForLocation(message: MessageType, at indexPath: IndexPath,
                           with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return 0
    }
}
