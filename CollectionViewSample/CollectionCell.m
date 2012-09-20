//
//  CollectionCell.m
//  CollectionViewSample
//
//  Created by Natsuko Nishikata on 2012/09/17.
//  Copyright (c) 2012年 Natsuko Nishikata. All rights reserved.
//

#import "CollectionCell.h"

@implementation CollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:
                                  CGRectMake(3, 3, frame.size.width - 6, frame.size.height - 6)];
                                // 枠をつけるためにimageViewのサイズを一回り小さくしておく
        
        // 可変サイズのセルに追従するようにautoresizingMaskを設定
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
}
*/

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        self.backgroundColor = [UIColor colorWithRed:1.000 green:0.822 blue:0.390 alpha:1.000];
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
}

@end
