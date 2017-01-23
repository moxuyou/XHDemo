//
//  MUJSONSerializer.h
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "NSObject+MUJSONMapping.h"

/**
 *  MUResponseSerializer is subclass of AFJSONResponseSerializer which automatically serialize
 *  response foundation objects to your custom model objects. 
 *  It also works with NSManagedObjects
 */
@interface MUResponseSerializer : AFJSONResponseSerializer <AFURLResponseSerialization>

/**
 *  Tells MUJSONResponseSerializer which class is top level object. 
 *  In case of array of ojects, the serializer assumed that all objects in the array are the same class
 */
@property (nonatomic) Class responseObjectClass;

/** 
 * Designated initializer, which sets responseObjectClass property
 *
 * param Class responseObjectClass
 * return MUResponseSerializer instance
 */
- (instancetype)initWithResponseClass:(Class)aClass;

@end
