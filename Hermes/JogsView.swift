//
//  JogsView.swift
//  Hermes
//
//  Created by Ryan Bush on 10/31/15.
//  Copyright © 2015 Cold and Logical. All rights reserved.
//

import UIKit
import Parse

class JogsView : UITableViewController, JogsViewInterface {
        // MARK: - VIPER Stack
        lazy var presenter : JogsPresenterInterface = JogsPresenter()
        
        // MARK: - Instance Variables
        var ascending: Bool = true
        lazy var jogs = [Jog]()
        lazy var dateFormatter: NSDateFormatter = {
                let f = NSDateFormatter()
                f.dateStyle = NSDateFormatterStyle.LongStyle
                return f
        }()
        
        // MARK: - Outlets
        @IBAction func addJogTapped(sender: AnyObject?) {
                presenter.userTappedAdd()
        }
        
        @IBAction func logoutTapped(sender: AnyObject?) {
                presenter.userTappedLogout()
        }
        
        @IBAction func sortByDate(sender: AnyObject) {
                ascending = !ascending
                sortJogs(ascending)
                tableView.reloadData()
        }
        
        // MARK: - Operational
        func averageSpeedForPastWeek() -> Double {
                let pastWeekJogs = jogsForPastSevenDays(jogs)
                
                let distance = distanceForPastWeek()
                var time: NSTimeInterval = 0
                
                for (_, jog) in pastWeekJogs.enumerate() {
                        time += jog.time
                }
                
                let result: Double
                if time > 0 {
                        result = distance/Double((time/60)/60)
                } else {
                        result = 0
                }
                
                return result
        }
        
        func distanceForPastWeek() -> Double {
                let pastWeekJogs = jogsForPastSevenDays(jogs)
                
                var distance: Double = 0
                
                for (_, jog) in pastWeekJogs.enumerate() {
                        distance += jog.distance
                }
                
                return distance
        }
        
        func jogsForPastSevenDays(jogs: [Jog]) -> [Jog] {
                let aWeekAgo = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Day, value: -7, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))!
                
                return jogs.filter({ (jog) -> Bool in
                        return jog.date.compare(aWeekAgo) == NSComparisonResult.OrderedDescending
                })
        }
        
        func sortJogs(ascending: Bool) {
                jogs.sortInPlace { (j1, j2) -> Bool in
                        var result: Bool
                        
                        if j1.date.compare(j2.date) == NSComparisonResult.OrderedAscending {
                                result = true
                        } else {
                                result = false
                        }
                        
                        if ascending {
                                result = !result
                        }
                        
                        return result
                }
        }
        
        // MARK: - View Interface
        func showJogs(jogs: [Jog]) {
                self.jogs = jogs
                sortJogs(ascending)
                tableView.reloadData()
        }
        
        // MARK: UITableViewDatasource
        override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
                return true
        }
        
        override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
                let cell: UITableViewCell?
                
                let jog = jogs[indexPath.row]
                
                if let c = tableView.dequeueReusableCellWithIdentifier("JogCell") as? JogCell {
                        c.distanceLabel?.text = String(jog.distance)
                        c.timeLabel?.text = String(format: "%.0f min", jog.time/60)
                        c.dateLabel?.text = dateFormatter.stringFromDate(jog.date)
                        
                        if jog.time > 0 {
                                c.averageSpeedLabel?.text = String(format: "%.1f / hr", jog.distance/(jog.time/60/60))
                        } else {
                                c.averageSpeedLabel?.text = "0"
                        }
                        
                        cell = c
                } else {
                        cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
                }
                
                return cell!
        }
        
        override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return jogs.count
        }
        
        override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
                let distance = distanceForPastWeek()
                let avgSpeed = averageSpeedForPastWeek()
                
                return String(format: "Week - Avg Sp: %.1f / hour Dist: %.1f", avgSpeed, distance)
        }
        
        // MARK: UITableViewDelegate
        override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
                let deleteAction = UITableViewRowAction.init(style: UITableViewRowActionStyle.Destructive, title: "Delete") { (action, indexPath) -> Void in
                        let jog = self.jogs[indexPath.row]
                        self.presenter.userTappedDelete(jog)
                }
                return [deleteAction]
        }
        
        override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
                let jog = jogs[indexPath.row]
                presenter.userTappedJog(jog)
        }
}
