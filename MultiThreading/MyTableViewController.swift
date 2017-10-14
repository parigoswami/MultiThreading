//
//  MyTableViewController.swift
//  MultiThreading
//
//  Created by pari on 13/10/17.
//  Copyright © 2017 pari. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {

    
    var nameArr : [String] = []
    var imgArr : [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //https://api.myjson.com/bins/vi56v
        //http://www.androidbegin.com/tutorial/jsonparsetutorial.txt
        guard let url = URL(string: "http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors") else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if (error == nil && data != nil){
                guard let data = data else {return}
                
                do{
                    let actors = try JSONDecoder().decode(Actors.self, from: data)
                    OperationQueue.main.addOperation {
                        var tempImg : UIImage?
                        for each in actors.actors{
                            print(each.name)
                            self.nameArr.append(each.name)
                            guard let url = URL(string: each.image) else {return}
                            guard let data = try? Data(contentsOf: url) else {return}
                            tempImg = UIImage(data: data)
                            self.imgArr.append(tempImg!)
                        }
                        self.tableView.reloadData()
                    }

                }catch{
                    print(error.localizedDescription)
                }
                
            }
            
            
            }.resume()
        tableView.reloadData()
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count
    }
    
    override public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 150
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Reuse Identifier", for: indexPath) as? TableViewCell else{return UITableViewCell() }
        cell.myLabel.text = nameArr[indexPath.row]
        cell.imageView?.image = imgArr[indexPath.row]
        print(cell.myLabel.text!)
        
        return cell
    }


}

class Actors : Codable{
    let actors : [Actor]
    init(actors:[Actor]) {
        self.actors=actors
    }
}

class Actor : Codable {
    let name : String
    let dob : String
    let image : String
    init(name:String,dob:String,image:String) {
        self.name = name
        self.dob = dob
        self.image = image
    }
}
