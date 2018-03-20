//
//  PracticeModel.h
//  TreeMenu
//
//  Created by Allen on 2018/3/19.
//  Copyright © 2018年 Cpsdna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Practice: NSObject

@property (nonatomic, assign) NSInteger practiceId;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger itemCount;

@end

@interface PracticeCategory : NSObject

@property (nonatomic, assign) NSInteger categoryId;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray<Practice *> *practices;

@property (nonatomic, assign) NSInteger totalCount;


@end
