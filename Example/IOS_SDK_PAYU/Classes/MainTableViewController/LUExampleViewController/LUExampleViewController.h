//
//  orderLUViewController.h
//  PAYU_Example
//
//  Created by Max on 13.11.16.
//  Copyright © 2016 IPOL OOO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface LUExampleViewController : UIViewController <UIWebViewDelegate>{

}

@property (nonatomic,strong) IBOutlet UIWebView *webView;
@property (nonatomic,weak) NSString *payrefno;

@end
