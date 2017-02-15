//
//  ViewController.swift
//  MyCoreData
//
//  Created by pxh on 2017/2/13.
//  Copyright © 2017年 pxh. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    @IBOutlet weak var studentNum: UITextField!
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var age: UITextField!
    
    var myContext : NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // Do any additional setup after loading the view, typically from a nib.
        if #available(iOS 10.0, *) {
            myContext = appDelegate.persistenContainer.viewContext
        }else{
            print("iOS 9")
            myContext = appDelegate.managedObjectContext
        }
    }

    @IBAction func addAction(_ sender: UIButton) {
        saveDataYoCoreData()
    }
    
    @IBAction func removeAction(_ sender: UIButton) {
        delDataFromCoreData()
    }
    @IBAction func showData(_ sender: UIBarButtonItem) {
//        let showVC = ShowVC()
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        self.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "返回", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        self.navigationController?.pushViewController(storyboard.instantiateViewController(withIdentifier: "ShowVC"), animated: true)
    }
    //保存数据到CoreData
    func saveDataYoCoreData(){
        do {
            let inserInfo = NSEntityDescription.insertNewObject(forEntityName: "MyStudents", into: myContext)
            if (studentNum.text?.isEmpty)! && (name.text?.isEmpty)! && (age.text?.isEmpty)! {
                let alert = UIAlertController.init(title: "提示", message: "请输入完整的信息", preferredStyle: .alert)
                let okAction = UIAlertAction.init(title: "确定", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }else{
                inserInfo.setValue(Int(studentNum.text!), forKey: "num")
                inserInfo.setValue("\(name.text!)", forKey: "name")
                inserInfo.setValue(Int(age.text!), forKey: "age")
                try myContext.save()
                studentNum.text = ""
                name.text = ""
                age.text = ""
                let alert = UIAlertController.init(title: "提示", message: "保存成功", preferredStyle: .alert)
                let okAction = UIAlertAction.init(title: "确定", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        } catch {
            fatalError()
        }
    }
    func delDataFromCoreData(){
        let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "MyStudents")
        do {
            let rels = try myContext.fetch(request) as! [NSManagedObject]
            for rel in rels {
                myContext.delete(rel)
            }
            try myContext.save()
            let alert = UIAlertController.init(title: "提示", message: "清空数据库成功", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "确定", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        } catch {
            fatalError()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

