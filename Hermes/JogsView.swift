import UIKit

class JogsView: UITableViewController {
        // MARK: - VIPER Stack
        weak var presenter: JogsViewToPresenterInterface!

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
                sortJogs(ascending: ascending)
                tableView.reloadData()
        }

        // MARK: - Operational
        func averageSpeedForPastWeek() -> Double {
                let pastWeekJogs = jogsForPastSevenDays(fromJogs: jogs)

                let distance = distanceForPastWeek()
                var time: TimeInterval = 0

                for (_, jog) in pastWeekJogs.enumerated() {
                        time += jog.time ?? 0
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
                let pastWeekJogs = jogsForPastSevenDays(fromJogs: jogs)

                var distance: Double = 0

                for (_, jog) in pastWeekJogs.enumerated() {
                        distance += jog.distance ?? 0
                }

                return distance
        }

        func jogsForPastSevenDays(fromJogs jogs: [Jog]) -> [Jog] {
                guard let aWeekAgo = Calendar.current.date(byAdding: Calendar.Component.day, value: -7, to: Date()) else {
                        return [Jog]()
                }

                return jogs.filter({ (jog) -> Bool in
                        if let date = jog.date {
                                return date.compare(aWeekAgo) == ComparisonResult.orderedDescending
                        }
                        return false
                })
        }

        func sortJogs(ascending: Bool) {
                jogs.sort { (j1, j2) -> Bool in
                        var result: Bool

                        if j1.date == nil && j2.date == nil {
                                return true
                        } else {
                                if j1.date == nil && j2.date != nil {
                                        return false
                                }

                                if j1.date != nil && j2.date == nil {
                                        return true
                                }
                        }

                        if j2.date!.compare(j1.date! as Date) == ComparisonResult.orderedAscending {
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
}

// MARK: - Navigation Interface
extension JogsView: JogsNavigationInterface { }

// MARK: - Presenter to View Interface
extension JogsView: JogsPresenterToViewInterface {
        func showDeleteJogFailed() {
                let alert = UIAlertController(title: "Error",
                                              message: "Deleting the jog failed, please try again",
                                              preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
        }

        func showFetchingJogsFailed() {
                let alert = UIAlertController(title: "Error",
                                              message: "We were unable to fetch jogs for this user, please try again",
                                              preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
        }

        func show(jogs newJogs: [Jog]) {
                jogs = newJogs
                sortJogs(ascending: ascending)
                tableView.reloadData()
        }
}

// MARK: UITableViewDatasource
extension JogsView {
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
                return true
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell: UITableViewCell?

                let jog = jogs[(indexPath as NSIndexPath).row]

                if let c = tableView.dequeueReusableCell(withIdentifier: "JogCell") as? JogCell {
                        let distance = jog.distance ?? 0
                        let time = jog.time ?? 0

                        c.distanceLabel?.text = String(distance)
                        c.timeLabel?.text = String(format: "%.0f min", time/60)
                        if let date = jog.date {
                                c.dateLabel?.text = dateFormatter.string(from: date as Date)
                        }

                        if jog.time ?? 0 > 0 {
                                c.averageSpeedLabel?.text = String(format: "%.1f / hr", distance/(time/60/60))
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
}

// MARK: UITableViewDelegate
extension JogsView {
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                let jog = jogs[(indexPath as NSIndexPath).row]
                presenter.userTapped(onJog: jog)
        }
}
