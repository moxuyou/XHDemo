//
//  NSCalendar+LXH.m
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/12.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#import "NSCalendar+LXH.h"

@implementation NSCalendar (LXH)

+ (NSDateComponents *)currentDateComponents
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    return [calendar components:unitFlags fromDate:[NSDate date]];
}

+ (NSInteger)currentMonth
{
    return [NSCalendar currentDateComponents].month;
}

+ (NSInteger)currentYear
{
    return [NSCalendar currentDateComponents].year;
}

+ (NSInteger)currentDay
{
    return [NSCalendar currentDateComponents].day;
}

+ (NSInteger)currnentWeekday
{
    return [NSCalendar currentDateComponents].weekday;
}

+ (NSInteger)getLastMonthWithSelectYear:(NSInteger)year
{
    if (year == [NSCalendar currentYear])
    {
        return 12 - [NSCalendar currentMonth] + 1;
    }
    else
    {
        return 12;
    }
}

+ (NSInteger)getDaysWithYear:(NSInteger)year
                       month:(NSInteger)month
{
    switch (month) {
        case 1:
            return 31;
            break;
        case 2:
            if (year%400==0 || (year%100!=0 && year%4 == 0)) {
                return 29;
            }else{
                return 28;
            }
            break;
        case 3:
            return 31;
            break;
        case 4:
            return 30;
            break;
        case 5:
            return 31;
            break;
        case 6:
            return 30;
            break;
        case 7:
            return 31;
            break;
        case 8:
            return 31;
            break;
        case 9:
            return 30;
            break;
        case 10:
            return 31;
            break;
        case 11:
            return 30;
            break;
        case 12:
            return 31;
            break;
        default:
            return 0;
            break;
    }
}

+ (NSInteger)getFirstWeekdayWithYear:(NSInteger)year
                               month:(NSInteger)month
{
    NSString *stringDate = [NSString stringWithFormat:@"%ld-%ld-01", (long)year, (long)month];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yy-MM-dd"];
    NSDate *date = [formatter dateFromString:stringDate];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    return [components weekday];
}

+ (NSComparisonResult)compareWithComponentsOne:(NSDateComponents *)componentsOne
                                 componentsTwo:(NSDateComponents *)componentsTwo
{
    if (componentsOne.year == componentsTwo.year &&
        componentsOne.month == componentsTwo.month &&
        componentsOne.day   == componentsTwo.day) {
        return NSOrderedSame;
    }else if (componentsOne.year < componentsTwo.year ||
              (componentsOne.year == componentsTwo.year && componentsOne.month < componentsTwo.month) ||
              (componentsOne.year == componentsTwo.year && componentsOne.month == componentsTwo.month && componentsOne.day < componentsTwo.day)) {
        return NSOrderedAscending;
    }else {
        return NSOrderedDescending;
    }
}

+ (NSMutableArray *)arrayComponentsWithComponentsOne:(NSDateComponents *)componentsOne
                                       componentsTwo:(NSDateComponents *)componentsTwo
{
    NSMutableArray *arrayComponents = [NSMutableArray array];
    
    NSString *stringOne = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)componentsOne.year,
                           (long)componentsOne.month,
                           (long)componentsOne.day];
    NSString *stringTwo = [NSString stringWithFormat:@"%ld-%ld-%ld",(long) componentsTwo.year,
                           (long)componentsTwo.month,
                           (long)componentsTwo.day];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yy-MM-dd"];
    
    NSDate *dateFromString = [dateFormatter dateFromString:stringOne];
    NSDate *dateToString = [dateFormatter dateFromString:stringTwo];
    int timediff = [dateToString timeIntervalSince1970]-[dateFromString timeIntervalSince1970];
    
    NSTimeInterval timeInterval = [dateFromString timeIntervalSinceDate:dateFromString];
    
    for (int i = 0; i <= timediff; i+=86400) {
        timeInterval = i;
        NSDate *date = [dateFromString dateByAddingTimeInterval:timeInterval];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
        [arrayComponents addObject:[calendar components:unitFlags fromDate:date]];
    }
    return arrayComponents;
}

+ (NSDateComponents *)dateComponentsWithString:(NSString *)String
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yy-MM-dd"];
    NSDate *date = [formatter dateFromString:String];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    return  [calendar components:unitFlags fromDate:date];
}
@end
