// The MIT License (MIT)
//
// Copyright (c) 2018 Jean-Charles SORIN
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import UIKit

final class LogEndPointsViewController: UITableViewController {
  
  private static let cellIdentifier = "LogEndPointCell"
  fileprivate let contexts = ["Network", "UI", "Analytics"]
  private lazy var logEndPoints = LogEndPoint.allCases

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Choose a log type to display"
    self.tableView.register(UITableViewCell.self,
                            forCellReuseIdentifier: LogEndPointsViewController.cellIdentifier)
  }

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.logEndPoints.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: LogEndPointsViewController.cellIdentifier,
                                             for: indexPath)
    let logEndPointName = self.logEndPoints[indexPath.row].rawValue
    cell.textLabel?.text = "Show me a \(logEndPointName) log"
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let selectedEndPoint = self.logEndPoints[indexPath.row]
    self.showLog(endPoint: selectedEndPoint)
  }
  
}

private extension LogEndPointsViewController {
  func showLog(endPoint: LogEndPoint) {
    let message = endPoint.displayTitle
    let randomIndex = Int(arc4random_uniform(UInt32(self.contexts.count)))
    
    switch endPoint {
    case .debug:
      logger.debug(message, context: self.contexts[randomIndex])
    case .verbose:
      logger.verbose(message, context: self.contexts[randomIndex])
    case .warning:
      logger.warning(message, context: self.contexts[randomIndex])
    case .info:
      logger.info(message, context: self.contexts[randomIndex])
    case .error:
      logger.error(message, context: self.contexts[randomIndex])
    }
  }
}
