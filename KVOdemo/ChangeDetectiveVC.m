//
//  ChangeDetectiveVC.m
//  KVOdemo
//
//  Created by admin on 15/9/24.
//  Copyright © 2015年 xukun. All rights reserved.
//

#import "ChangeDetectiveVC.h"
#import "Book.h"

@interface ChangeDetectiveVC ()
{
    
}

@end

@implementation ChangeDetectiveVC
{
    UILabel *_label;

}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)init:(Book *)theBook
{
    if (self = [super init]) {
        _abook = theBook;
        
        [_abook addObserver:self forKeyPath:@"price" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //添加监听
    self.abook = [[Book alloc]init];
    [_abook addObserver:self forKeyPath:@"price" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    
    UIButton *abtn = [UIButton buttonWithType:UIButtonTypeCustom];
    abtn.frame = CGRectMake(80, 90.0, 80, 30);
    [abtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [abtn setTitle:@"Change" forState:UIControlStateNormal];
    [abtn addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:abtn];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80, 200, 200, 20)];
    label.text = @"price:";
    label.font= [UIFont systemFontOfSize:10.0];
    _label = label;
    [self.view addSubview:_label];
    // Do any additional setup after loading the view.
}

-(void)change
{
    //两种方法触发监听
    NSDictionary *newBookPropertiesDictionary=[NSDictionary dictionaryWithObjectsAndKeys:
                                               @"book name",@"name",
                                               @"20.5",@"price",nil];
    [self.abook setValuesForKeysWithDictionary:newBookPropertiesDictionary];
    
    [self.abook setValue:@"34.0" forKey:@"price"];
}

-(void)dealloc
{
    //移除监听
    [_abook removeObserver:self forKeyPath:@"price"];
}

//实现监听
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqual:@"price"]) {
        NSString *price = [change objectForKey:@"new"];
        NSString *newPrice = [NSString stringWithFormat:@"new price:%@",price];
        _label.text = newPrice;
        NSLog(@"old price: %@",[change objectForKey:@"old"]);
        NSLog(@"new price: %@",[change objectForKey:@"new"]);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
