//
//  MessageCell.h
//  hiring-tests-ios-parsechat
//
//  Created by Bryan Boyko on 8/21/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MessageCellDelegate;

@interface MessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, weak) id<MessageCellDelegate> delegate;

- (void)setCellInfoForUsername:(NSString *)username
                      fullName:(NSString *)fullName
                      imageUrl:(NSString *)imageUrl
                    sentAtTime:(NSDate *)sentAt
                      withText:(NSString *)text
                     fromIndex:(NSInteger)index;

@end


@protocol MessageCellDelegate <NSObject>

- (void)cellLongPressed:(MessageCell *)cell atIndex:(NSInteger)index;

@end
