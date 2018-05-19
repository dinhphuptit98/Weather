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
    @IBOutlet weak var collectionHeaderView: UICollectionView!
    
    
    var weatherdays : [WeatherDay] = []
    var weatherhours : [Weather24h] = []
    
    
    let urlGif1 = "https://media1.giphy.com/media/qRY3cPYRkyQh2/giphy.gif" // mây giông //
    let urlGif2 = "https://media3.giphy.com/media/YNk9HRcH9zJfi/giphy.gif" // đêm //
    let urlGif3 = "https://media.giphy.com/media/l0Iy2x1FicLn45JGE/giphy.gif" // ngày //
    let urlGif4 = "https://media0.giphy.com/media/vB7WSUfplJahO/giphy.gif" // hoàng hôn //
    let urlGif5 = "https://media.giphy.com/media/ZMUibJXDlqbVC/giphy.gif" // bình minh //
    let urlGif6 = "https://media.giphy.com/media/l0Iy5fjHyedk9aDGU/giphy.gif" // mưa //
    let urlGif7 = "https://media.giphy.com/media/CufLv1T7gIPC/giphy.gif" //sét //
    let urlGif8 = "https://media0.giphy.com/media/qq5gwamAHVofm/giphy.gif" // mây //
    let urlGif9 = "https://media3.giphy.com/media/ZWRCWdUymIGNW/giphy.gif" // sương mù //
    let urlGif10 = "https://media.giphy.com/media/pUTySboTV9ZWo/giphy.gif" //cối xay gió
    
    var speedWind : String?
    var dirWind : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // notifi weatherDay
        NotificationCenter.default.addObserver(self , selector: #selector(handler1), name: Notification.Name.init("update1"), object: nil)
        DataService.shared.getDataDay()
        
        //notifi weather24h
        NotificationCenter.default.addObserver(self , selector: #selector(handler2), name: Notification.Name.init("update2"), object: nil)
        DataService.shared.getDataHour()
        
        //layout colectionView
        collectionHeaderView.setup_horizotal(numberOfItems: 4, padding: 10)
        
        tempText.textColor = UIColor.yellow
        
        
       
        
       
    }
    
    
    @objc func handler1(){
        guard let weather = DataService.shared.weather else { return  }
        weatherdays = weather.weatherDays
        if weather.name == "Hanoi" {
            nameText.text = "Hà Nội"
        }
        inforText.text = weather.text
        if inforText.text == "Sương mù"{
            getGif(urlString: urlGif9)
            inforText.textColor = UIColor.black
            nameText.textColor = UIColor.black
            
        }
        if inforText.text == "Nhiều nắng" || inforText.text == "Trời quang" || inforText.text == "Có Mây"{
            getGif(urlString: urlGif8)
            inforText.textColor = UIColor.black
            nameText.textColor = UIColor.black
            
        }
        if inforText.text == "Mưa nhẹ lả tả trong khu vực có sấm sét" || inforText.text == "Mưa vừa hoặc nặng hạt trong khu vực có sấm sét" {
            getGif(urlString: urlGif7)
            inforText.textColor = UIColor.white
            nameText.textColor = UIColor.white
            

        }
        if inforText.text == "Các cơn giông tố nổi lên gần đó" {
            getGif(urlString: urlGif1)
            inforText.textColor = UIColor.white
            nameText.textColor = UIColor.white
            

        }
        if inforText.text == "Mưa lả tả gần" || inforText.text == "Mưa nhẹ" || inforText.text == "Mưa rào nhẹ" || inforText.text == "Mưa rào vừa hoặc nặng hạt" || inforText.text == "Thỉnh thoảng mưa vừa"{
            getGif(urlString: urlGif6)
            inforText.textColor = UIColor.white
            nameText.textColor = UIColor.white
            

        }

        
        tempText.text = "\(weather.temp_c) ℃ "
        
        tableView.reloadData()
    }
    
    @objc func handler2() {
        guard let hour = DataService.shared.weatherOneDay else { return  }
        weatherhours = hour.weatherHours
        collectionHeaderView.reloadData()
        speedWind = weatherhours[0].windspeedKmph
        dirWind = weatherhours[0].winddir16Point
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // table View , show at cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < weatherdays.count {
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
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! CustomTableViewCell2
            cell.cloudLabel.text = dirWind
            cell.speedCloud.text = speedWind
            cell.cloudImage.getGifCell(urlString: urlGif10)
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return collectionHeaderView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var hieght = 0
        if indexPath.row == weatherdays.count {
             hieght = 150
        }else if indexPath.row < weatherdays.count {
            hieght = 50
        }
        return CGFloat(hieght)
    }
    
    
    // colectionView
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherhours.count - 1 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionHeaderView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.timeAtNow.text = "\(toInt(from: weatherhours[indexPath.row + 1].time)!):00"
        cell.iconHour.download(from: weatherhours[indexPath.row + 1].value)
        cell.tempCHour.text = "\(weatherhours[indexPath.row + 1].tempC)℃"
        
        return cell
    }
    func toInt (from string: String?) -> Int? {
        if string != nil && string != "" {
            return (Int(string!))!/100
        }
        else {
            return nil
        }
    }
    func getGif(urlString : String) {
        if let url = URL(string: urlString){
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.backgr.image = UIImage.animatedImage(data: data)
                    }
                }
                
            }
        }

    }
}


