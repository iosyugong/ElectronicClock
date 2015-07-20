//
//  ElectronicClock.m
//  ElectronicClock
//
//  Created by IvanDing on 15/6/10.
//  Copyright (c) 2015年 IvanDing. All rights reserved.
//

#import "ElectronicClock.h"

@implementation ElectronicClock
{
    /** 年份时间label */
    UILabel *yearLabel;
    /** 月份时间label */
    UILabel *monthLabel;
    /** 天时间label */
    UILabel *dayLabel;
    /** 小时时间label */
    UILabel *hourLabel;
    /** 分钟时间label */
    UILabel *minuteLabel;
    /** 秒时间label */
    UILabel *secondLabel;
    /** 时间间隔 */
    UILabel *intervalLabel3;
    UILabel *intervalLabel4;
    /** 定时器 */
    NSTimer *timer;
    /** 加减号按钮数组 */
    NSMutableArray *addReduceButtonArray;
}

#pragma mark - 初始化电子时钟视图
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 50, 320, 460)];
    if (self) {
        [self electronicClockLayout];
    }
    return self;
}

#pragma mark - 布局电子时钟
- (void)electronicClockLayout {
    /** 加减号按钮数组初始化 */
    addReduceButtonArray = [[NSMutableArray alloc] init];
    //布局标题
    [self setTitleLayout];
    //布局时间
    [self setTimeLayout:[self splitTimeFromString:[self getCurrentTime]]];
    //布局按钮
    [self setButtonLayout];
    //开启定时器
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(refreshTime) userInfo:nil repeats:YES];
    //获取当前时间
    [self getCurrentTime];
    
}

#pragma mark - 布局标题
- (void)setTitleLayout {
    //设置label尺寸
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    //设置标题
    titleLabel.text = @"电子时钟";
    //设置字体
    [titleLabel setFont: [UIFont fontWithName:@"Avenir" size:30]];
    //设置对齐方式
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    //设置文字自动适应
    titleLabel.adjustsFontSizeToFitWidth = YES;
    //设置字体颜色
    [titleLabel setTextColor: [UIColor blackColor]];
    //添加到view中
    [self addSubview:titleLabel];
}

#pragma mark - 布局时间
- (void)setTimeLayout:(NSArray *)timeArr {
    /** 年份时间label */
    yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 100, 50)];
    //设置标题
    yearLabel.text = timeArr[0];
    //设置字体
    [yearLabel setFont: [UIFont fontWithName:@"LcdD" size:50]];
    //设置对齐方式
    [yearLabel setTextAlignment:NSTextAlignmentCenter];
    //设置文字自动适应
    yearLabel.adjustsFontSizeToFitWidth = YES;
    //设置字体颜色
    [yearLabel setTextColor: [UIColor blackColor]];
    //添加到view中
    [self addSubview:yearLabel];
    /** 间隔label */
    UILabel *intervalLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(110, 50, 50, 50)];
    //设置标题
    intervalLabel1.text = @"—";
    //设置字体
    [intervalLabel1 setFont: [UIFont fontWithName:@"LcdD" size:40]];
    //设置对齐方式
    [intervalLabel1 setTextAlignment:NSTextAlignmentCenter];
    //设置文字自动适应
    intervalLabel1.adjustsFontSizeToFitWidth = YES;
    //设置字体颜色
    [intervalLabel1 setTextColor: [UIColor blackColor]];
    //添加到view中
    [self addSubview:intervalLabel1];
    /** 月份时间label */
    monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(130, 50, 100, 50)];
    //设置标题
    monthLabel.text = timeArr[1];
    //设置字体
    [monthLabel setFont: [UIFont fontWithName:@"LcdD" size:50]];
    //设置对齐方式
    [monthLabel setTextAlignment:NSTextAlignmentCenter];
    //设置文字自动适应
    monthLabel.adjustsFontSizeToFitWidth = YES;
    //设置字体颜色
    [monthLabel setTextColor: [UIColor blackColor]];
    //添加到view中
    [self addSubview:monthLabel];
    /** 间隔label */
    UILabel *intervalLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(200, 50, 50, 50)];
    //设置标题
    intervalLabel2.text = @"—";
    //设置字体
    [intervalLabel2 setFont: [UIFont fontWithName:@"LcdD" size:40]];
    //设置对齐方式
    [intervalLabel2 setTextAlignment:NSTextAlignmentCenter];
    //设置文字自动适应
    intervalLabel2.adjustsFontSizeToFitWidth = YES;
    //设置字体颜色
    [intervalLabel2 setTextColor: [UIColor blackColor]];
    //添加到view中
    [self addSubview:intervalLabel2];
    /** 天时间label */
    dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 50, 100, 50)];
    //设置标题
    dayLabel.text = timeArr[2];
    //设置字体
    [dayLabel setFont: [UIFont fontWithName:@"LcdD" size:50]];
    //设置对齐方式
    [dayLabel setTextAlignment:NSTextAlignmentCenter];
    //设置文字自动适应
    dayLabel.adjustsFontSizeToFitWidth = YES;
    //设置字体颜色
    [dayLabel setTextColor: [UIColor blackColor]];
    //添加到view中
    [self addSubview:dayLabel];
    /** 小时时间label */
    hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, 100, 50)];
    //设置标题
    hourLabel.text = timeArr[3];
    //设置字体
    [hourLabel setFont: [UIFont fontWithName:@"LcdD" size:50]];
    //设置对齐方式
    [hourLabel setTextAlignment:NSTextAlignmentCenter];
    //设置文字自动适应
    hourLabel.adjustsFontSizeToFitWidth = YES;
    //设置字体颜色
    [hourLabel setTextColor: [UIColor blackColor]];
    //添加到view中
    [self addSubview:hourLabel];
    /** 间隔label */
    intervalLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(90, 150, 50, 50)];
    //设置标题
    intervalLabel3.text = @"：";
    //设置字体
    [intervalLabel3 setFont: [UIFont fontWithName:@"LcdD" size:40]];
    //设置对齐方式
    [intervalLabel3 setTextAlignment:NSTextAlignmentCenter];
    //设置文字自动适应
    intervalLabel3.adjustsFontSizeToFitWidth = YES;
    //设置字体颜色
    [intervalLabel3 setTextColor: [UIColor blackColor]];
    //添加到view中
    [self addSubview:intervalLabel3];
    /** 分钟时间label */
    minuteLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 150, 100, 50)];
    //设置标题
    minuteLabel.text = timeArr[4];
    //设置字体
    [minuteLabel setFont: [UIFont fontWithName:@"LcdD" size:50]];
    //设置对齐方式
    [minuteLabel setTextAlignment:NSTextAlignmentCenter];
    //设置文字自动适应
    minuteLabel.adjustsFontSizeToFitWidth = YES;
    //设置字体颜色
    [minuteLabel setTextColor: [UIColor blackColor]];
    //添加到view中
    [self addSubview:minuteLabel];
    /** 间隔label */
    intervalLabel4 = [[UILabel alloc] initWithFrame:CGRectMake(190, 150, 50, 50)];
    //设置标题
    intervalLabel4.text = @"：";
    //设置字体
    [intervalLabel4 setFont: [UIFont fontWithName:@"LcdD" size:40]];
    //设置对齐方式
    [intervalLabel4 setTextAlignment:NSTextAlignmentCenter];
    //设置文字自动适应
    intervalLabel4.adjustsFontSizeToFitWidth = YES;
    //设置字体颜色
    [intervalLabel4 setTextColor: [UIColor blackColor]];
    //添加到view中
    [self addSubview:intervalLabel4];
    /** 秒时间label */
    secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 150, 100, 50)];
    //设置标题
    secondLabel.text = timeArr[5];
    //设置字体
    [secondLabel setFont: [UIFont fontWithName:@"LcdD" size:50]];
    //设置对齐方式
    [secondLabel setTextAlignment:NSTextAlignmentCenter];
    //设置文字自动适应
    secondLabel.adjustsFontSizeToFitWidth = YES;
    //设置字体颜色
    [secondLabel setTextColor: [UIColor blackColor]];
    //添加到view中
    [self addSubview:secondLabel];
}

#pragma mark - 布局按钮
- (void)setButtonLayout {
    /** 同步系统时间按钮 */
    UIButton *systemTimeBtn = [UIButton buttonWithType: UIButtonTypeSystem];
    systemTimeBtn.frame = CGRectMake(0, 300, 320, 30);
    systemTimeBtn.backgroundColor = [UIColor blackColor];
    [systemTimeBtn setTitle:@"同步到系统时间" forState: UIControlStateNormal];
    [systemTimeBtn setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
    [systemTimeBtn addTarget:self action:@selector(synchronizationSystemTime:) forControlEvents: UIControlEventTouchUpInside];
    [self addSubview:systemTimeBtn];
    /** 设置时间按钮 */
    UIButton *setTimeBtn = [UIButton buttonWithType: UIButtonTypeSystem];
    setTimeBtn.frame = CGRectMake(0, 340, 320, 30);
    setTimeBtn.backgroundColor = [UIColor blackColor];
    [setTimeBtn setTitle:@"设置时间" forState: UIControlStateNormal];
    [setTimeBtn setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal];
    [setTimeBtn addTarget:self action:@selector(setTime:) forControlEvents: UIControlEventTouchUpInside];
    setTimeBtn.tag = 1000;
    [self addSubview:setTimeBtn];
    /** 年份增加按钮 */
    UIButton *addYearBtn = [UIButton buttonWithType: UIButtonTypeSystem];
    addYearBtn.frame = CGRectMake(50, 100, 20, 20);
    addYearBtn.tag = 2000;
    addYearBtn.titleLabel.font = [UIFont fontWithName:@"LcdD" size:28];
    [addYearBtn setTitle:@"+" forState: UIControlStateNormal];
    [addYearBtn setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    [addYearBtn addTarget:self action:@selector(setYearTime:) forControlEvents: UIControlEventTouchUpInside];
    [addReduceButtonArray addObject: addYearBtn];
    [addYearBtn setHidden:YES];
    [self addSubview:addYearBtn];
    /** 年份减少按钮 */
    UIButton *reduceYearBtn = [UIButton buttonWithType: UIButtonTypeSystem];
    reduceYearBtn.frame = CGRectMake(70, 100, 20, 20);
    reduceYearBtn.tag = 2001;
    reduceYearBtn.titleLabel.font = [UIFont fontWithName:@"LcdD" size:28];
    [reduceYearBtn setTitle:@"—" forState: UIControlStateNormal];
    [reduceYearBtn setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    [reduceYearBtn addTarget:self action:@selector(setYearTime:) forControlEvents: UIControlEventTouchUpInside];
    [addReduceButtonArray addObject: reduceYearBtn];
    [reduceYearBtn setHidden:YES];
    [self addSubview:reduceYearBtn];
    /** 月份增加按钮 */
    UIButton *addMonthBtn = [UIButton buttonWithType: UIButtonTypeSystem];
    addMonthBtn.frame = CGRectMake(150, 100, 20, 20);
    addMonthBtn.tag = 2002;
    addMonthBtn.titleLabel.font = [UIFont fontWithName:@"LcdD" size:28];
    [addMonthBtn setTitle:@"+" forState: UIControlStateNormal];
    [addMonthBtn setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    [addMonthBtn addTarget:self action:@selector(setMonthTime:) forControlEvents: UIControlEventTouchUpInside];
    [addReduceButtonArray addObject: addMonthBtn];
    [addMonthBtn setHidden:YES];
    [self addSubview:addMonthBtn];
    /** 月份减少按钮 */
    UIButton *reduceMonthBtn = [UIButton buttonWithType: UIButtonTypeSystem];
    reduceMonthBtn.frame = CGRectMake(170, 100, 20, 20);
    reduceMonthBtn.tag = 2003;
    reduceMonthBtn.titleLabel.font = [UIFont fontWithName:@"LcdD" size:28];
    [reduceMonthBtn setTitle:@"—" forState: UIControlStateNormal];
    [reduceMonthBtn setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    [reduceMonthBtn addTarget:self action:@selector(setMonthTime:) forControlEvents: UIControlEventTouchUpInside];
    [addReduceButtonArray addObject: reduceMonthBtn];
    [reduceMonthBtn setHidden:YES];
    [self addSubview:reduceMonthBtn];
    /** 天增加按钮 */
    UIButton *addDayBtn = [UIButton buttonWithType: UIButtonTypeSystem];
    addDayBtn.frame = CGRectMake(250, 100, 20, 20);
    addDayBtn.tag = 2004;
    addDayBtn.titleLabel.font = [UIFont fontWithName:@"LcdD" size:28];
    [addDayBtn setTitle:@"+" forState: UIControlStateNormal];
    [addDayBtn setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    [addDayBtn addTarget:self action:@selector(setDayTime:) forControlEvents: UIControlEventTouchUpInside];
    [addReduceButtonArray addObject: addDayBtn];
    [addDayBtn setHidden:YES];
    [self addSubview:addDayBtn];
    /** 天减少按钮 */
    UIButton *reduceDayBtn = [UIButton buttonWithType: UIButtonTypeSystem];
    reduceDayBtn.frame = CGRectMake(270, 100, 20, 20);
    reduceDayBtn.tag = 2005;
    reduceDayBtn.titleLabel.font = [UIFont fontWithName:@"LcdD" size:28];
    [reduceDayBtn setTitle:@"—" forState: UIControlStateNormal];
    [reduceDayBtn setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    [reduceDayBtn addTarget:self action:@selector(setDayTime:) forControlEvents: UIControlEventTouchUpInside];
    [addReduceButtonArray addObject: reduceDayBtn];
    [reduceDayBtn setHidden:YES];
    [self addSubview:reduceDayBtn];
    /** 小时增加按钮 */
    UIButton *addHourBtn = [UIButton buttonWithType: UIButtonTypeSystem];
    addHourBtn.frame = CGRectMake(40, 200, 20, 20);
    addHourBtn.tag = 2006;
    addHourBtn.titleLabel.font = [UIFont fontWithName:@"LcdD" size:28];
    [addHourBtn setTitle:@"+" forState: UIControlStateNormal];
    [addHourBtn setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    [addHourBtn addTarget:self action:@selector(setHourTime:) forControlEvents: UIControlEventTouchUpInside];
    [addReduceButtonArray addObject: addHourBtn];
    [addHourBtn setHidden:YES];
    [self addSubview:addHourBtn];
    /** 小时减少按钮 */
    UIButton *reduceHourBtn = [UIButton buttonWithType: UIButtonTypeSystem];
    reduceHourBtn.frame = CGRectMake(60, 200, 20, 20);
    reduceHourBtn.tag = 2007;
    reduceHourBtn.titleLabel.font = [UIFont fontWithName:@"LcdD" size:28];
    [reduceHourBtn setTitle:@"—" forState: UIControlStateNormal];
    [reduceHourBtn setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    [reduceHourBtn addTarget:self action:@selector(setHourTime:) forControlEvents: UIControlEventTouchUpInside];
    [addReduceButtonArray addObject: reduceHourBtn];
    [reduceHourBtn setHidden:YES];
    [self addSubview:reduceHourBtn];
    /** 分钟增加按钮 */
    UIButton *addMinuteBtn = [UIButton buttonWithType: UIButtonTypeSystem];
    addMinuteBtn.frame = CGRectMake(130, 200, 20, 20);
    addMinuteBtn.tag = 2008;
    addMinuteBtn.titleLabel.font = [UIFont fontWithName:@"LcdD" size:28];
    [addMinuteBtn setTitle:@"+" forState: UIControlStateNormal];
    [addMinuteBtn setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    [addMinuteBtn addTarget:self action:@selector(setMinuteTime:) forControlEvents: UIControlEventTouchUpInside];
    [addReduceButtonArray addObject: addMinuteBtn];
    [addMinuteBtn setHidden:YES];
    [self addSubview:addMinuteBtn];
    /** 月份减少按钮 */
    UIButton *reduceMinuteBtn = [UIButton buttonWithType: UIButtonTypeSystem];
    reduceMinuteBtn.frame = CGRectMake(150, 200, 20, 20);
    reduceMinuteBtn.tag = 2009;
    reduceMinuteBtn.titleLabel.font = [UIFont fontWithName:@"LcdD" size:28];
    [reduceMinuteBtn setTitle:@"—" forState: UIControlStateNormal];
    [reduceMinuteBtn setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    [reduceMinuteBtn addTarget:self action:@selector(setMinuteTime:) forControlEvents: UIControlEventTouchUpInside];
    [addReduceButtonArray addObject: reduceMinuteBtn];
    [reduceMinuteBtn setHidden:YES];
    [self addSubview:reduceMinuteBtn];
    /** 秒增加按钮 */
    UIButton *addSecondBtn = [UIButton buttonWithType: UIButtonTypeSystem];
    addSecondBtn.frame = CGRectMake(230, 200, 20, 20);
    addSecondBtn.tag = 2010;
    addSecondBtn.titleLabel.font = [UIFont fontWithName:@"LcdD" size:28];
    [addSecondBtn setTitle:@"+" forState: UIControlStateNormal];
    [addSecondBtn setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    [addSecondBtn addTarget:self action:@selector(setSecondTime:) forControlEvents: UIControlEventTouchUpInside];
    [addReduceButtonArray addObject: addSecondBtn];
    [addSecondBtn setHidden:YES];
    [self addSubview:addSecondBtn];
    /** 秒减少按钮 */
    UIButton *reduceSecondBtn = [UIButton buttonWithType: UIButtonTypeSystem];
    reduceSecondBtn.frame = CGRectMake(250, 200, 20, 20);
    reduceSecondBtn.tag = 2011;
    reduceSecondBtn.titleLabel.font = [UIFont fontWithName:@"LcdD" size:28];
    [reduceSecondBtn setTitle:@"—" forState: UIControlStateNormal];
    [reduceSecondBtn setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    [reduceSecondBtn addTarget:self action:@selector(setSecondTime:) forControlEvents: UIControlEventTouchUpInside];
    [addReduceButtonArray addObject: reduceSecondBtn];
    [reduceSecondBtn setHidden:YES];
    [self addSubview:reduceSecondBtn];

}

#pragma mark - 同步到系统时间
- (void)synchronizationSystemTime:(UIButton *)button {
    //关闭定时器
    [timer invalidate];
    //开启新的系统时间定时器
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(refreshTime) userInfo:nil repeats:YES];
}

#pragma mark - 设置时间
- (void)setTime:(UIButton *)button {
    [timer invalidate];
    if(button.tag == 1000) {
        for (UIButton *btn in addReduceButtonArray) {
            [btn setHidden:NO];
        }
        [button setTitle:@"取消设置" forState: UIControlStateNormal];
        button.tag = 1001;
        intervalLabel3.text = @"：";
        intervalLabel4.text = @"：";
    }else {
        for (UIButton *btn in addReduceButtonArray) {
            [btn setHidden:YES];
        }
        [button setTitle:@"设置" forState: UIControlStateNormal];
        button.tag = 1000;
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(customTime) userInfo:nil repeats:YES];
    }
}

#pragma mark - 自定义时钟算法
- (void)customTime {
    int second = [secondLabel.text intValue];
    if(second%2 == 0) {
        intervalLabel3.text = @" ";
        intervalLabel4.text = @" ";
    } else {
        intervalLabel3.text = @"：";
        intervalLabel4.text = @"：";
    }
    second++;
    secondLabel.text = [NSString stringWithFormat:@"%.2d", second];
    if(second == 60) {
        second = 0;
        secondLabel.text = [NSString stringWithFormat:@"%.2d", second];
        int minute = [minuteLabel.text intValue];
        minute++;
        minuteLabel.text = [NSString stringWithFormat:@"%.2d", minute];
        if(minute == 60) {
            minute = 0;
            minuteLabel.text = [NSString stringWithFormat:@"%.2d", minute];
            int hour = [hourLabel.text intValue];
            hour++;
            hourLabel.text = [NSString stringWithFormat:@"%.2d", hour];
            if(hour == 24) {
                hour = 0;
                hourLabel.text = [NSString stringWithFormat:@"%.2d", hour];
                int day = [dayLabel.text intValue];
                day++;
                dayLabel.text = [NSString stringWithFormat:@"%.2d", day];
                NSArray *month1 = @[@"01",@"03",@"05",@"07",@"08",@"10",@"12"];
                NSArray *month2 = @[@"04",@"06",@"09",@"11"];
                if((day == 32 && [month1 containsObject: monthLabel.text]) || (day == 31 && [month2 containsObject: monthLabel.text]) || ([self isLeapYear] && day == 30) || (![self isLeapYear] && day == 29)) {
                    day = 1;
                    dayLabel.text = [NSString stringWithFormat:@"%.2d", day];
                    int month = [monthLabel.text intValue];
                    month++;
                    monthLabel.text = [NSString stringWithFormat:@"%.2d", month];
                    if(month == 13) {
                        month = 1;
                        monthLabel.text = [NSString stringWithFormat:@"%.2d", month];
                        int year = [yearLabel.text intValue];
                        year++;
                        yearLabel.text = [NSString stringWithFormat:@"%.2d", year];
                    }
                }
            }
        }
        
    }
}

#pragma mark - 设置年份
- (void)setYearTime:(UIButton *)button {
    int year = [yearLabel.text intValue];
    if(button.tag == 2000) {
        year += 1;
    } else {
        year -= 1;
    }
    yearLabel.text = [NSString stringWithFormat:@"%d", year];
    int day = [dayLabel.text intValue];
    int month = [monthLabel.text intValue];
    if(![self isLeapYear] && day > 28 && month == 2) {
        day = 28;
    }
    else if([self isLeapYear] && day > 29 && month == 2) {
        day = 29;
    }
    dayLabel.text = [NSString stringWithFormat:@"%.2d", day];
}

#pragma mark - 设置月份
- (void)setMonthTime:(UIButton *)button {
    int month = [monthLabel.text intValue];
    if(button.tag == 2002) {
        month += 1;
        if(month == 13) {
            month = 1;
        }
    } else {
        month -= 1;
        if(month == 0) {
            month = 12;
        }
    }
    monthLabel.text = [NSString stringWithFormat:@"%.2d", month];
    [self matchingMonthAndDay];
}

#pragma mark - 匹配月份与天
- (void)matchingMonthAndDay {
    int month = [monthLabel.text intValue];
    int day = [dayLabel.text intValue];
    NSArray *monthArr = @[@"04",@"06",@"09",@"11"];
    if([monthArr containsObject:monthLabel.text]) {
        if(day > 30) {
            day = 30;
        }
    } else if([self isLeapYear] && day > 29 && month == 2) {
        day = 29;
    } else if(![self isLeapYear] && day > 28 && month == 2) {
        day = 28;
    }
     dayLabel.text = [NSString stringWithFormat:@"%.2d", day];
}

#pragma mark - 设置天
- (void)setDayTime:(UIButton *)button {
    int maxDay = [self judgeDayFromMonth];
    int day = [dayLabel.text intValue];
    if(button.tag == 2004) {
        day += 1;
        if(day == maxDay+1) {
            day = 1;
        }
    } else {
        day -= 1;
        if(day == 0) {
            day = maxDay;
        }
    }
    dayLabel.text = [NSString stringWithFormat:@"%.2d", day];
}

#pragma mark - 设置小时
- (void)setHourTime:(UIButton *)button {
    int hour = [hourLabel.text intValue];
    if(button.tag == 2006) {
        hour += 1;
        if(hour == 24) {
            hour = 0;
        }
    } else {
        hour -= 1;
        if(hour == -1) {
            hour = 23;
        }
    }
    hourLabel.text = [NSString stringWithFormat:@"%.2d", hour];
}

#pragma mark - 设置分钟
- (void)setMinuteTime:(UIButton *)button {
    int minute = [minuteLabel.text intValue];
    if(button.tag == 2008) {
        minute += 1;
        if(minute == 60) {
            minute = 0;
        }
    } else {
        minute -= 1;
        if(minute == -1) {
            minute = 59;
        }
    }
    minuteLabel.text = [NSString stringWithFormat:@"%.2d", minute];
}

#pragma mark - 设置秒
- (void)setSecondTime:(UIButton *)button {
    int second = [secondLabel.text intValue];
    if(button.tag == 2010) {
        second += 1;
        if(second == 60) {
            second = 0;
        }
    } else {
        second -= 1;
        if(second == -1) {
            second = 59;
        }
    }
    secondLabel.text = [NSString stringWithFormat:@"%.2d", second];
}

#pragma mark - 根据月份判断每月天数
- (int)judgeDayFromMonth {
    int month = [monthLabel.text intValue];
    int maxDay = 0;
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            maxDay = 31;
            break;
        case 4:
        case 6:
        case 9:
        case 11:
            maxDay = 30;
            break;
        case 2:
            if([self isLeapYear]) {
                maxDay = 29;
            } else {
                maxDay = 28;
            }
            break;
        default:
            break;
    }
    return maxDay;
}

#pragma mark - 判断是否是闰年
- (BOOL)isLeapYear {
    int year = [yearLabel.text intValue];
    if((!(year % 4) && year % 100) || !(year % 400)) {
        return YES;
    }
    return NO;
}

#pragma mark - 获取当前时间
- (NSString *)getCurrentTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.S"];
    NSString *currentTime = [dateFormatter stringFromDate:[NSDate date]];
    return currentTime;
}

#pragma mark - 获取初试时间
- (NSString *)getInitTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.S"];
    NSString *initTime = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:0]];
    return initTime;
}

#pragma mark - 拆分时间为字符串
- (NSArray *)splitTimeFromString:(NSString *)timeStr {
    NSMutableArray *retTimeArr = [NSMutableArray array];
    NSArray *mainArr = [timeStr componentsSeparatedByString:@" "];
    NSArray *dateArr = [mainArr[0] componentsSeparatedByString:@"-"];
    NSArray *timeArr = [[[mainArr[1] componentsSeparatedByString:@"."] objectAtIndex:0] componentsSeparatedByString:@":"];
    for (NSString *str in dateArr) {
        [retTimeArr addObject: str];
    }
    for (NSString *str in timeArr) {
        [retTimeArr addObject:str];
    }
    [retTimeArr addObject:[[mainArr[1] componentsSeparatedByString:@"."] objectAtIndex:1]];
    return retTimeArr;
}

#pragma mark - 编辑时间
- (void)editTime:(NSArray *)timeArray {
    if([timeArray[5] intValue]%2 == 0) {
        if([timeArray[6] isEqualToString: @"0"]) {
            intervalLabel3.text = @" ";
            intervalLabel4.text = @" ";
        }
    } else {
        if([timeArray[6] isEqualToString: @"0"]) {
            intervalLabel3.text = @"：";
            intervalLabel4.text = @"：";
        }
    }

    /** 年份时间label */
    yearLabel.text = timeArray[0];
    /** 月份时间label */
    monthLabel.text = timeArray[1];
    /** 天时间label */
    dayLabel.text = timeArray[2];
    /** 小时时间label */
    hourLabel.text = timeArray[3];
    /** 分钟时间label */
    minuteLabel.text = timeArray[4];
    /** 秒时间label */
    secondLabel.text = timeArray[5];
}

#pragma mark - 刷新时间
- (void)refreshTime {
    //编辑时间
    [self editTime:[self splitTimeFromString:[self getCurrentTime]]];
}

@end
