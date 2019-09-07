//
//  TimePicker.swift
//  testTextFieldDelegate
//
//  Created by Salamender Li on 3/8/19.
//  Copyright © 2019 Salamender Li. All rights reserved.
//

import UIKit

class TimePicker:  UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource{

    var hours: [Int] = []

    var minutes: [Int] = []

    var hour = NSCalendar.current.component(.hour, from: Date())
    
    var minute = NSCalendar.current.component(.minute, from: Date())

    override init(frame: CGRect) {
        super.init(frame: frame)
        timePickerSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func timePickerSetup(){
        for i in 0...23{
            hours.append(i)
        }
        
        for i in 0...59{
            minutes.append(i)
        }
        
        self.delegate = self
        self.dataSource = self
        selectRow(hours.firstIndex(of: hour)!, inComponent: 0, animated: true)
        selectRow(minutes.firstIndex(of: minute)!, inComponent: 1, animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return hours.count
        case 1:
            return minutes.count

        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(hours[row])"
        case 1:
            if minutes[row] < 10 {
                return "0\(minutes[row])"
            }else{
                return "\(minutes[row])"
            }
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        minute = minutes[self.selectedRow(inComponent: 1)]
        hour = hours[self.selectedRow(inComponent: 0)]
    }

}
