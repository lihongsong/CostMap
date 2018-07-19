//
//  ApiConfigDefine.h
//  HuaQianWuYou
//
//  Created by jason on 2018/5/8.
//  Copyright © 2018年 jason. All rights reserved.
//

#ifndef ApiConfigDefine_h
#define ApiConfigDefine_h

#ifdef DEBUG

#define HOST_PATH @"http://172.16.0.140:3022"


#else

#define HOST_PATH @"http://appjieqian.2345.com/index.php"

#endif

/**
 请求头基本信息
 */
#define REQUESTCOMMONHEADER @{@"content-Type": @"application/json"}

/**
 发现列表数据
 */
#define DISCOVER_LIST @"discover/discoverList"



#endif /* ApiConfigDefine_h */
