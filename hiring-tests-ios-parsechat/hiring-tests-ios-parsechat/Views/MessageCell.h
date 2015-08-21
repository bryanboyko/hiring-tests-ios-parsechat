//
//  MessageCell.h
//  hiring-tests-ios-parsechat
//
//  Created by Bryan Boyko on 8/21/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

- (void)setCellInfoForUsername:(NSString *)username
                  withFullName:(NSString *)fullName
                      imageUrl:(NSString *)imageUrl
                       andText:(NSString *)text;

@end
