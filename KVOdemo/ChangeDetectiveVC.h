//
//  ChangeDetectiveVC.h
//  KVOdemo
//
//  Created by admin on 15/9/24.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface ChangeDetectiveVC : UIViewController

@property (nonatomic,strong)Book *abook;

-(id)init:(Book *)theBook;

@end
