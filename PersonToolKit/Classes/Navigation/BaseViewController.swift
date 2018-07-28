//
//  HSBaseViewController.swift
//  HandScan
//
//  Created by ay on 2018/6/24.
//  Copyright © 2018年 aypc. All rights reserved.
//

import UIKit
import Toast_Swift
class BaseViewController: UIViewController {

    var deviceNameLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setBackBtn(title:String) {
        let logout = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(clickBackBtn))
        logout.tintColor = UIColor.black
        self.navigationItem.setLeftBarButton(logout, animated: true)
    }
    
    func showProgressHud()
    {
        self.view.makeToastActivity(.center)
    }
    func hideProgressHud()
    {
        self.view.hideToastActivity()
    }
    func showToast(title:String = "请求异常，请稍后再试")
    {
        self.view.makeToast(title, duration: 3.0, position: .center)
    }
    
    @objc func clickBackBtn()
    {
        self.navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
