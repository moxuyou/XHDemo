//
//  NSObject+MUJSONMapping.m
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "NSObject+MUJSONMapping.h"
#import <objc/runtime.h>

@implementation NSObject (MUJSONMapping)

- (instancetype)initWithJSON:(id)JSON
{
    if(self = [self init])
    {
        [self fillWithJSON:JSON];
    }
    
    return self;
}

- (void)fillWithJSON:(id)JSON
{
    NSMutableDictionary *propertyValues = [[NSMutableDictionary alloc] init];
    
    for (NSString *jsonPropertyName in [JSON allKeys])
    {   
        NSString *propertyName;
        
        if([[self propertyMap] valueForKey:jsonPropertyName])
            propertyName = [[self propertyMap] valueForKey:jsonPropertyName];
        else
            propertyName = jsonPropertyName;
        
        [propertyValues setObject:[JSON objectForKey:jsonPropertyName] forKey:propertyName];
    }
    
    [self setValuesToProperties:propertyValues];
}

- (Class)classForElementsInArrayProperty:(NSString *)propertyName
{
    return nil;
}

- (NSDictionary *)propertyMap
{
    return nil;
}

- (NSDateFormatter *)dateFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    
    return dateFormatter;
}

- (id)validateObject:(id)object forPropertyName:(NSString *)propertyName withClass:(Class)propertyClass
{
    // NSNull -> nil
    if([object isKindOfClass:[NSNull class]])
        object = nil;
    
    // NSString
    if([propertyClass isSubclassOfClass:[NSString class]])
    {
        // @"" -> nil
        if ([object isEqualToString:@""])
            object = nil;
    }
    
    // NSDate
    // format time correctly
    if([propertyClass isSubclassOfClass:[NSDate class]])
    {
        // NSDate from NSString
        if([object isKindOfClass:[NSString class]])
            object = [[self dateFormatter] dateFromString:object];
        
        // NSDate from timestamp in NSNumber
        if([object isKindOfClass:[NSNumber class]])
            object = [NSDate dateWithTimeIntervalSince1970:[(NSNumber *)object doubleValue]];
    }
    
    // NSArray
    // empty arrray -> nil
    if([propertyClass isSubclassOfClass:[NSArray class]])
    {
        if([object isKindOfClass:[NSArray class]] && [object count] == 0)
            object = nil;
        
    }
    
    return object;
}

#pragma mark PRIVATE METHODS

- (void)setObjectValue:(id)object forPropertyName:(NSString *)propertyName withClassName:(NSString *)className
{
    Class propertyClass = NSClassFromString(className);
    
    [self willChangeValueForKey:propertyName];
    
    // NSDate
    if ([propertyClass isSubclassOfClass:[NSDate class]])
    {
        object = [self validateObject:object forPropertyName:propertyName withClass:propertyClass];
        [self setValue:object forKey:propertyName];
    }
    
    // NSString
    // NSNumber
    // NSDictionary
    else if ([propertyClass isSubclassOfClass:[NSString class]] ||
             [propertyClass isSubclassOfClass:[NSNumber class]] ||
             [propertyClass isSubclassOfClass:[NSDictionary class]])
    {
        object = [self validateObject:object forPropertyName:propertyName withClass:propertyClass];
        [self setValue:object forKey:propertyName];
    }
    
    // NSArray
    else if([propertyClass isSubclassOfClass:[NSArray class]])
    {
        Class elementClass = [self classForElementsInArrayProperty:propertyName];
        
        // we know about elements in array
        if (elementClass)
        {
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:[(NSArray *)object count]];
            for (id item in (NSArray *)object)
            {
                [array addObject:[[elementClass alloc] initWithJSON:item]];
            }
            
            object = [self validateObject:array forPropertyName:propertyName withClass:propertyClass];
            [self setValue:object forKey:propertyName];
        }
        else
        {
            object = [self validateObject:object forPropertyName:propertyName withClass:propertyClass];
            [self setValue:object forKey:propertyName];
        }
    }
    
    // custom classes
    else
    {
        object = [self validateObject:[[propertyClass alloc] initWithJSON:object]
                      forPropertyName:propertyName
                            withClass:propertyClass];
        
        [self setValue:object forKey:propertyName];
        
    }
    
    [self didChangeValueForKey:propertyName];
    
}

- (void)setValuesToProperties:(NSDictionary *)propertyValues
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    //----horace edit-----
    unsigned int superOutCount;
    objc_property_t *superProperties = class_copyPropertyList([self superclass], &superOutCount);
    
    objc_property_t allProperties[outCount + superOutCount];
    for (int n=0; n < outCount; n++)
    {
        allProperties[n] = properties[n];
    }
    for (int n=0; n < superOutCount; n++)
    {
        allProperties[n+outCount] = superProperties[n];
    }
    
    outCount+= superOutCount;
    //--------------------
    
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property =  allProperties[i];//properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)];
        
        char *typeEncoding = property_copyAttributeValue(property, "T");
        switch (typeEncoding[0])
        {
            case '@':
            {
                if (strlen(typeEncoding) >= 3  && [propertyValues valueForKey:propertyName])
                {
                    char *className = strndup(typeEncoding + 2, strlen(typeEncoding) - 3);
                    __autoreleasing NSString *propertyClassName = @(className);
                    NSRange range = [propertyClassName rangeOfString:@"<"];
                    if (range.location != NSNotFound)
                    {
                        propertyClassName = [propertyClassName substringToIndex:range.location];
                    }
                    propertyClassName = propertyClassName ? propertyClassName : @"NSObject";
                    free(className);
                    
                    
                    [self setObjectValue:[propertyValues valueForKey:propertyName] forPropertyName:propertyName withClassName:propertyClassName];
                }
            }
                break;
                
                
            case 'c':   // BOOL or char
            case 'i':   //int
            case 's':   //short
            case 'l':   //long
            case 'q':   //long long
            case 'C':   //unsigned char
            case 'I':   //unsigned int
            case 'S':   //unsigned short
            case 'L':   //unsigned long
            case 'Q':   //unsigned long long
            case 'f':   //float
            case 'd':   //double
            case ':':   //selector
            case 'B':   //bool
            case '{':   //value
                if([propertyValues valueForKey:propertyName])
                    [self setObjectValue:[propertyValues valueForKey:propertyName] forPropertyName:propertyName withClassName:@"NSNumber"];
                break;
        }
        free(typeEncoding);
    }
    free(superProperties);
    free(properties);
}
@end
