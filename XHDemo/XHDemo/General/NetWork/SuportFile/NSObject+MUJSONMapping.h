//
//  NSObject+MUJSONMapping.h
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MUJSONMapping)

/** 
 *  Designated initializer which automatically call fillWithJSON:
 * 
 *  param NSDictionary JSON
 */
- (instancetype)initWithJSON:(NSDictionary *)JSON;

/**
 *  Fill up object properties with values from dictionary.
 *  It only affect properties which it finds in JSON or in propertyMap.
 */
- (void)fillWithJSON:(NSDictionary *)JSON;

/**
 *  This method tells to response object which kind of objects are in the array.
 *  It use that information and create objects for you recursively.
 *
 *  param propertyName name of array property
 *
 *  return Class - It have to be subclass of MUJSONResponseObject
 */
- (Class)classForElementsInArrayProperty:(NSString *)propertyName;

/**
 *  Mapps service keys to property keys.
 *  There is no need to map all keys but only those which you want to have different name.
 *  (for example id -> userID)
 */
- (NSDictionary *)propertyMap;

/**
 *  It is used in validate method to correct build NSDate from NSString.
 *  By default is set as [dateFormatter setDateStyle:NSDateFormatterFullStyle];
 */
- (NSDateFormatter *)dateFormatter;

/**
 *  This is default validation method. It converts empty string, empty arrays and NSNull to nil.
 *  It also build NSDate from strings on which it use dateFormatter property. Please set dateFormatter property
 *  in your init method int order to correct formatting string from dates;
 *
 *  param object       object to validate
 *  param propertyName property name
 *  param objectClass  property class
 *
 *  return return adjusted object
 */
- (id)validateObject:(id)object forPropertyName:(NSString *)propertyName withClass:(Class)propertyClass;

@end
