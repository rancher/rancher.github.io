---
title: Access Control in Rancher
layout: rancher-default-v1.6-zh
version: v1.6
lang: zh
---

## 访问控制
---

### 什么是访问控制？

访问控制是用来控制哪些用户可以访问你的Rancher服务。在默认情况下，Rancher没有启用访问控制。这意味着知道你的Rancher服务IP的人都可以访问你的Rancher服务和API。你的Rancher服务是对外开放的！我们强烈建议你在启动Rancher后立即配置访问控制，这样你可以按照需要分享你的Rancher服务。用户在访问你的Rancher服务之前，需要进行身份认证。同时，只有拥有合法的API密钥才能使用Rancher API。

Rancher认证的第一个账户将成为 **管理员** 账户。 想要获取有关详细信息，请参阅 [管理员权限]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/access-control/#管理员)。

### 启用访问控制

在 **系统管理** 选项卡中, 点击**访问控制**。

在你配置了Rancher的访问控制后，访问控制将被启用。访问控制使你能够管理不同的[环境]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/)并把它们分享给不同的个人或团队。

当访问控制启用后，Rancher API将被锁定。这时需要用户进行身份认证， 或者使用[API 密钥]({{site.baseurl}}/rancher/{{page.version}}/en/api/v2-beta/api-keys/)来访问它。

#### ACTIVE DIRECTORY

选择**ACTIVE DIRECTORY**图标。 如果你想要通过TLS来使用ACTIVE DIRECTORY，请确保你已经[使用了相应的证书来启动Rancher Server]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/installing-rancher/installing-server/#ldap)。填写相关信息后，通过点击**身份认证**进行认证校验。 当ACTIVE DIRECTORY认证成功后，你将自动以已认证的用户名身份登录，同时把你的账号会被设置为管理员。

##### 用户SEARCH BASE与组SEARCH BASE

在配置ACTIVE DIRECTORY时，你将需要输入用户的SEARCH BASE。 此SEARCH BASE允许Rancher搜索你设置的ACTIVE DIRECTORY中的用户。如果你的用户和用户组位于相同的SEARCH BASE中，那么你**仅仅**需要填写用户的SEARCH BASE，但是如果你的用户组在不同的SEARCH BASE，你可以把该SEARCH BASE填写在`用户组SEARCH BASE`字段下。 此字段专用于用户组搜索，该项是可选的。

#### Azure AD

选择**Azure AD**图标。 填写相应信息并单击**Azure认证**进行认证校验。 当认证成功后，你将自动以已认证的用户名身份登录。并且把你的账号设置为了管理员权限。

#### GitHub

选择**GitHub**图标，并按照用户界面中的说明将Rancher注册为GitHub应用程序。 点击**使用GitHub进行身份认证**后，当认证成功后，你将自动以已认证的Github账号登录。并且把你的账号设置为了管理员权限。

#### 本地身份认证

本地身份认证允许你创建自己的一组账户，这些账户存储在Rancher数据库中。

选择**本地**图标。 通过提供**登录用户名**，**全名**和**密码**来创建管理员用户。 点击**启用本地认证**来启用本地身份认证。 通过单击此按钮，管理员用户将被创建并保存在数据库中。这时你将自动用刚刚创建的管理员帐户登录到Rancher服务。

#### OpenLDAP

填写对应信息后，通过点击**身份认证**进行认证校验。当OpenLDAP认证成功后，你将自动以已认证的用户名身份登录。并且把你的账号设置为了管理员权限。

##### 用户SEARCH BASE与组SEARCH BASE

在配置ACTIVE DIRECTORY时，你将需要输入用户的SEARCH BASE。 此SEARCH BASE允许Rancher搜索你设置的ACTIVE DIRECTORY中的用户。如果你的用户和用户组位于相同的SEARCH BASE中，那么你**仅仅**需要填写用户的SEARCH BASE，但是如果你的用户组在不同的SEARCH BASE，你可以把该SEARCH BASE填写在`用户组SEARCH BASE`字段下。 此字段专用于用户组搜索，该项是可选的。

#### Shibboleth

选择**Shibboleth**图标。 填写Shibboleth帐户的配置信息，点击**保存**保存信息，然后点击**测试**来测试访问控制是否正常工作。

在使用Shibboleth时，你应该注意一些已知的问题。

