//
//  ViewController.swift
//  ExpandableTableView
//
//  Created by pradip gotamay on 2/22/17.
//  Copyright © 2017 Pradip Gotame. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var mArray_cell_item : NSMutableArray = ["Item : 1","Item : 2","Item : 3","Item : 4"]
    var mArray_forBoolValueForCollpaseCell : NSMutableArray = NSMutableArray()
    
    var flagForSectionClicked : Bool = false
    
    var previouslyClickedSectionIndex : Int = 0
    
    var sectionDTO : SectionDTO!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0..<self.mArray_cell_item.count{
            self.sectionDTO = SectionDTO()
            self.sectionDTO.sectionOpenStatus = false
            self.mArray_forBoolValueForCollpaseCell.add(self.sectionDTO)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    /*table view delegate*/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.sectionDTO = self.mArray_forBoolValueForCollpaseCell.object(at: section) as! SectionDTO
        return (self.sectionDTO.sectionOpenStatus as Bool) ? self.mArray_cell_item.count : 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return mArray_cell_item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RowCell", for: indexPath) as! RowCell
        self.sectionDTO = self.mArray_forBoolValueForCollpaseCell.object(at: indexPath.row) as! SectionDTO
        
        cell.lbl_title.text  = "Item : = \(indexPath.row)"
        
        cell.lbl_title.textColor = UIColor.black
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 57;
    }
    
    func tableView(_ tableView: UITableView,heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 38.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?{
        let sectionHeaderCell = tableView.dequeueReusableCell(withIdentifier: "SectionHeaderCell") as! SectionHeaderCell
        sectionHeaderCell.lbl_title.text = "Section \(section)"
        
        sectionHeaderCell.view_container.isUserInteractionEnabled = true
        sectionHeaderCell.view_container.tag = section
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tapgGestureForSectionHeader(tapGesture:)))
        sectionHeaderCell.view_container.addGestureRecognizer(tapGesture)
        
        sectionHeaderCell.backgroundColor = UIColor.red.withAlphaComponent(0.6)
        
        return sectionHeaderCell.contentView
    }
    
    func tapgGestureForSectionHeader(tapGesture : UITapGestureRecognizer) -> Void{
        
        let index: Int = (tapGesture.view?.tag)!
        
        var indexPath  = IndexPath(row: 0, section: index)
        let indexSet : NSMutableIndexSet =  NSMutableIndexSet()
        indexSet.add(indexPath.section)
        

        for i in 0..<self.mArray_cell_item.count{
         
            self.sectionDTO = SectionDTO()
         
            
            if i != indexPath.section {
                
                
                self.sectionDTO.sectionOpenStatus = false
                self.flagForSectionClicked = true
                
                let indexSetForPreviousRow : NSMutableIndexSet =  NSMutableIndexSet()
                indexSetForPreviousRow.add(i)
                
                self.mArray_forBoolValueForCollpaseCell.replaceObject(at:i, with: self.sectionDTO)
                tableView.reloadSections(indexSetForPreviousRow as IndexSet, with: UITableViewRowAnimation.automatic)
                
                
            }else{
                
                if flagForSectionClicked {
                    self.sectionDTO.sectionOpenStatus = true
                }else{
                    self.sectionDTO.sectionOpenStatus = false
                }
                
                self.mArray_forBoolValueForCollpaseCell.replaceObject(at:i, with: self.sectionDTO)
                tableView.reloadSections(indexSet as IndexSet, with: UITableViewRowAnimation.automatic)
            }
            
        }
    }
    
    
}

