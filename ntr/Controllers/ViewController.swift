//
//  ViewController.swift
//  ntr
//
//  Created by Oleg Pavlichenkov on 19/10/2017.
//  Copyright © 2017 Oleg Pavlichenkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var apiClient: ApiClient!
    var pos: PoinfOfSale!
    
    // MARK: Outlets
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var dateOpenedLabel: UILabel!
    @IBOutlet weak var addressTextView: UITextView!
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiClient = ApiClient.shared
        apiClient.getSearchResults { (pos, error) in
            if let error = error, !error.isEmpty {
                print("==== Error: \(error)")
            }
            
            if let pos = pos  {
                self.pos = pos
                self.populateView()
            }
        }
    }
    
    // MARK: Helpers
    func populateView() {
        idLabel.text = pos.id
        nameLabel.text = pos.name
        typeLabel.text = pos.type
        phoneLabel.text = pos.phone
        statusLabel.text = pos.status
        dateOpenedLabel.text = pos.dateOpenedString
//        print(pos.dateOpened)
        addressTextView.text = """
        Address: \(pos.address?.street ?? "") \(pos.address?.house ?? "")
        Coordinates (lng; lat): \(pos.address?.gps_lng ?? 0);\(pos.address?.gps_lat ?? 0)
        """
    }

    
    
}

