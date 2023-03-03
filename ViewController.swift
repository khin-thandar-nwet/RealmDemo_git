//
//  ViewController.swift
//  RealmDB_git
//
//  Created by MSIS SWH on 02/03/2023.
//

import UIKit
import RealmSwift
class ViewController: UIViewController {
    @IBOutlet weak var stuName: UITextField!
    @IBOutlet weak var stuadd: UITextField!
    
    
    @IBOutlet weak var stuView: UITextView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm=try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        // Do any additional setup after loading the view.
    }
    private lazy var dbViewModel: RealMViewModel = {
           let vm = RealMViewModel()
           vm.delegate = self
           return vm
       }()
    
    
    

    @IBAction func BtnSave(_ sender: UIButton) {
        print("hi save")
        var mystudent=Student()
        //Writing Data
        mystudent.name=stuName.text// ?? """Puccy3"
        mystudent.address=stuadd.text// ?? ""//"Male"
      
        /* try! realm.write{
             realm.add(myCat)
         }*/
         
        dbViewModel.saveRecord(student: mystudent)
    }
    

    @IBAction func BtnFetch(_ sender: UIButton) {
        stuView.text=""
        var Students = [Student]()
       // let realm=try! Realm()
       // print(Realm.Configuration.defaultConfiguration.fileURL)
              
        
              
                /*Reading data
                //let results=realm.objects(Cat.self).filter("name=='kitty'")
                let results=realm.objects(Cat.self).filter("color=='gray'")
                print(results.count)
                let results2=realm.objects(Cat.self)
                 print(results2[0].name)
        */
       Students=dbViewModel.fetchStudents()//(cat: myCat)
        //print(Cats)
        for  s in Students
        {
           // print(c, "rr")
            stuView.text+="Name: "+s.name!+" Address: "+s.address!+"\n"
        }
    }
}

// MARK: RealMViewModelDelegate Methods
extension ViewController: RealMViewModelDelegate {
    func RecordSaved() {
       stuName.text = ""
        stuadd.text = ""
     
        
        
        self.showToast(message: "Record saved in RealM DB", font: .systemFont(ofSize: 12.0))
        print("Save data 1")
        }

    func RecordSavingFailed(error: NSError) {
        //self.view.makeToast(error.localizedDescription, duration: 3.0, position: .bottom, style: style)
        print("Fail data 1")
    }
}
extension UIViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }


