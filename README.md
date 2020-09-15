# Introduction:
Revcontent's iOS library written in Swift for enables you quickly and reliably include our JS widgets into your application.

# Prerequisites
- XCode Version >= 10.x
- iOS Version >=10.0

# Features
- Load widget by WidgetId
- Load widget by SubId (Optional)
- Flexible widget size
- Define Base URL with FQDN or Article URL
- Add widget programmatically or by creating IBOutlets from Storyboard/Xibs.
# Installation
- Create a new project in Xcode as you would normally `for e.g. MyApp`.
- Open a terminal window, and `$ cd` into your project directory.
- Create a Podfile. This can be done by running `$ pod init`
- Open your Podfile. The first line should specify the platform and version supported.
- In order to use CocoaPods you need to define the Xcode target to link them to. So for example if you are writing an iOS app, it would be the name of your app. Create a target section by writing target '$TARGET_NAME' do and an end a few lines after.
```
platform :ios, '10.0'
target 'MyApp' do
  pod 'RCNativeiOSSDK'
end
```
- Save your Podfile.
- Run `$ pod install`
- Open the `MyApp.xcworkspace` that was created. This should be the file you use everyday to create your app.
# Usage
```
import UIKit
import RCNativeiOSSDK

class MenuViewController: UIViewController
{
    // Instance
    var tableData = ["1x6", "1x7",  "1x8", "1/9", "1/10"]
    let widgetID = ["144708","144710","144711","144712","144713"]
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

// MARK: UITableview Datasource Methods
extension MenuViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = tableData[indexPath.row]
        cell.textLabel?.textAlignment = .left
        return cell
    }
}

// MARK: UITableview Delegate Method
extension MenuViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let widgetId = widgetID[indexPath.row]
            let vc = storyboard?.instantiateViewController(identifier: "WidgetViewController") as? WidgetViewController
            vc!.widgetId = widgetId
            self.navigationController?.pushViewController(vc!, animated: true)
    }
}


//MARK:- WidgetViewController For Create your widget

import UIKit
import RCNativeiOSSDK

class WidgetViewController: UIViewController {

    @IBOutlet weak var viewWidget : UIView!
    var widgetId : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RCNativeiOSSDK.setup()
        self.viewWidget.addSubview(self.createWidget(widgetId))
        // Do any additional setup after loading the view.
    }
    
    func createWidget(_ widId : String) -> RCNactiveJSWidgetView
    {
        let widget = RCNactiveJSWidgetView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        // WidgetId is required.
        widget.setWidgetId(widgetId: widId)
        // WidgetSubId is optional.
        widget.setWidgetSubId(widgetSubId:["category":"entertainment", "utm_code":"123456"]);
        // baseUrl is optional.
        widget.setBaseUrl(baseUrl: "https://performance.revcontent.dev")
        //self.view.addSubview(widget)
        widget.loadWidget()
        return widget
    }
}


```
# License
MIT


