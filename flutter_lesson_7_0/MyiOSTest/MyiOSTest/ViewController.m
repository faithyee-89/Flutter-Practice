//
//  ViewController.m
//  MyiOSTest
//
//  Created by houzirui on 2021/10/19.
//

#import "ViewController.h"
@interface TestView:UIView
@end

@implementation TestView

- (instancetype)init{
    self = [super init];
    if(self){
        
    }
    return self;
}
- (void)willMoveToSuperview:(nullable UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
}
- (void)didMoveToSuperview{
    [super didMoveToSuperview];
}
- (void)willMoveToWindow:(nullable UIWindow *)newWindow{
    [super willMoveToWindow:newWindow];
    
}

- (void)didMoveToWindow{
    [super didMoveToWindow];
}

@end


@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ViewController
-(instancetype)init{
    self = [super init];
    if(self){
        
    }
    return  self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}  // Called when the view is about to made visible. Default does nothing
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}   // Called when the view has been fully transitioned onto the screen. Default does nothing
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
} // Called when the view is dismissed, covered or otherwise hidden. Default does nothing
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}// Called after the view was dismissed, covered or otherwise hidden. Default

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:({
        UILabel *lable =   [[UILabel alloc] init];
        lable.text = @"hello";
        [lable sizeToFit];
//        lable.text = @"hello";
        lable.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
         lable;
    })];
    
    TestView *view = [[TestView alloc] init];
    view.backgroundColor = [UIColor redColor];
    view.frame = CGRectMake(0,100,100,100);
    [self.view addSubview:view];
//    UITableView *uiTabView =[[UITableView alloc] initWithFrame:self.view.bounds];
//    [self.view addSubview:uiTabView];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:(self) action:@selector(pushController)];
    [view addGestureRecognizer:tapRecognizer];
    
}
-(void)pushController{
    UIViewController *viewController =  [[UIViewController alloc] init];
    viewController.navigationItem.title = @"标题";
    
    UITableView *uiTabView =[[UITableView alloc] initWithFrame:self.view.bounds];
    uiTabView.dataSource = self;
    uiTabView.delegate =self;
    [viewController.view addSubview:uiTabView];
    
    [ self.navigationController pushViewController:viewController animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *uiTabViewCell=  [tableView dequeueReusableCellWithIdentifier:@"id"];
    
    if(!uiTabViewCell){
        uiTabViewCell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
    }
   
    uiTabViewCell.textLabel.text =@"主标题";
    uiTabViewCell.detailTextLabel.text=[NSString stringWithFormat:@"%ld",indexPath.item];
    return uiTabViewCell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *viewController =  [[UIViewController alloc] init];
    viewController.navigationItem.title = [NSString stringWithFormat:@"%ld",indexPath.item];
    [ self.navigationController pushViewController:viewController animated:YES];

}
@end
