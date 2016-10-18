# fww-app
# 使用前先解压 libHyphenateFullSDK.a.zip

## 环信 SDK 为用户开发 IM 相关的应用提供的一套完善的开发框架。包括以下几个部分：

>> a.SDK_Core: 为核心的消息同步协议实现，完成与服务器之间的信息交换。

>> b.SDK: 是基于核心协议实现的完整的 IM 功能，实现了不同类型消息的收发、会话管理、群组、好友、聊天室等功能。

>> c.EaseUI: 是一组 IM 相关的 UI 控件，旨在帮助开发者快速集成环信 SDK。

## SDK 采用模块化设计，每一模块的功能相对独立和完善，选择使用下面的模块：

>> a.EMClient: 是 SDK 的入口，主要完成登录、退出、连接管理等功能。也是获取其他模块的入口。

>> b.EMChatManager: 管理消息的收发，完成会话管理等功能。

>> c.EMContactManager: 负责好友的添加删除，黑名单的管理。

>> d.EMGroupManager: 负责群组的管理，创建、删除群组，管理群组成员等功能。

>> e.EMChatroomManager: 负责聊天室的管理。


## 实物效果图：

## 工程中的picture文件夹就是实物效果图

  登录动画：
  ![image](https://github.com/handy1qq/fww聊天app/raw/master/picture/login.png)

 ![image](https://github.com/handy1qq/fww-app/picture/app.png)

 ![image](https://github.com/handy1qq/fww-app/picture/addfriend.png)

 ![image](https://github.com/handy1qq/fww-app/picture/chat.png)

 ![image](https://github.com/handy1qq/fww-app/picture/chating.png)

 ![image](https://github.com/handy1qq/fww-app/picture/login.png)
