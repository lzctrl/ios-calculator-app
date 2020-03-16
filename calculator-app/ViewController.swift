//
//  ViewController.swift
//  calculator-app
//
//  Created by Mikhail Lozovyy on 3/15/20.
//  Copyright © 2020 Mikhail Lozovyy. All rights reserved.
//

import UIKit

private let calculatorReuseIdentifier = "calculatorID"

class ViewController: UIViewController {
    
    let calculatorItems = ["AC", "", "+/-", "/", "7", "8", "9", "x", "4", "5", "6", "-", "1", "2", "3", "+", "0", "="]
    
    var a: Int = 0
    var b: Int = 0
    
    var answer: Double = 0.0
    
    var currentState: String = ""
    
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionview.delegate = self
        collectionview.dataSource = self
    }
    
    func resetCalc() {
        a = 0
        b = 0
        
        answer = 0.0
        
        currentState = ""
        
        answerLabel.text = "\(0)"
    }
    
    func numSelected(index: IndexPath) {
        if currentState == "" || currentState == "answered" {
            if a != 0 {
                var aString = String(a)
                aString += calculatorItems[index.row]
                if let aS = Int(aString) {
                    a = aS
                }
                answerLabel.text = "\(a)"
            } else {
                a = Int(calculatorItems[index.row])!
                answerLabel.text = "\(a)"
            }
            
            answer = 0.0
        } else {
            if b != 0 {
                var bString = String(b)
                bString += calculatorItems[index.row]
                if let bS = Int(bString) {
                    b = bS
                }
                answerLabel.text = "\(b)"
            } else {
                b = Int(calculatorItems[index.row])!
                answerLabel.text = "\(b)"
            }
            
        }
    }
    
    func symbolSelected(index: IndexPath) {
        currentState = calculatorItems[index.row]
    }
    
    func updateNumNegPos() {
        if currentState == "" {
            a *= -1
            answerLabel.text = "\(a)"
        } else {
            b *= -1
            answerLabel.text = "\(b)"
        }
    }
    
    func calculate() {
        let aDouble = Double(a)
        let bDouble = Double(b)
        if currentState == "/" {
            if answer != 0 {
                answer /= bDouble
            } else {
                answer = aDouble / bDouble
            }
        } else if currentState == "x" {
            if answer != 0 {
                answer *= bDouble
            } else {
                answer = aDouble * bDouble
            }
        } else if currentState == "+" {
            if answer != 0 {
                answer += bDouble
            } else {
                answer = aDouble + bDouble
            }
        } else if currentState == "-" {
            if answer != 0 {
                answer -= bDouble
            } else {
                answer = aDouble - bDouble
            }
        }
        
        if checkInt(x: answer) {
            answerLabel.text = "\(Int(answer))"
        } else {
            answerLabel.text = "\(answer)"
        }
        
        currentState = "answered"
        
        a = 0
        b = 0
    }
    
    func checkInt(x: Double) -> Bool {
        return x.truncatingRemainder(dividingBy: 1) == 0
    }
}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calculatorItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: calculatorReuseIdentifier, for: indexPath) as! CalculatorItemCell
        
        cell.itemLabel.text = calculatorItems[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            resetCalc()
        case 2:
            updateNumNegPos()
        case 3:
            symbolSelected(index: indexPath)
        case 4:
            numSelected(index: indexPath)
        case 5:
            numSelected(index: indexPath)
        case 6:
            numSelected(index: indexPath)
        case 7:
            symbolSelected(index: indexPath)
        case 8:
            numSelected(index: indexPath)
        case 9:
            numSelected(index: indexPath)
        case 10:
            numSelected(index: indexPath)
        case 11:
            symbolSelected(index: indexPath)
        case 12:
            numSelected(index: indexPath)
        case 13:
            numSelected(index: indexPath)
        case 14:
            numSelected(index: indexPath)
        case 15:
            symbolSelected(index: indexPath)
        case 16:
            numSelected(index: indexPath)
        case 17:
            calculate()
        default:
            print("Nothing")
        }
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionWidth = collectionView.frame.width
        let numPerRow = CGFloat(4.0)
        let width = (collectionWidth / numPerRow) - 10
        return CGSize(width: width, height: width)
        
        // TODO: Adjust the last row item sizes
        //        if indexPath.row < (calculatorItems.count - 3) {
        //
        //        } else {
        //            if indexPath.row == (calculatorItems.count - 3) {
        //                let collectionWidth = collectionView.frame.width
        //                let numPerRowWidth = CGFloat(2.0)
        //                let width = (collectionWidth / numPerRowWidth) - 13
        //                let numPerRowHeight = CGFloat(4.0)
        //                let height = (collectionWidth / numPerRowHeight) - 10
        //                return CGSize(width: width, height: height)
        //            } else {
        //                let collectionWidth = collectionView.frame.width
        //                let numPerRow = CGFloat(4.0)
        //                let width = (collectionWidth / numPerRow) - 10
        //                return CGSize(width: width, height: width)
        //            }
        //        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
}
