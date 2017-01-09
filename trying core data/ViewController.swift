//
//  ViewController.swift
//  trying core data
//
//  Created by Rohan Lokesh Sharma on 09/01/17.
//  Copyright © 2017 webarch. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var managedContext:NSManagedObjectContext!
    
    
    @IBOutlet var myTableView:UITableView!

    
    var data = [Rohan]()
 //   var data = ["rohan","sharma","is","my","name"];
    
    override func viewDidLoad() {
        
        
        
        
        managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        
       /* if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            managedContext = appDelegate.persistentContainer.viewContext
        }*/
        
        myTableView.delegate = self;
        myTableView.dataSource = self;
        loadData()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose  of any resources that can be recreated.
    }
    
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell");
        let item = data[indexPath.row];
        
        cell?.textLabel?.text = item.name
        return cell!;
        
    }
    @IBAction func addRow(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "Enter row", message: "enter the desired indo", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: {(field:UITextField) in
        
            field.placeholder = "Enter text"
        
        })
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
        
        let field = alert.textFields?.first
            if(field?.text != "")
            {
                
                if let text = field?.text
                {
                  self.saveData(text: text)
                    
                }
               
            }
            
           
            
            self.myTableView.reloadData()
            
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        
        
        present(alert, animated: true, completion: nil)
        
        
        
    }
    
    func saveData(text:String)
    {
        

        let some = Rohan(context:managedContext)
        some.name = text;
        
        do{
            
            try self.managedContext.save()
            
        }
        catch
        {
            print("error")
            
        }
        
    }
    
    func loadData()
    {
        
        let req:NSFetchRequest<Rohan> = Rohan.fetchRequest()
        do
        {
            
            try data = managedContext.fetch(req);
            self.myTableView.reloadData()
            
        }
        catch
        {
            print("error")
        }
        
        
    }
    
    
    
    @IBAction func reloadData(_ sender: Any) {
        loadData()
    }
    
    
    
}


