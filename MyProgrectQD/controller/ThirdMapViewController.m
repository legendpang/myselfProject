//
//  ThirdMapViewController.m
//  MyProgrectQD
//
//  Created by qianfeng on 15/11/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ThirdMapViewController.h"
#import "AppDelegate.h"

#import <BaiduMapAPI/BMapKit.h>
@interface ThirdMapViewController ()<UISearchDisplayDelegate,UISearchBarDelegate,BMKMapViewDelegate, BMKPoiSearchDelegate,BMKGeoCodeSearchDelegate,BMKSuggestionSearchDelegate>


@property(nonatomic,strong)NSString * map_x;
@property(nonatomic,strong)NSString * map_y;
@property(nonatomic,strong)NSString * name;

@end

@implementation ThirdMapViewController

{
    //定义百度地图视图
    BMKMapView *_mapView;
    UISearchBar *_searchBar;
    UIButton * _button;
    BMKPointAnnotation * _annotation;
    BMKPointAnnotation * _annotation1;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate * app = [[UIApplication sharedApplication] delegate];
    _map_x = app.map_x;
    _map_y = app.map_y;
    _name = app.name;
    if ([_annotation1.title isEqualToString:_name]) {
        return;
    }
    
    
   // NSLog(@"%@-----%@",_map_x,_map_y);
    [_mapView removeAnnotation:_annotation1];
    if (_map_x != nil & _map_y != nil) {
        [self creatAnnotation1];
    }
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:63/255.0 green:130/255.0 blue:81/255.0 alpha:1.0];
    self.tableView.scrollEnabled = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorColor = UITableViewCellSeparatorStyleNone;
    [self createBaiDuMap];
    [self createSearchBarUI];
    //[self createSearchBaiDuMap];
    
    [self createBigButton];
}


-(void)createBigButton
{
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    _button.frame = CGRectMake(0, 104, self.view.frame.size.width, self.view.frame.size.height - 104);
    _button.backgroundColor = [UIColor whiteColor];
    [_button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    _button.hidden = YES;
    _button.alpha = 0.1;
    [self.view addSubview:_button];
}

-(void)createSearchBarUI
{
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
   // NSLog(@"55555%f",self.view.frame.size.width);
    _searchBar.placeholder = @"请输入要搜索的地点";
    // _searchBar.showsCancelButton = YES;
    //_searchBar.scopeButtonTitles = @[@"fsf"];
    _searchBar.returnKeyType = UIReturnKeyDone;
    _searchBar.backgroundColor = [UIColor redColor];
    _searchBar.delegate = self;
    self.tableView.tableHeaderView = _searchBar;
}
//创建百度地图
-(void)createBaiDuMap
{
    
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 64+44, self.view.frame.size.width, self.view.frame.size.height-64-44-49)];
    //设置地图类型
    [_mapView setMapType:BMKMapTypeStandard];
    
    
    //指定代理类
    _mapView.delegate = self;
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(36.242, 120.519);
    BMKCoordinateSpan  span = BMKCoordinateSpanMake(0.5,0.5);
    BMKCoordinateRegion region = BMKCoordinateRegionMake(coordinate, span);
    [_mapView setRegion:region animated:YES];
    
    
    [self.view addSubview:_mapView];
    
    
}

-(void)createAnnotationUI
{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        CLGeocoder * geocoder = [[CLGeocoder alloc]init];
        [geocoder geocodeAddressString:_searchBar.text completionHandler:^(NSArray *placemarks, NSError *error) {
            if (!error) {
                CLPlacemark * clplacemark = [placemarks lastObject];
                _annotation = [[BMKPointAnnotation alloc]init];
                CLLocationCoordinate2D coor;
                coor.latitude = clplacemark.location.coordinate.latitude;
                coor.longitude = clplacemark.location.coordinate.longitude;
                
                // coor.latitude = [_map_x floatValue];
                // coor.longitude = [_map_y floatValue];
                _annotation.coordinate = coor;
                _annotation.title = [NSString stringWithFormat:@"这里是%@",_searchBar.text];
                
                
                
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(coor.latitude, coor.longitude);
                BMKCoordinateSpan  span = BMKCoordinateSpanMake(0.5,0.5);
                BMKCoordinateRegion region = BMKCoordinateRegionMake(coordinate, span);
            
                [_mapView setRegion:region animated:YES];
                [_mapView addAnnotation:_annotation];
            }
            
        }];
    
        
    });
    
    
    
}
-(void)creatAnnotation1
{
    _annotation1 = [[BMKPointAnnotation alloc] init];
    _annotation1.coordinate = CLLocationCoordinate2DMake([_map_x floatValue], [_map_y floatValue]);
    _annotation1.title = _name;
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([_map_x floatValue], [_map_y floatValue]);
    BMKCoordinateSpan  span = BMKCoordinateSpanMake(0.5,0.5);
    BMKCoordinateRegion region = BMKCoordinateRegionMake(coordinate, span);
    
    [_mapView setRegion:region animated:YES];
    
    [_mapView addAnnotation:_annotation1];
}
-(void)createSearchBaiDuMap
{
    
}
#pragma mark --button
-(void)clickButton:(UIButton *)button
{
    // NSLog(@"button");
    [_searchBar resignFirstResponder];
    _button.hidden = YES;
    _searchBar.showsCancelButton = NO;
    [_mapView removeAnnotation:_annotation];
   
    [self createAnnotationUI];
    
    
}
#pragma mark 地图编码协议实现

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;
        return newAnnotationView;
    }
    return nil;
}
-(void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
    
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
    _button.hidden = NO;
    
}



-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    // NSLog(@"searchBarCancelButtonClicked");
    _button.hidden = YES;
    [_searchBar resignFirstResponder];
    _searchBar.text = @"";
    _searchBar.showsCancelButton = NO;
    
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
