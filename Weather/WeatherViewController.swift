//
//  WeatherViewController.swift
//  Weather
//
//  Created by NguyenDinhPhu on 5/17/18.
//  Copyright © 2018 NguyenDinhPhu. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var inforText: UILabel!
    @IBOutlet weak var tempText: UILabel!
    @IBOutlet weak var backgr: UIImageView!
    
    var weatherdays : [WeatherDay] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self , selector: #selector(handler), name: Notification.Name.init("update"), object: nil)
        DataService.shared.getData()
        // Do any additional setup after loading the view.
    }
    @objc func handler(){
        guard let weather = DataService.shared.weather else { return  }
        weatherdays = weather.weatherDays
        if weather.name == "Hanoi" {
            nameText.text = "Hà Nội"
        }
        inforText.text = weather.text
        if inforText.text == "Trời quang"{
            
            inforText.textColor = UIColor.black
            nameText.textColor = UIColor.black
            tempText.textColor = UIColor.yellow
            backgr.image = #imageLiteral(resourceName: "sun")
        }
        if inforText.text == "Có Mây"{
            
            inforText.textColor = UIColor.black
            nameText.textColor = UIColor.black
            tempText.textColor = UIColor.yellow
            backgr.image = #imageLiteral(resourceName: "cloud")

        }
        if inforText.text == "Các cơn giông tố nổi lên gần đó" {
            
            inforText.textColor = UIColor.white
            nameText.textColor = UIColor.white
            tempText.textColor = UIColor.yellow
            backgr.image = #imageLiteral(resourceName: "thunder")
        }
        if inforText.text == "Mưa rào nhẹ" {
            
            inforText.textColor = UIColor.white
            nameText.textColor = UIColor.white
            tempText.textColor = UIColor.yellow
            backgr.image = #imageLiteral(resourceName: "rain")
        }
        if inforText.text == "Mưa rào vừa hoặc nặng hạt" {
            
            inforText.textColor = UIColor.white
            nameText.textColor = UIColor.white
            tempText.textColor = UIColor.yellow
            backgr.image = #imageLiteral(resourceName: "rain")
        }
        
        tempText.text = "\(weather.temp_c) ℃ "
        
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherdays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        cell.minTemp.text = "\(weatherdays[indexPath.row].mintemp_c) ℃"
        cell.maxTemp.text = "\(weatherdays[indexPath.row].maxtemp_c) ℃"
        cell.icon.download(from: weatherdays[indexPath.row].icon)
        return cell
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
