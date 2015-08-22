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
#import "Loaders.h"
#import "UIScrollView+SVPullToRefresh.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface MessagingVC () <UITableViewDataSource, UITableViewDelegate, MessageCellDelegate, LoginVCDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *messages;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic) NSInteger lastPressedRow;

// outlets
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewBottomConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendButtonBottomConstraint;

@end

@implementation MessagingVC


- (void)viewDidLoad
{
    [Loaders showBlockingLoaderWithText:@"Signing In"];
    [self initializeVariables];
    [self loginUser];
    [self setupView];
    [self setupTableView];
    [self addPullToRefresh];
    [self registerForKeyboardNotifications];
}

- (void)dealloc
{
    [self deregisterForKeyboardNotifications];
}

- (void)setupView {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureCloseKeyboard)];
    [self.tableView addGestureRecognizer:tapGesture];
}

- (void)initializeVariables
{
    if (self.messages == nil) {
        self.messages = [[NSMutableArray alloc] init];
    }
}

- (void)setupTableView
{
    //load nib
    UINib *nib = [UINib nibWithNibName:@"MessageCell" bundle:nil];
    
    //register nib containing cell
    [self.tableView registerNib:nib forCellReuseIdentifier:@"MessageCell"];
}

#pragma mark - login methods

- (void)loginUser
{
    if ([HUser currentUser]) {
        __weak __typeof(self)weakSelf = self;
        [H_FACTORY.userService loginWithCompletion:^(id result, NSError *error) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if (error) {
                // show login controller
                [strongSelf showLoginVC];
                [Loaders hideBlockingLoader];
            } else {
                // check facebook login
                if ([FBSDKAccessToken currentAccessToken]) {
                    // User is logged in with FB
                    [Loaders showBlockingLoaderWithText:@"Loading Messages"];
                    [self refreshMessages];
                }
            }
        }];
    } else {
        [self showLoginVC];
        [Loaders hideBlockingLoader];
    }
}

- (void)showLoginVC
{
    LoginVC *loginVC = [[LoginVC alloc] init];
    loginVC.delegate = self;
    [self.navigationController pushViewController:loginVC animated:YES];
}

#pragma mark - message loading/creation/deletion

- (void)refreshMessages
{
    // load messages with messageService
    // once messages have loaded, update the datasource and reload the tableview
    __weak __typeof(self)weakSelf = self;
    [H_FACTORY.messageService loadAllMessagesWithCompletion:
     ^(id result, NSError *error) {
         __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (error) {
            NSLog(@"error loading messages: %@", error);
        } else {
            strongSelf.messages = result;
            [strongSelf.tableView reloadData];
            [Loaders hideBlockingLoader];
            if (strongSelf.refreshControl) {
                [strongSelf.refreshControl endRefreshing];
            }
        }
    }];
}

- (IBAction)sendButtonPushed:(id)sender
{
    if (self.inputTextField.text.length>0) {
        HMessage *message = [[HMessage alloc] initWithUsername:[HUser currentUser].username
                                                      fullName:[HUser currentUser].fullName
                                                   messageText:self.inputTextField.text
                                              profileUrlString:[HUser currentUser].profileUrlString];
        [self sendMessage:message];
        self.inputTextField.text = @"";
    }
}

- (void)sendMessage:(HMessage *)message
{
    __weak __typeof(self)weakSelf = self;
    [H_FACTORY.messageService sendMessage:message
                           withCompletion:
     ^(BOOL succeeded, NSError *error) {
         __strong __typeof(weakSelf)strongSelf = weakSelf;
         if (error) {
             // could also add some sort of UI alert here to inform the user that sending failed
             NSLog(@"error sending message: %@", error);
         } else {
             // add message to datasource and reload table view
             dispatch_async(dispatch_get_main_queue(), ^{
                 [strongSelf.messages addObject:message];
                 [strongSelf.tableView reloadData];
             });
         }
     }];
}

- (void)deleteMessage:(HMessage *)message atIndex:(NSInteger)index
{
    __weak __typeof(self)weakSelf = self;
    [H_FACTORY.messageService deleteMessage:message
                             withCompletion:
     ^(BOOL success, NSError *error) {
         __strong __typeof(weakSelf)strongSelf = weakSelf;
         if (error) {
             NSLog(@"error deleting message: %@", error);
         } else {
             // add message to datasource and reload table view
             dispatch_async(dispatch_get_main_queue(), ^{
                 [strongSelf.messages removeObjectAtIndex:index];
                 [strongSelf.tableView reloadData];
             });
         }
     }];
}

#pragma mark - tableview datasource and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 198;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HMessage *message = [self.messages objectAtIndex:indexPath.row];
    MessageCell *messageCell = [self.tableView dequeueReusableCellWithIdentifier:@"MessageCell"];
    messageCell.delegate = self;
    [messageCell setCellInfoForUsername:message.senderId
                               fullName:message.senderFullName
                               imageUrl:message.senderProfilePicUrl
                             sentAtTime:message.sentAt
                               withText:message.messageText
                              fromIndex:indexPath.row];
    return messageCell;
}

#pragma mark - message cell delegate

- (void)cellLongPressed:(MessageCell *)cell atIndex:(NSInteger)index
{
    if (!self.actionSheet.visible) {
        self.lastPressedRow = index;
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"YOU ARE AN ADMIN"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:@"Delete"
                                              otherButtonTitles: nil];
        [self.actionSheet showInView:self.view];
    }
}


#pragma mark - loginvc delegate

- (void)userSignedUp
{
    [self refreshMessages];
}

#pragma mark - action sheet delegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self deleteMessage:[self.messages objectAtIndex:self.lastPressedRow] atIndex:self.lastPressedRow];
            break;
            
        default:
            break;
    }
}

- (void)resignKeyboard
{
    [self.inputTextField resignFirstResponder];
}

#pragma mark - pull to refresh

- (void)addPullToRefresh
{
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(refreshMessages)
                  forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];

}

#pragma mark - tapgesture methods
-(void)tapGestureCloseKeyboard{
    [self resignKeyboard];
}

#pragma mark - keyboard notification methods

-(void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeShown:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

-(void)deregisterForKeyboardNotifications
{
    // for keyboard
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

-(void)keyboardWillBeShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    self.tableViewBottomConstraint.constant = keyboardSize.height;
    self.textViewBottomConstraint.constant = keyboardSize.height + 8;
    self.sendButtonBottomConstraint.constant = keyboardSize.height + 8;
    
    [UIView animateWithDuration:0.05f animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotifcation
{
    self.tableViewBottomConstraint.constant = 50;
    self.textViewBottomConstraint.constant = 8;
    self.sendButtonBottomConstraint.constant = 8;
    
    [UIView animateWithDuration:0.15f animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

@end
