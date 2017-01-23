//
//  URLBaseConfig.h
//  moxuyou_Base
//
//  Created by moxuyou on 2016/12/13.
//  Copyright © 2016年 moxuyou. All rights reserved.
//

#ifndef URLBaseConfig_h
#define URLBaseConfig_h

#define P_M_BASE_URL          @"https://m.ifangchou.com"
#define P_Host                @"https://mapi.ifangchou.com"
#define P_SHARE_BASE_URL      @"https://www.ifangchou.com"

#define T_M_BASE_URL          @"https://mtest1.ifangchou.com"
#define T_Host                @"http://rap.taobao.org/mockjs/2950"//测试数据用淘宝的RAP
#define T_SHARE_BASE_URL      @"https://test1.ifangchou.com"

// 内网的url
//#define url_path @"http://192.168.21.222/metaltrade/api/index.php"
//http://14.23.32.50:8888/
//#define url_path @"http://14.23.32.50:8888/metaltrade/api/index.php"

#define JPushRelease 1/*极光推送 0开发证书 1生产证书*/

/*
 
 关于内网和外网 测试环境与生产环境 的几个关系
 
 Is_Release         0线下         1线上       --> 线上&线下决定了 证书是开发证书还是生产证书
 IS_Product         0测试环境      1生产环境    -->  测试&生产环境决定了 银联测试&生产环境、socket数据
 Is_Extranet        0内网         1外网       --> 内网&外网决定了 网络环境（服务器数据）
 
 需要发布App 只要更改 Is_Release --> 1
 
 */

#define Is_Release 1 /* 0线下 1线上*/





/*线上 & 线下*/
#if Is_Release
#define IS_Product 1
#define Is_Extranet 1
#else //线下环境 IS_Product & Is_Extranet 可以任意更改
#define IS_Product 0
#define Is_Extranet 1 //线下版本可以使外网也可以是内网
#endif


/*生产环境 & 测试环境*/
#if IS_Product
#define kUPPAY_TN_MODE @"00"
#define SocketIp @"120.132.145.19"
#define SocketPort 8282
#define url_path @"http://zswpapi.682.com:8182/index.php"
#else
#define kUPPAY_TN_MODE @"00"  //银联测试环境 01
#define SocketIp @"120.132.145.20"//@"114.67.49.25"
#define SocketPort 7272
#define url_path @"http://testzswpapi.1889.com/index.php"
#endif


/* ------外网或者内网------ */
#if Is_Extranet
//外网
#define NetEnvironment @"product"
#else
//内网
//http://192.168.21.222/metaltrade/api/index.php
#define NetEnvironment @"test"
#endif









//接口配置
#define KRDATA @"rData"
#define KRKEY @"rKey"
#define KRKEY_VALUE @"rKey_value"


#endif /* URLBaseConfig_h */
