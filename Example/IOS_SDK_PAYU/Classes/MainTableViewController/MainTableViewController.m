//
//  MainTableViewController.m
//  PAYU_Example
//
//  Created by Max on 12.11.16.
//  Copyright © 2016 IPOL OOO. All rights reserved.
//

#import "MainTableViewController.h"
#import "LUExampleViewController.h"
#import "ALUExampleRequest.h"
#import "IOSExampleRequest.h"
#import "IRNExampleRequest.h"

@interface MainTableViewController (){
    NSArray *menuTitleArr;
    
}
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showLogoNavBar];
    menuTitleArr=@[@"LU (Live Update)",@"ALU (Automatic Live Update)",@"Отмена/возврат (IRN)",@"Проверка статуса платежа (IOS)"];

}
-(void)showLogoNavBar{
        UIImageView *titleImage=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PAYU_Logo.png"]];
        UINavigationItem *item = self.navigationController.topViewController.navigationItem;
        UIView *backView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
        [titleImage setFrame:CGRectMake(-40, 0, 80, 40)];
        [backView addSubview:titleImage];
        item.titleView = backView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source
-(double)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainTableViewControllerCell" forIndexPath:indexPath];
    cell.textLabel.text=[menuTitleArr objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"segue1" sender:self];
            break;
        case 1:
            [ALUExampleRequest payWithALUInView:self.view];
            break;
        case 2:
            [IRNExampleRequest sendIRNRequestInView:self.view];
            break;
        case 3:
            [IOSExampleRequest sendIOSRequestInView:self.view];
            break;
            
        default:
            break;
    }
}

@end
