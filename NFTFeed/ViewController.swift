//
//  ViewController.swift
//  NFTFeed
//
//  Created by PJ Gray on 12/18/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let infuraDataSource = InfuraDataSource()
    var tableDataSource: UITableViewDiffableDataSource<Int, Message>?
    var messages: [Message] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDataSource()
        
        self.infuraDataSource.delegate = self
        self.infuraDataSource.connect()
    }

}

extension ViewController: InfuraDelegate {
    func didReceiveMessage(_ message: Message?) {
        if let message = message {
            self.messages.insert(message, at: 0)
            var snapshot = NSDiffableDataSourceSnapshot<Int, Message>()
            snapshot.appendSections([0])
            snapshot.appendItems(self.messages, toSection: 0)
            
            // should figure out why this doesn't animate properly. I think its cause it is going in reverse maybe?
            self.tableDataSource?.apply(snapshot, animatingDifferences: false, completion: nil)
        }
    }
}

extension ViewController {
    func configureDataSource() {
        self.tableDataSource = UITableViewDiffableDataSource<Int, Message>(tableView: self.tableView, cellProvider: { (tableView, indexPath, model) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = model.params?.result?.transactionHash
            return cell
        })
    }
}
