//
//  BaseDetailController.swift
//  DCTT
//
//  Created by wyg on 2018/1/26.
//  Copyright © 2018年 Light.W. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
class BaseDetailController: BaseViewController ,UITableViewDelegate,UITableViewDataSource {

    var _tableview:UITableView!
    var headView:HomeDetailHeadView!
    
    private let kSectionViewFooterHeight:CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initSubview()
        
        addRightNavigationItem()
        
    }
    
    

    //MARK: -
    func initSubview()  {
        _tableview = UITableView.init(frame: CGRect (x: 0, y: 0, width: kCurrentScreenWidth, height: kCurrentScreenHeight - 64 - 49), style: .grouped)
        _tableview.delegate = self
        _tableview.dataSource = self
        _tableview.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        _tableview.showsVerticalScrollIndicator = false
        _tableview.separatorStyle = .none
        _tableview.backgroundColor = UIColor.white
        
        //Register Cell
        _tableview.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCellReuseIdentifier")
        view.addSubview(_tableview)
        
        _tableview.register(UINib (nibName: "HomeDetailCommentCell", bundle: nil), forCellReuseIdentifier: "HomeDetailCommentCellIdentifier")
        
        _tableview.register(UINib (nibName: "HomeDetailImgCell", bundle: nil), forCellReuseIdentifier: "HomeDetailImgCellIdentifier")
        
        //计算Cell高度
        _tableview.estimatedRowHeight = 70
        _tableview.rowHeight = UITableViewAutomaticDimension
        
        //headView
        let headview = Bundle.main.loadNibNamed("HomeDetailHeadView", owner: nil, options: nil)?.last as! HomeDetailHeadView
        _tableview.tableHeaderView = headview
        headView = headview
        
        //bottom comment btn
        addBottomBar()
        
    }

    //MARK: -
    //toolBar
    func addBottomBar()  {
        let toolBar = UIToolbar.init(frame: CGRect (x: 0, y: _tableview.frame.maxY, width: kCurrentScreenWidth, height: 49))
        toolBar.barTintColor = UIColor.white
        
        let btn_frame = CGRect (x: 0, y: 10, width: 80, height: 30)
        let writeBtn = UIButton (frame: btn_frame)
        writeBtn.setTitle("写评论", for: .normal)
        writeBtn.setTitleColor(UIColor.darkGray, for: .normal)
        writeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        writeBtn.backgroundColor = kTableviewBackgroundColor;
        writeBtn.layer.cornerRadius = 5
        writeBtn.layer.masksToBounds = true

        writeBtn.tag = 100
        writeBtn.addTarget(self, action: #selector(toolBarButtonClicked(_ :)), for: .touchUpInside)
        let writeItem = UIBarButtonItem (customView: writeBtn)
        
        //评论数
        let commentNumber = UIButton (frame: btn_frame)
        commentNumber.setTitle("评论(30)", for: .normal)
        commentNumber.setTitleColor(UIColor.darkGray, for: .normal)
        commentNumber.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        commentNumber.backgroundColor = kTableviewBackgroundColor
        commentNumber.layer.cornerRadius = 5
        commentNumber.layer.masksToBounds = true
        
        commentNumber.tag = 101
        commentNumber.addTarget(self, action: #selector(toolBarButtonClicked(_ :)), for: .touchUpInside)
        let commentNumberItem = UIBarButtonItem (customView: commentNumber)

        //收藏
        let scBtn = UIButton (frame: CGRect (x: 0, y: 5, width: 80, height: 32))
        scBtn.setImage(UIImage (named: "likeicon_actionbar_details"), for: .normal)
        scBtn.setImage(UIImage (named: "likeicon_actionbar_details_press"), for: .selected)
        scBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 45)//2020
        scBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 2, 0, 0)
        
        scBtn.setTitle("收藏", for: .normal)
        scBtn.setTitle("已收藏", for: .selected)
        scBtn.setTitleColor(UIColor.darkGray, for: .normal)
        scBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        scBtn.tag = 102
        scBtn.addTarget(self, action: #selector(toolBarButtonClicked(_ :)), for: .touchUpInside)
        let scItem = UIBarButtonItem (customView: scBtn)
        
        let flex = UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.items = [writeItem,commentNumberItem,flex,scItem]
        
        view.addSubview(toolBar)
    }
    
    func toolBarButtonClicked(_ button:UIButton) {
        button.isSelected = !button.isSelected
        
        switch button.tag {
        case 100://写评论
            IQKeyboardManager.sharedManager().enable = false
            IQKeyboardManager.sharedManager().enableAutoToolbar = false
            let post_v = TTPostCommentView.init(frame:UIScreen.main.bounds)
            
            UIApplication.shared.keyWindow?.addSubview(post_v)
            break
        case 101://收藏
            break
        case 102://举报
            break
        default:break
        }
    }
 
    
    //MARK: -
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0 ;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCellReuseIdentifier", for: indexPath)
 
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section == 0 else { return nil}
        guard let v = Bundle.main.loadNibNamed("HomeDetailFooterView", owner: nil, options: nil)?.last as? HomeDetailFooterView else{return nil}
        
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? kSectionViewFooterHeight : 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  0.01
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
