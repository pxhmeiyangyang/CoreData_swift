//
//  ShowVC.swift
//  MyCoreData
//
//  Created by pxh on 2017/2/13.
//  Copyright © 2017年 pxh. All rights reserved.
//

import UIKit
import CoreData
class ShowVC: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context : NSManagedObjectContext!
    let request = NSFetchRequest<NSFetchRequestResult>.init(entityName: "MyStudents")
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "显示"
        // Do any additional setup after loading the view.
        if #available(iOS 10.0, *) {
            context = appDelegate.persistenContainer.viewContext
        }else{
            context = appDelegate.managedObjectContext
        }
        do {
            let rels = try context.fetch(request) as! [NSManagedObject]
            var re = ""
            for rel in rels {
                re += "年龄：\(rel.value(forKey: "age")) \n 姓名：\(rel.value(forKey: "name"))\n 学号：\(rel.value(forKey: "num"))"
            }
            if re.isEmpty {
                print("没找到相关数据")
            }else{
                print(re)
            }
            
        } catch {
            fatalError()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
