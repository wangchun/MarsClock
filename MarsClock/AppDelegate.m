//
//  AppDelegate.m
//  MarsClock
//
//  Created by mkl on 9/1/13.
//  Copyright (c) 2013 higheror. All rights reserved.
//  Copyright (c) 2022 wangchun. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate()
@property (nonatomic, strong) NSStatusItem *statusItem;
@property (nonatomic, strong) NSMenuItem *dateItem;
@property (nonatomic, strong) NSString *timezone;
@property (nonatomic, strong) NSDateFormatter *timeFormatter;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation AppDelegate

-(void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0274912517 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];

    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

    self.timeFormatter = [NSDateFormatter new];
    self.dateFormatter = [NSDateFormatter new];

    self.timeFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    self.timeFormatter.dateFormat = @"hh:mm:ss 'MTC'";

    self.dateFormatter.dateStyle = NSDateFormatterFullStyle;
}

- (void)awakeFromNib
{
    [self setupMenuBar];
}

- (void)setupMenuBar
{
    NSMenu *mainMenu = [NSMenu new];

    self.dateItem = [NSMenuItem new];
    self.dateItem.title = @"";
    self.dateItem.enabled = NO;

    NSMenuItem *quitItem = [NSMenuItem new];
    quitItem.title = @"Quit";
    quitItem.enabled = YES;
    quitItem.action = @selector(quit:);
    [mainMenu addItem:quitItem];

    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:87];
    self.statusItem.button.title = @"";
    self.statusItem.button.cell.highlighted = YES;
    self.statusItem.menu = mainMenu;
}

#pragma mark - Actions
- (void)updateTime
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:((double)(((int64_t)([[NSDate date] timeIntervalSince1970] * 1000) - 947116816577) % 88775244) / 88775244.0) * 86400];

    self.statusItem.button.title = [self.timeFormatter stringFromDate:date];
    self.dateItem.title = [self.dateFormatter stringFromDate:date];
}

- (void)quit:(id)sender
{
    [[NSApplication sharedApplication] terminate:nil];
}

@end
