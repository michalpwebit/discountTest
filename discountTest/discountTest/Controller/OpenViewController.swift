//
//  ViewController.swift
//  discountTest
//
//  Created by michal packter on 19/05/2022.
//

import UIKit

class OpenViewController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var emptyLabel: UILabel!
    
    @IBOutlet var nextButton: CustomButton!
    var timer = Timer()
    var url = String()
    var name = "michal noyman"
    var buttonText = "Next"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }
    override func viewWillAppear(_ animated: Bool) {
        setEmptylabel()
    }
    func setData(){
        nameLabel.text = name
        nextButton.setTitle(buttonText, for: .normal)
        setDate()
        
    }
    func setDate(){
        updateDateLabel()
           timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updateDateLabel), userInfo: nil, repeats: true);

    }
    func setEmptylabel(){
        let userDefaults = UserDefaults.standard

        if let t = userDefaults.string(forKey: "title"){
            emptyLabel.text = t
            emptyLabel.isUserInteractionEnabled = true

            self.url = userDefaults.string(forKey: "link") ?? ""
            let labelTapGesture = UITapGestureRecognizer(target:self,action:#selector(self.emptyLabelClick))
            emptyLabel.addGestureRecognizer(labelTapGesture)
        }

    }
    @objc func emptyLabelClick() {
   
             self.performSegue(withIdentifier: "openWebView", sender: self)
    }
   
    @objc func updateDateLabel() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateLabel.text = dateFormatter.string(from: date)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTabView"{
            
        }else if segue.identifier == "openWebView"{
            let controller = segue.destination as! ShowItemViewController
            controller.selectedItemURL = self.url
        }
    }
    
}

