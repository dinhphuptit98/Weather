//
//  WeatherViewController.swift
//  Weather
//
//  Created by NguyenDinhPhu on 5/17/18.
//  Copyright © 2018 NguyenDinhPhu. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource ,UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var inforText: UILabel!
    @IBOutlet weak var tempText: UILabel!
    @IBOutlet weak var backgr: UIImageView!
    @IBOutlet weak var dateAtNow: UILabel!
    @IBOutlet weak var collectionHeaderView: UICollectionView!
    
    let timeAtNow = Date()
    
    var weatherdays : [WeatherDay] = []
    var weatherhours : [Weather24h] = []
    
    override func viewDidLoad() {
        dateAtNow.text = "\(timeAtNow)"
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self , selector: #selector(handler1), name: Notification.Name.init("update1"), object: nil)
        DataService.shared.getDataDay()
        
        NotificationCenter.default.addObserver(self , selector: #selector(handler2), name: Notification.Name.init("update2"), object: nil)
        DataService.shared.getDataHour()
        // Do any additional setup after loading the view.
    }
    @objc func handler1(){
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
    
    @objc func handler2() {
        guard let hour = DataService.shared.weatherOneDay else { return  }
        weatherhours = hour.weatherHours
        collectionHeaderView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // table View , show at cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherdays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.date.text = weatherdays[indexPath.row].date_epoch.toDate
        let toDay = Date()
        let format = DateFormatter()
        format.dateFormat = "YYYY-MMMM-d"
        format.string(from: toDay)
        if weatherdays[indexPath.row].date_epoch.toDay == format.string(from: toDay){
            cell.date.text = "HÔM NAY"
            cell.date.textColor = UIColor.red
        }

        cell.minTemp.text = "\(weatherdays[indexPath.row].mintemp_c) ℃"
        cell.maxTemp.text = "\(weatherdays[indexPath.row].maxtemp_c) ℃"
        cell.icon.download(from: weatherdays[indexPath.row].icon)
        return cell
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return collectionHeaderView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
    
    
    // colectionView
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionHeaderView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        return cell
    }
    
}
