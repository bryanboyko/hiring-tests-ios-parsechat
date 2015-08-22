//
//  MessageCell.m
//  hiring-tests-ios-parsechat
//
//  Created by Bryan Boyko on 8/21/15.
//  Copyright (c) 2015 BryanBoyko. All rights reserved.
//

#import "MessageCell.h"
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface MessageCell ()

@property (nonatomic, strong) UILongPressGestureRecognizer *longPressRecognizer;
@property (nonatomic) NSInteger index;

@end

@implementation MessageCell

- (void)awakeFromNib
{
    if (self.longPressRecognizer == nil)
    {
        self.longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(cellLongPressed:)];
        [self addGestureRecognizer:self.longPressRecognizer];
    }
}

- (void)setCellInfoForUsername:(NSString *)username
                      fullName:(NSString *)fullName
                      imageUrl:(NSString *)imageUrl
                    sentAtTime:(NSDate *)sentAt
                      withText:(NSString *)text
                     fromIndex:(NSInteger)index
{
    // set index for self
    self.index = index;
    
    // set name and text
    self.nameLabel.text = fullName;
    self.contentTextView.text = text;
    
    // set date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    NSString *stringFromDate = [formatter stringFromDate:sentAt];
    self.timeLabel.text = stringFromDate;
    
    // load and set image
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]
                             placeholderImage:nil
                                      options:SDWebImageLowPriority
                                    completed:nil];
}

- (void)cellLongPressed:(id)sender
{
    [self.delegate cellLongPressed:self atIndex:self.index];
}

@end
