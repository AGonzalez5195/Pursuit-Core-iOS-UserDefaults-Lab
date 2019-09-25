//
//  ViewController.swift
//  UserDefaultsLab
//
//  Created by Anthony Gonzalez on 9/24/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit

//extension Date {
//    func isBetween(_ date1: Date, and date2: Date) -> Bool {
//        return (min(date1, date2) ... max(date1, date2)) ~= self
//    }
//}

class ViewController: UIViewController {
    @IBOutlet weak var sunsignLabel: UILabel!
    
    @IBOutlet weak var horoscopeText: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var userBdayString = String()
    var userSunsign = "" {
        didSet {
            loadData()
            UserDefaults.standard.set(userSunsign, forKey: "SavedUserSunsign")
        }
    }
    
    @IBAction func setBirthdayButtonPressed(_ sender: UIButton) {
        getDateFromDatePicker()
        getUserSunsign()
    
    }
    
    private func loadData(){
        HoroscopeAPIManager.shared.getHoroscope(urlString: "http://sandipbgt.com/theastrologer/api/horoscope/\(userSunsign)/today/"){ (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let horoscopeData):
                    self.setLabelText(from: horoscopeData)
                    
                }
            }
        }
    }
    
    private func getDateFromDatePicker() {
        let datePickerSelectedDate = "\(datePicker.date)".components(separatedBy: " ")[0]
        let formattedDate =  Date.changeDateFormat(dateString: datePickerSelectedDate, fromFormat: "yyyy-MM-dd", toFormat: "MM/dd/yyyy")
        userBdayString = formattedDate
    }
    
    private func getUserSunsign(){
        let birthdayMonth = Int(userBdayString.components(separatedBy: "/")[0])
        let birthdayDay = Int(userBdayString.components(separatedBy: "/")[1])
        
      
        if let birthDayMonthInt = birthdayMonth {
            if let birthdayDayInt = birthdayDay {
                switch birthDayMonthInt {
                    
                case 1:
                    switch birthdayDayInt { //Jan
                        case 1...20: userSunsign = "capricorn"
                        case 21...31: userSunsign = "aquarius"
                        default: ()
                    }
                    
                case 2:
                    switch birthdayDayInt { //Feb
                        case 1...19: userSunsign = "aquarius"
                        case 20...31: userSunsign = "pisces"
                        default: ()
                    }
                    
                case 3:
                    switch birthdayDayInt { //March
                        case 1...21: userSunsign = "pisces"
                        case 21...31: userSunsign = "aries"
                        default: ()
                    }
                    
                case 4:
                    switch birthdayDayInt { //April
                        case 1...20: userSunsign = "aries"
                        case 21...31: userSunsign = "taurus"
                        default: ()
                    }
                    
                case 5:
                    switch birthdayDayInt {
                        case 1...21: userSunsign = "taurus"
                        case 22...31: userSunsign = "gemini"
                        default: ()
                    }
                    
                case 6:
                    switch birthdayDayInt {
                        case 1...21: userSunsign = "gemini"
                        case 22...31: userSunsign = "cancer"
                        default: ()
                    }
                    
                case 7:
                    switch birthdayDayInt {
                        case 1...23: userSunsign = "cancer"
                        case 24...31: userSunsign = "leo"
                        default: ()
                    }
                    
                case 8:
                    switch birthdayDayInt {
                        case 1...23: userSunsign = "leo"
                        case 24...31: userSunsign = "virgo"
                        default: ()
                    }
                    
                case 9:
                    switch birthdayDayInt {
                        case 1...23: userSunsign = "virgo"
                        case 24...31: userSunsign = "libra"
                        default: ()
                    }
                    
                case 10:
                    switch birthdayDayInt {
                        case 1...23: userSunsign = "libra"
                        case 24...31: userSunsign = "scorpio"
                        default: ()
                    }
                    
                case 11:
                    switch birthdayDayInt {
                        case 1...22: userSunsign = "scorpio"
                        case 23...31: userSunsign = "sagittarius"
                        default: ()
                    }
                    
                case 12:
                    switch birthdayDayInt {
                        case 1...22: userSunsign = "sagittarius"
                        case 23...31: userSunsign = "capricorn"
                        default: ()
                    }
                    
                default: ()
                }
            }
        }
        print(userSunsign)
    }
    
    
    private func setLabelText(from horoscopeSign: Horoscope) {
        sunsignLabel.text = horoscopeSign.sunsign
        horoscopeText.text = horoscopeSign.horoscope
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if  let savedUserSunsign = UserDefaults.standard.string(forKey: "SavedUserSunsign") {
        userSunsign = savedUserSunsign
        }
    }
}

extension Date {
    static func changeDateFormat(dateString: String, fromFormat: String, toFormat: String) ->String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = fromFormat
        let date = inputDateFormatter.date(from: dateString)
        
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = toFormat
        return outputDateFormatter.string(from: date!)
    }
}
