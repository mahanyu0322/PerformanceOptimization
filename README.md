### PerformanceOptimization主要有两大模块
#### 模块一
主要功能:防止crash造成APP闪退
防止以下异常情况
* NSArray
	* arrayWithObjects:count:
	* objectsAtIndexes:
	* objectAtIndex:
	* objectAtIndexedSubscript:
	* getObjects:range:
* NSMutableArray
	* objectAtIndex:
	* objectAtIndexedSubscript:
	* setObject:atIndexedSubscript:
	* removeObjectAtIndex:
	* insertObject:atIndex:
	* getObjects:range:
* NSDictionary
	* dictionaryWithObjects:forKeys:count:
* NSMutableDictionary
	* setObject:forKey:
	* setObject:forKeyedSubscript:
	* removeObjectForKey:
* NSString
	* characterAtIndex:
	* substringFromIndex:
	* substringToIndex:
	* substringWithRange:
	* stringByReplacingOccurrencesOfString:withString:
	* stringByReplacingOccurrencesOfString:withString:options:range:
	* stringByReplacingCharactersInRange:withString:
	* stringByAppendingString:
* NSPathStore2
	* stringByAppendingString:
* NSMutableString
	* replaceCharactersInRange:withString:
	* insertString:atIndex:
	* deleteCharactersInRange:
* NSAttributedString
	* initWithString:
	* initWithAttributedString:
	* initWithString:attributes:
* NSMutableAttributedString
	* initWithString:
	* initWithString:attributes:
* NSData
	* initWithLength:
	* replaceBytesInRange:withBytes:length:
* NSSet
	* initWithObjects:
* NSMutableSet
	* initWithCapacity:
	* addObject:
	* removeObject:
* NSIndexSet
	* initWithIndex:
* UIView
	* setNeedsLayout
	* layoutIfNeeded
	* layoutSubviews
	* setNeedsUpdateConstraints
* NSTimer
	* scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:
* OtherCrash
	* RunLoop防止Crash

监听异常方法基本上都是采用Runtime的方法交换进行拦截处理,用@try代码段处理异常
```objectivec
@try {
        //调用交换后的方法
    } @catch (NSException *exception) {
        //处理异常
    } @finally {
        
    }
```
eg:
```objectivec
	unichar characteristic;
    @try {
        characteristic = [self mhl_characterAtIndex:index];
    }
    @catch (NSException *exception) {
        [OptimizeCrash errorWithException:exception];
    }
    @finally {
        return characteristic;
    }
```
如有交换方法无法拦截到的异常,采用runloop异常拦截后开启线程保活进行"兜底"
```objectivec
	while (1) {
        for (NSString *mode in (__bridge NSArray *)allModes) {
            //快速切换Mode
            CFRunLoopRunInMode((CFStringRef)mode, 0.001, false);
        }
    }
```
详细可参考源码!
使用方法
在AppDelegate.m中的didFinishLaunchingWithOptions:方法中调用
```objectivec
/**
 * 开启crash优化
 * @param isPrintLogs 是否在控制台打印信息
 * @param isListeningMethod 是否监听方法异常
 * @param block 回调
 */
+ (void)startOptimizeCrashIsPrintLogs:(BOOL)isPrintLogs isListeningMethod:(BOOL)isListeningMethod Block:(CrashResultBlock)block;
```
如
```objectivec
[OptimizeCrash startOptimizeCrashIsPrintLogs:YES isListeningMethod:YES Block:^(OptimizeCrashResult*optimizeCrashResult) {
		//可在此处进行crash数据收集,发送到自己的服务器上
        NSLog(@"回调的数据%@",optimizeCrashResult.errorReason);
    }];
```
其中`OptimizeCrashResult`类是异常信息类
```objectivec
/**
 * 错误名称
 */
@property(nonatomic, copy) NSString *errorName;
/**
 * 错误原因
 */
@property(nonatomic, copy) NSString *errorReason;
/**
 * 错误坐标
 */
@property(nonatomic, copy) NSString *errorPlace;
/**
 * 调用栈
 */
@property(nonatomic, strong) NSArray *callStackSymbols;
/**
 * 异常信息
 */
@property(nonatomic, strong) NSException *exception;
```

>ps:建议正式环境下开启,可有效防止APP异常退出,如果开发环境下开启,遇到异常时只会在控制台输出异常信息,不会造成程序退出,不容易及时发现问题.
