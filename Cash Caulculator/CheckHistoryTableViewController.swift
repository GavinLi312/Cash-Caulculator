//
//  CheckHistoryTableViewController.swift
//  Cash Caulculator
//
//  Created by Salamender Li on 8/9/19.
//  Copyright © 2019 Salamender Li. All rights reserved.
//

import Foundation
import UIKit

class CheckHistoryTabkeViewController:UITableViewController{
    
    let fileHelper = FileHelper()
    var fileNames : [String] = []
    let cellHeight :CGFloat =  50
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.backgroundColor
        setNavigationBar()
        fileNames = fileHelper.getAllFileListFromDirectory()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier:Constant.checkHistoryTabkeViewControlleridentifier)
    }
    
    func setNavigationBar(){
        self.navigationItem.title = "History"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.checkHistoryTabkeViewControlleridentifier, for: indexPath)
        cell.textLabel?.text = fileNames[indexPath.row]
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.95)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ImageViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        vc.image = fileHelper.getImage(imageName: (tableView.cellForRow(at: indexPath)?.textLabel!.text)! )
        self.present(vc, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            fileHelper.deleteImage(imageName: (tableView.cellForRow(at: indexPath)?.textLabel!.text)!)
            fileNames = fileHelper.getAllFileListFromDirectory()
            tableView.reloadData()
        default:
            print("don't response")
        }
    }
    
}