* 不支持搜索或查找功能。 在添加用户时，请确保输入的用户ID是准确的，这样才能保证用户被添加成功。
* 当添加用户到一个[环境]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/)时, 不支持组ID，除非管理员是该组的成员之一。

### 站点访问

根据你的身份认证类型，Rancher提供不同级别的站点访问。

#### 活动目录/GitHub/Shibboleth

如果你已通过AD或GitHub进行身份认证，则将有3个选项可用。

* **允许任何合法用户** - GitHub或活动目录中的任何用户都可以访问你的Rancher服务。 **不推荐**将此设置用于GitHub，因为它将使GitHub中的任何用户都可以访问Rancher服务。
* **允许环境成员和已授权用户和组织** - 一个环境的成员用户或拥有者用户和添加到`已授权用户和用户组`的用户一样，都有权限访问Rancher服务。
* **限制访问只有已授权用户和用户组可以访问** - 只有添加到`已授权用户和用户组`的用户才能访问Rancher服务。 即使用户已被添加到环境中，如果没有被添加到`已授权用户和用户组`，他们将仍然无法访问Rancher服务。

任何具有Rancher服务访问权限的人都将被授予 [用户]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/accounts/#users)权限。他们将无法查看**系统管理**页面。 如果想要他们查看，你将需要明确地将其帐户更改为[管理员帐户]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/configuration/accounts/#管理员)。

为了让用户查看不同的[环境]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/), 他们将需要被环境的[所有者]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#所有者)添加到环境中。


#### Azure AD/OpenLDAP

对于Azure AD和OpenLDAP，你的设置中的任何用户都可以访问Rancher站点。

#### 本地身份认证

启用本地身份认证后，管理员可以通过访问**系统管理**> **账号设置**选项卡来创建其他管理员/用户。 点击**添加账号**并填写你要添加的帐户的详细信息。 你可以选择其帐户类型为**管理员**或**用户**。 管理员可以查看**系统管理**页面，普通用户无法看到该页面。

一旦帐户被创建后，该账户可以被添加到任何[环境]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/)中。

### 账户类型

帐户类型决定帐户是否可以访问系统管理页面。对于Rancher中的每个环境，可以设置不同级别的[成员角色]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/#成员角色)来对特定环境进行访问。

#### 管理员

认证Rancher的第一个用户成为Rancher的管理员。 只有管理员才有权限查看**系统管理**页面

在管理环境时，管理员可以查看Rancher中的所有[环境]({{site.baseurl}}/rancher/{{page.version}}/{{page.lang}}/environments/)， 即使管理员没有被加入到该环境的成员中。 在非管理员的环境下拉菜单中，用户只能看到他们所在的环境。

管理员可以将其他用户添加为Rancher管理员。 在用户登录Rancher后，他们可以在 **系统管理** > **账号设置**页面上更改用户角色。 在**系统管理**> **账号设置帐户**标签中，点击帐户名称旁边的**编辑**，并将帐户类型更改为管理员。 点击**保存**。

#### 用户

除了用来启用Rancher认证的用户外，任何其他用户都将自动拥有用户权限。 他们将无法看到**系统管理**页面

他们只能看到他们所在的环境。

### 禁用访问控制

如果你决定不再需要访问控制，请单击**禁用访问控制**按钮。 这将使你的Rancher服务向公众开放，任何人都可以访问你的API。 这是**不推荐**的。

### 配置会话超时

默认情况下，会话在其创建后16小时到期。 如果你觉得时间太长，可以更新会话到期时间。

1. 点击**系统管理** -> **系统设置** -> **高级设置**, 点击 **我确认已经知道修改高级设置可能导致问题**。
2. 找到 **api.auth.jwt.token.expiry**设置，然后点击修改按钮。
3. 更新超时会话值后，然后单击**保存**按钮。 值以毫秒为单位。

### 限制并发登陆

_从v1.6.3版开始支持_

在默认情况下，用户可以同时在线。你可以通过API来禁用同时在线的功能。
`api.auth.restrict.concurrent.sessions`.

1. 找到**系统管理** -> **系统设置** -> **高级选项**, 点击 **我确认已经知道修改高级设置可能导致问题**.
2. 找到**api.auth.restrict.concurrent.sessions**设置，然后点击修改按钮。
3. 将值设置为`true`，然后点击**保存**。

一旦该设置生效，在用户下次登陆的时候，之前的登陆口令将会被删除。这样，之前登陆的用户将会被登出。
