//
//  ANShareViewController.swift
//  Antsquare
//
//  Created by Sergey Demchenko on 8/8/15.
//  Copyright (c) 2015 Antsquare Technologies Inc. All rights reserved.
//

import UIKit
import FBSDKShareKit
import MessageUI

class ANShareViewController: UIViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, FBSDKSharingDelegate
{
    var viewModel = ANShareViewModel()
    weak var fromViewController: UIViewController!
    
    // MARK: - Public
    
    func show() -> Bool
    {
        if fromViewController == nil { return false }
        if viewModel.contentURL == nil { return false }
        
        var controller = self.navigationController == nil ? self : self.navigationController!
        
        controller.modalPresentationStyle = .OverCurrentContext
        controller.modalTransitionStyle = .CrossDissolve
        
        fromViewController.presentViewController(controller, animated: true, completion: nil)
        
        return true
    }
    
    // MARK: - IBAction
    
    override func onCloseButtonTapped(sender: AnyObject!)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onFacebookButtonTapped(sender: AnyObject)
    {
        if let contentURL = viewModel.contentURL {
            var content = FBSDKShareLinkContent()
            content.contentURL = contentURL

            var dialog = FBSDKShareDialog()
            dialog.delegate = self
            dialog.fromViewController = self
            dialog.shareContent = content
            dialog.mode = .ShareSheet;
            dialog.show()
        }
    }
    
    @IBAction func onEmailButtonTapped(sender: AnyObject)
    {
        if (!MFMailComposeViewController.canSendMail()) {
            if let title = viewModel.title, let url = viewModel.mailToUrl(title, body: viewModel.messageBody()) {
                UIApplication.sharedApplication().openURL(url)
            }

            return
        }
    
        if let contentURL = viewModel.contentURL {
            var mailComposeViewController = MFMailComposeViewController()
            mailComposeViewController.mailComposeDelegate = self
            if let title = viewModel.title { mailComposeViewController.setSubject(title) }
            mailComposeViewController.setMessageBody(viewModel.messageBody(), isHTML: false)
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func onSmsButtonTapped(sender: AnyObject)
    {
        if (!MFMessageComposeViewController.canSendText()) { return }
        
        if let contentURL = viewModel.contentURL {
            var messageComposeViewController = MFMessageComposeViewController()
            messageComposeViewController.body = viewModel.messageBody()
            messageComposeViewController.messageComposeDelegate = self
            self.presentViewController(messageComposeViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func onCopyLinkButtonTapped(sender: AnyObject)
    {
        if let contentURL = viewModel.contentURL {
            var myView = view as! ANShareView
            
            myView.copyLinkButton.setTitle("Copied", forState: .Normal)
            
            var pasteboard = UIPasteboard.generalPasteboard()
            pasteboard.string = contentURL.absoluteString
            
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                myView.copyLinkButton.setTitle("Copy Link", forState: .Normal)
            })
        }
    }
    
    // MARK: - FBSDKSharingDelegate
    
    func sharer(sharer: FBSDKSharing!, didCompleteWithResults results: [NSObject : AnyObject]!)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func sharer(sharer: FBSDKSharing!, didFailWithError error: NSError!)
    {
        if let error = error {
            UIAlertView(title: nil, message: error.localizedDescription, delegate: nil, cancelButtonTitle: "OK").show()
        }
    }
    
    func sharerDidCancel(sharer: FBSDKSharing!) { }
    
    // MARK: - MFMailComposeViewControllerDelegate
    
    func mailComposeController(controller:MFMailComposeViewController, didFinishWithResult result:MFMailComposeResult, error:NSError)
    {
        controller.dismissViewControllerAnimated(false, completion: nil)
        
        if result.value == MFMailComposeResultSaved.value {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    // MARK: - MFMessageComposeViewControllerDelegate
    
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult)
    {
        controller.dismissViewControllerAnimated(false, completion: nil)
        
        if result.value == MessageComposeResultSent.value {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
