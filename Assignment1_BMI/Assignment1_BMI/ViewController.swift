//
//  ViewController.swift
//  Assignment1_BMI
//
//  Created by Ishika on 2025-02-02.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var heightUnits = ["cm", "in"]
    var weightUnits = ["kg", "lb"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerview_height.dataSource=self
        pickerview_height.delegate=self
        pickerview_height.tag=1
        
        pickerview_weight.dataSource=self
        pickerview_weight.delegate=self
        pickerview_weight.tag=2
        
        textfield_Height.placeholder="Height(centimeters)"
        textfield_Weight.placeholder="Weight(kilograms)"
        label_Result.text = ""
        label_Value.text = ""
    }
    
    @IBOutlet weak var textfield_Height: UITextField!
    
    
    @IBOutlet weak var textfield_Weight: UITextField!
    
    @IBAction func BtnCompute(_ sender: Any) {
        
        if textfield_Height.text == nil || textfield_Height.text!.trimmingCharacters(in: .whitespaces).isEmpty ||
                   textfield_Weight.text == nil || textfield_Weight.text!.trimmingCharacters(in: .whitespaces).isEmpty {
                        label_Result.text = "Please enter both your height and weight."
                        label_Value.text = ""
                    return
                    }
                
        if let heightI = Double(textfield_Height.text!), let weight = Double(textfield_Weight.text!)
            {
                    if heightI <= 0 || weight <= 0 {
                        label_Result.text = "Height and weight must be positive values."
                        label_Value.text = ""
                        return
                    }
            if pickerview_height.selectedRow(inComponent: 0) == 0{
                if heightI > 400 || weight > 200{
                    label_Result.text="Please enter a valid number"
                    return
                }
            }else{
                if heightI > 800 || weight > 200{
                    label_Result.text="Please enter a valid number"
                    return
                }
            }
            
            var bmi:Double
            if pickerview_height.selectedRow(inComponent: 0)==0 && pickerview_weight.selectedRow(inComponent: 0)==0{
                bmi = weight/(heightI*heightI/10000)
            }else{
                bmi = (weight/(heightI*heightI))*703
            }
            label_Value.text="\(bmi)"
            label_Result.text = "Your BMI category is: \(bmiCategories(a: bmi))"
            
        }else{
            label_Result.text = "Please enter your height and weight"
            return
        }
        
        
    }
    
    
    @IBAction func BtnReset(_ sender: Any) {
        textfield_Weight.text = ""
        textfield_Height.text = ""
        label_Value.text = ""
        label_Result.text = ""
    }
    
    
    @IBOutlet weak var label_Value: UILabel!
    
    
    @IBOutlet weak var label_Result: UILabel!
    
    
    @IBOutlet weak var pickerview_height: UIPickerView!
    
    
    @IBOutlet weak var pickerview_weight: UIPickerView!
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView.tag == 1){
            return heightUnits[row]
        }else{
            return weightUnits[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            let selectedHeight = heightUnits[row]
            if selectedHeight == "cm"{
                pickerview_weight.selectRow(0, inComponent: 0, animated: true)
                textfield_Height.placeholder="Height(centimeters)"
                textfield_Weight.placeholder="Weight(kilograms)"
            }else{
                pickerview_weight.selectRow(1, inComponent: 0, animated: true)
                textfield_Height.placeholder="Height(inches)"
                textfield_Weight.placeholder="Weight(pounds)"
                
            }
        }else{
            let selectedWeight = weightUnits[row]
            if selectedWeight == "kg"{
                pickerview_height.selectRow(0, inComponent: 0, animated: true)
                
            }else{
                pickerview_height.selectRow(1, inComponent: 0, animated: true)
                
            }
        }
    }
    
    //function for checking bmi
    func bmiCategories(a: Double)->String{
        if(a<18.5){
            return "underweight"
        }else if(a>18.5 && a<24.9){
            return "healthy weight"
        }else if(a>25.0 && a<29.9){
            return "overweight"
        }else{
            return "obesity"
        }
    }
}

