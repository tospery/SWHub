一、版本规划
1、v1.0.0
(1) tabbar
trending|me
2、v1.0.0
(1) tabbar
trending|events|stars|me
3、v1.1.0
(1) tabbar
trending|events|activities|me
(2) 本地化
(3) 暗黑模式

二、技术规范
1、scheme支持
(1) 方法一
https://github.com/ 转换为 swhub://
(2) 方法二
urlScheme=[swhub://user/center的base64字符串]
(3) 通过scheme的check来判断是否需要跳转，或者是否需要弹登录框

三、功能里程
login
profile

四、待办问题
1. RxDatasource的动态
2. 默认的图标
// 所有fullname -> username+reponame
// sampleData 示例
//  repo的描述，自动高度
//  header作为identity其实并不合适
    //  markdown显示图片 https://raw.githubusercontent.com/Renovamen/playground-macos/main/README.md
    // ![night](./public/screenshots/night.png) ->
    // ![night](https://raw.githubusercontent.com/Renovamen/playground-macos/main/public/screenshots/night.png)
//  repo detail显示readme可以延迟显示
//  repo detail 添加 author
用Rx实现延迟的callback的webController更好
自定义下拉刷新
MainScheduler.asyncInstance和MainScheduler.instance的区别
在webview中测试网页地址的识别跳原生
webviewcontroller的关闭和返回功能
推送通知
https://api.github.com/users/tospery/received_events?page=1
需要的图标
需要设计的图标: appicon/applogo/refresh/loadmore/defaulticon
SWFrame把MJRefresh提取出来
fullname -> username+reponame
个人信息中的未提供的字段灰色显示
修改个人信息的时候，比如没有公司信息时的placeholder显示功能
剔除UIWebView后的JSBridge，把内置到SWFrame
SFAuthenticationSession support for http scheme is deprecated and will be removed in a future version of iOS. Use https scheme instead.
Can't end BackgroundTask: no background task exists with identifier 6 (0x6), or it may have already been ended. Break in UIApplicationEndBackgroundTaskError() to debug.
固定UILabel的大小，解决登录后信息显示不全的问题
完善feedback，分开填写title和body
list中的value, issueTitle和issueBody合并为一个data(Any?)
修改Router.Path->isList
username/reponame太长的显示（2两行显示）
summaryUser -> userSummary
SWFrame剔除非必要库，如RxGesture/RxOption等等
README的刷新功能
ListViewReactor的所有子数据添加到Data中
https://docs.github.com/en/rest/reference/search#search-topics 作为搜索热词
搜索历史排重，搜索按钮点击后及时刷新历史
搜索的UserCell，添加User/Organization的区别
清理警告⚠️
登录后进去收藏页面
屏幕适配
initial -> genSectionIfNeed包括(user/data/initial/append)
下拉刷新/加载更多的英文显示
log等级区分，看release版本的本地日志输出来确认
首页的缓存数据，如收藏的缓存
搜索历史的clear


1.0.0需解决的问题
屏幕适配
