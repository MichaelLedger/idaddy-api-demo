# idaddy-api-demo

**口袋故事： 知名的儿童内容云开放平台**

[接入说明](https://www.showdoc.cc/lpgonghan?page_id=1845766170650477)

[工程师爸爸开放平台](https://open.idaddy.cn)是面向0-12岁儿童内容的云开放平台，依托海量正版内容和独特的
“内容+渠道+服务”三位一体合作模式，有效提升儿童智能终端企业的创立和发展过程。

[工程师爸爸开发文档](http://open.idaddy.cn/doc-v3/)

## OAuth2.0授权码模式

授权码模式（authorization code）是功能最完整、流程最严密的授权模式。它的特点就是通过客户端的后台服务器，与"服务提供商"的认证服务器进行互动。

它的步骤如下：

```
（A）用户访问客户端，后者将前者导向认证服务器。

（B）用户选择是否给予客户端授权。

（C）假设用户给予授权，认证服务器将用户导向客户端事先指定的"重定向URI"（redirection URI），同时附上一个授权码。

（D）客户端收到授权码，附上早先的"重定向URI"，向认证服务器申请令牌。这一步是在客户端的后台的服务器上完成的，对用户不可见。

（E）认证服务器核对了授权码和重定向URI，确认无误后，向客户端发送访问令牌（access token）和更新令牌（refresh token）。
```
