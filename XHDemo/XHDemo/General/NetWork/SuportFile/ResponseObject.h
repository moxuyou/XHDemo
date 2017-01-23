//
//  ResponseObject.h
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "BaseResponseObject.h"

@interface ResponseObject : BaseResponseObject

@property (nonatomic, strong) NSDictionary *data;

typedef void(^ResponseObjectResult)(ResponseObject *object);

@end
