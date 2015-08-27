//
//  WebTableViewController.m
//  NetMonitor
//
//  Created by 柏晓强 on 15/8/25.
//  Copyright (c) 2015年 柏晓强. All rights reserved.
//

#import "WebTableViewController.h"
#import "DetailViewTableViewCell.h"
#import "HeaderView.h"
#import "WebEntry.h"
#import "WebStore.h"

@interface WebTableViewController ()
@property (nonatomic) NSURLSession *session;
@property (nonatomic) NSMutableArray *isExpandedArray;
@property (nonatomic) WebStore *webStore;
//@property (nonatomic) NSMutableArray *sectionTitleArray;
@end

@implementation WebTableViewController
#pragma mark - init

- (instancetype)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        self.navigationItem.title = @"监控列表";
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config
                                                 delegate:nil
                                            delegateQueue:nil];
        NSLog(@"123");
        [self fetchFeed];
        NSLog(@"456");
    }

    return self;
}
#pragma mark - 网络请求
- (void)fetchFeed{
    NSString *requestString = @"http://123.57.219.143/webmon/iOS/status.php";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",error);
        NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        //清空数据
        [self.webStore removeAllEntry];
        
        //获取最新数据，存放在WebStore的单例中
        for (NSDictionary *website in jsonObject) {
            [self.webStore addWebEntry:[[WebEntry alloc] initWithData:website]];
        }
        
        //NSLog(@"%@",[self.webStore allWebEntry]);
        
        //初始化是否展开的数组，默认为0不展开
        for (int i=0; i<jsonObject.count; i++) {
            [self.isExpandedArray addObject:[NSNumber numberWithBool:NO]];
        }
        
        //Web服务请求成功后，WebTableViewController需要重新加载UItableView对象的数据
        //但是更新界面必须要在主线程进行
        //dataTask是在后台进行的
        //这个时候需要调用dispatch_async函数，让reloadData方法在主线程进行
        dispatch_async(dispatch_get_main_queue(), ^{
            //[self reloadHeaderViewData];
            [self.tableView reloadData];
        });
        
                                            
    }];
    [dataTask resume];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化展开状态数组，（单例模式）webStore对象
    self.isExpandedArray = [[NSMutableArray alloc] init];
    self.webStore = [WebStore sharedStore];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //向UITableView注册UITableViewCell
    UINib *nib = [UINib nibWithNibName:@"DetailViewTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"DetailViewTableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//刷新HeaderView
//-(void)reloadHeaderViewData{
//    [self.headViewArray removeAllObjects];
//    for (WebEntry *webEntry in [self.webStore allWebEntry]) {
//        HeaderView *headerView = [[HeaderView alloc] init];
//        int index = (int)[[self.webStore allWebEntry] indexOfObject:webEntry];
//        headerView.index = index;
//        //headerView.isExpanded = self.isExpandedArray[index];
//        headerView.website.text = webEntry.name;
//        headerView.count.text = [NSString stringWithFormat:@"%d",webEntry.down_last_week];
//        //NSLog(@"%@",website[@"isDown"]);
//        
//        if (webEntry.isDown) {
//            //NSLog(@"123");
//            #warning 最好不要这样写，占内存
////            NSString *redImageName = @"red.png";
////            NSString *redImagePath = [[NSBundle mainBundle] pathForResource:redImageName ofType:nil];
//            headerView.status.image = [UIImage imageNamed:@"red.png"];
//        }else{
//            headerView.status.image = [UIImage imageNamed:@"green.png"];
//            //NSLog(@"456");
//        }
//        
//        [self.headViewArray addObject:headerView];
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taptap:)];
//        [headerView addGestureRecognizer:tapGesture];
//    }
//}

-(void)taptap:(id)sender{
    //sender
    HeaderView *headView = (HeaderView *)((UIGestureRecognizer *)sender).view;
    int index = headView.index;
    NSLog(@"%d",index);
    
    BOOL isExpanded = [self.isExpandedArray[index] boolValue];
    self.isExpandedArray[index] = [NSNumber numberWithBool:!isExpanded];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    if (!isExpanded) {
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }else{
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
}
#pragma mark - delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[self.webStore allWebEntry] count];
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    NSDictionary *website = self.webListArray[section];
//    return website[@"name_zh"];
//}


//return custom Header //返回自定义的headerView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    HeaderView *headerView = [[HeaderView alloc] initWithWebEntry:[self.webStore allWebEntry][section]];
    headerView.index = (int)section;

    
    //添加点击手势响应
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taptap:)];
    [headerView addGestureRecognizer:tapGesture];
    
    //根据点开的状态来显示和隐藏一些控件
    BOOL isExpanded = [self.isExpandedArray[section] boolValue];
    
    if (isExpanded) {
        headerView.count.hidden = YES;
        headerView.separate.hidden = YES;
        headerView.status.hidden = YES;
        [headerView rotationIndicator:M_PI_2];
    }else{
        headerView.count.hidden = NO;
        headerView.separate.hidden = NO;
        headerView.status.hidden = NO;
        [headerView rotationIndicator:0];
        
    }
    return headerView;
    
}

//是否展开detail
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.isExpandedArray[section] boolValue];
}

//<UITableViewDelegate>
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

//创建每个cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailViewTableViewCell" forIndexPath:indexPath];
    //NSDictionary *website = self.webListArray[indexPath.section];
    WebEntry *webEntry = [self.webStore allWebEntry][indexPath.section];

    cell.website.text = webEntry.name;
    cell.interval.text = [NSString stringWithFormat:@"%d",webEntry.interval_time];
    cell.code.text = [NSString stringWithFormat:@"%d",webEntry.code];
    cell.time.text = webEntry.time;
    return cell;
}

//处理点击UITableViewCell事件
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSDictionary *website = self.webListArray[indexPath.row];
//    
//    NSLog(@"%@",website[@"name"]);
//}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
