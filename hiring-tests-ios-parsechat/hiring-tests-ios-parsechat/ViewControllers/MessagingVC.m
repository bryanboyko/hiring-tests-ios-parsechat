//
//  MessagingVC.m
//  hiring-tests-ios-parsechat
//
//  Created by Bryan Boyko on 8/21/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import "MessagingVC.h"
#import "LoginVC.h"
#import "HClientPublic.h"
#import "MessageCell.h"


@interface MessagingVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *messages;

@end

@implementation MessagingVC


- (void)viewDidLoad
{
    [self refreshMessages];
}

#pragma mark - message loading/creation/deletion

- (void)refreshMessages
{
    // load messages with messageService
    // once messages have loaded, update the datasource and reload the tableview
}





#pragma mark - tableview datasource and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    return nil;
}

@end
