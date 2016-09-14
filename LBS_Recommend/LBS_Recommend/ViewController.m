//
//  ViewController.m
//  LBS_Recommend
//
//  Created by lanyer on 16/9/13.
//  Copyright (c) 2016年 lanyer. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
//定义各个模块功能
typedef NS_ENUM(NSUInteger,FunctionSelet )
{
    LBS_Eat,
    LBS_Drink,
    LBS_Fun,
    LBS_Rest,
    LBS_Business,
    LBS_Other1,
    LBS_Other2,
    LBS_Other3,
    LBS_Other4
};
@interface ViewController ()<UISearchBarDelegate>
@property(nonatomic,strong) UISearchBar *SearchBar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    self.SearchBar = [[UISearchBar alloc]init];
    self.SearchBar.placeholder = @"请输入您要查找的内容";
    self.SearchBar.delegate = self;
    
    [self.SearchBar setBackgroundImage:[self createImageFromColor:[UIColor orangeColor] imageSize:CGSizeMake(self.view.frame.size.width, 50)]];
    [self.SearchBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:self.SearchBar];
   
    CGFloat btnSize = 80;
    CGFloat spacing = (self.view.frame.size.width - 3*btnSize)/4;
   
    NSUInteger dataArray[]={
        LBS_Eat,
        LBS_Drink,
        LBS_Fun,
        LBS_Rest,
        LBS_Business,
        LBS_Other1,
        LBS_Other2,
        LBS_Other3,
        LBS_Other4
    };
        //    for (int r=0; r<9; r++) {
        //        for (int c=0; c<9; c++) {
        //            UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(c*ROW_WIDTH+(c*CELL_SPACING), r*ROW_HEIGHT+(r*CELL_SPACING                           ), ROW_WIDTH, ROW_HEIGHT)];
        //            UIButton.contentMode=UIViewContentModeScaleAspectFit;
        //            UIButton.backgroundColor=[UIColor redColor];
        //            [self.view addSubview:imageView];
        //            [_imageViews addObject:imageView];
        //            
        //        }
        //    }
    
    for (int i = 0; i<9; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTag:dataArray[i]];
        [btn setTranslatesAutoresizingMaskIntoConstraints:NO];
        [btn addTarget:self action:@selector(theBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        
        //metrics 通过字典进行传参
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-btnH-[btn(btnW)]"
                                                                          options:0
                                                                          metrics:@{@"btnH":@(i%3*(btnSize+spacing)+spacing),@"btnW":@(btnSize)}
                                                                            views:NSDictionaryOfVariableBindings(btn)]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-btnV-[btn(btnH)]"
                                                                          options:0
                                                                          metrics:@{@"btnV":@(80+i/3*(btnSize+spacing)+spacing),@"btnH":@(btnSize)}
                                                                            views:NSDictionaryOfVariableBindings(btn)]];
    }
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_SearchBar]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_SearchBar)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_SearchBar]"
                                                                        options:0 metrics:nil
                                                                          views:NSDictionaryOfVariableBindings(_SearchBar)]];
}
//将导航视图控制器隐藏
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

//点击按钮跳转详细视图
-(void)theBtnPressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case LBS_Eat:
            NSLog(@"Function Eat");
            break;
        case LBS_Drink:
            NSLog(@"Function Drinlk");
            break;
        default:
            break;
    }
    DetailViewController *detailViewController = [[DetailViewController alloc]init];
    [self.navigationController pushViewController:detailViewController animated:YES];
}
//通过颜色获取图片
-(UIImage *)createImageFromColor:(UIColor *)color imageSize:(CGSize)size
{
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();//获取当前环境的上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);//设置填充颜色
    CGContextFillRect(context, frame);//填充矩形
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}

//点击空白处使得SearchBar 失去第一焦点
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.SearchBar resignFirstResponder];
}

#pragma mark UISearchBarDelegate
//点击return 失去第一焦点
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.SearchBar resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
