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
        var ascending: Bool = false
        lazy var jogs = [Jog]()
        lazy var dateFormatter: DateFormatter = {
                let f = DateFormatter()
                f.dateStyle = DateFormatter.Style.long
                return f
        }()
        
        // MARK: - Outlets
        @IBAction func addJogTapped(_ sender: AnyObject?) {
                presenter.userTappedAdd()
        }
        
        @IBAction func logoutTapped(_ sender: AnyObject?) {
                presenter.userTappedLogout()
        }
        
        @IBAction func sortByDate(_ sender: AnyObject?) {
                ascending = !ascending
                sortJogs(ascending)
                tableView.reloadData()
        }
        
        // MARK: - Operational
        func averageSpeedForPastWeek() -> Double {
                let pastWeekJogs = jogsForPastSevenDays(jogs)
                
                let distance = distanceForPastWeek()
                var time: TimeInterval = 0
                
                for (_, jog) in pastWeekJogs.enumerated() {
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
                
                for (_, jog) in pastWeekJogs.enumerated() {
                        distance += jog.distance
                }
                
                return distance
        }
        
        func jogsForPastSevenDays(_ jogs: [Jog]) -> [Jog] {
                let aWeekAgo = (Calendar.current as NSCalendar).date(byAdding: NSCalendar.Unit.day, value: -7, to: Date(), options: NSCalendar.Options(rawValue: 0))!
                
                return jogs.filter({ (jog) -> Bool in
                        return jog.date.compare(aWeekAgo) == ComparisonResult.orderedDescending
                })
        }
        
        func sortJogs(_ ascending: Bool) {
                jogs.sort { (j1, j2) -> Bool in
                        var result: Bool
                        
                        if j2.date.compare(j1.date as Date) == ComparisonResult.orderedAscending {
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
        func showDeleteJogFailed() {
                let alert = UIAlertController.init(title: "Error", message: "Deleting the jog failed, please try again", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction.init(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
        
        func showFetchingJogsFailed() {
                let alert = UIAlertController.init(title: "Error", message: "We were unable to fetch jogs for this user, please try again", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction.init(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
        
        func showJogs(_ jogs: [Jog]) {
                self.jogs = jogs
                sortJogs(ascending)
                tableView.reloadData()
        }
        
        // MARK: UITableViewDatasource
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
                return true
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell: UITableViewCell?
                
                let jog = jogs[(indexPath as NSIndexPath).row]
                
                if let c = tableView.dequeueReusableCell(withIdentifier: "JogCell") as? JogCell {
                        c.distanceLabel?.text = String(jog.distance)
                        c.timeLabel?.text = String(format: "%.0f min", jog.time/60)
                        c.dateLabel?.text = dateFormatter.string(from: jog.date as Date)
                        
                        if jog.time > 0 {
                                c.averageSpeedLabel?.text = String(format: "%.1f / hr", jog.distance/(jog.time/60/60))
                        } else {
                                c.averageSpeedLabel?.text = "0"
                        }
                        
                        cell = c
                } else {
                        cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
                }
                
                return cell!
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                return jogs.count
        }
        
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
                if jogs.count == 0 {
                        return "Add a Jog using the + in the top right!"
                }
                
                return nil
        }
        
        override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
                let distance = distanceForPastWeek()
                let avgSpeed = averageSpeedForPastWeek()
                
                return String(format: "Week - Avg Sp: %.1f / hour Dist: %.1f", avgSpeed, distance)
        }
        
        // MARK: UITableViewDelegate
        override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//                let deleteAction = UITableViewRowAction.init(style: UITableViewRowActionStyle(), title: "Delete") { (action, indexPath) -> Void in
//                        let jog = self.jogs[(indexPath as NSIndexPath).row]
//                        self.presenter.userTappedDelete(jog)
//                }
                return []//[deleteAction]
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let jog = jogs[(indexPath as NSIndexPath).row]
                presenter.userTappedJog(jog)
        }
}
