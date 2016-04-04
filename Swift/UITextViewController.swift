//
//  UITextViewController.swift
//  Created by Modo Ltunzher on 05.04.16.
//

import UIKit

class UITextViewController: UIViewController, UITextViewDelegate
{
// MARK: Publics
    
    typealias Handler = (controller: UITextViewController) -> Void
    
    var handlerTextChange: Handler? = nil
    var handlerCancel: Handler? = nil
    var handlerDone: Handler? = nil
    
// MARK: Privates
    
    lazy var textView = UITextView()
    
// MARK: - Memory Management
    
    init()
    {
        super.init(nibName: nil, bundle: nil)
        
        self.title = "Edit"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(UITextViewController.onCancel))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(UITextViewController.onDone))
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - View Lifecycle
    
    override func loadView()
    {
        textView.backgroundColor = UIColor.whiteColor()
        textView.delegate = self
        
        let view = UIView(frame: CGRectMake(0, 0, 100, 100))
        textView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        textView.frame = view.bounds
        view.addSubview(textView)
        self.view = view
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UITextViewController.onKeyboardFrameDidChange(_:)), name: UIKeyboardDidChangeFrameNotification, object: nil)
        
        textView.becomeFirstResponder()

    }
    
    override func viewWillDisappear(animated: Bool)
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidChangeFrameNotification, object: nil)
        
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        updateInsets()
    }

// MARK: - Public

    func getText() -> String
    {
        return self.textView.text
    }
    
    func setText(text: String)
    {
        self.textView.text = text
        self.textView.selectAll(self)
    }
    
// MARK: - Private
    
    private func setTopInset(val: CGFloat)
    {
        var inset = self.textView.contentInset
        inset.top = val

        self.textView.contentInset = inset
        self.textView.scrollIndicatorInsets = inset
    }

    private func setBottomInset(val: CGFloat)
    {
        var inset = self.textView.contentInset
        inset.bottom = val
        
        self.textView.contentInset = inset
        self.textView.scrollIndicatorInsets = inset
    }

    private func updateInsets()
    {
        //
        var bottomOffSet: CGFloat = 0
        if (self.tabBarController != nil) && (self.tabBarController!.tabBar.translucent)
        {
            bottomOffSet = self.tabBarController!.tabBar.frame.size.height
        }
        
        //
        var topOffset: CGFloat = 0
        if (self.navigationController != nil) && (self.navigationController!.navigationBar.translucent)
        {
            let bar = self.navigationController!.navigationBar
            topOffset = bar.frame.size.height
            
            if bar.barPosition == .TopAttached
            {
                // window rotates starting with iOS 8, so "height" contains correct value
                topOffset += UIApplication.sharedApplication().statusBarFrame.size.height
            }
        }
        
        //
        setTopInset(topOffset)
        setBottomInset(bottomOffSet)
    }
    
// MARK: - UITextViewDelegate
    
    func textViewDidChange(textView: UITextView)
    {
        self.handlerTextChange?(controller: self)
    }

// MARK: - Action Handlers

    @objc internal func onCancel()
    {
        self.handlerCancel?(controller: self)
    }

    @objc internal func onDone()
    {
        self.handlerDone?(controller: self)
    }
    
    @objc internal func onKeyboardFrameDidChange(notification: NSNotification)
    {
        if let frameValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue
        {
            let windowRect = frameValue.CGRectValue()
            let viewRect = self.view.convertRect(windowRect, fromView: self.view.window)
            
            setBottomInset(max(0, CGRectGetMaxY(self.view.frame) - CGRectGetMinY(viewRect)))
        }
    }
}
