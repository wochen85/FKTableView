# FKTableView
配合RAC简化UITableView的使用

# 安装方法：
pod 'FKTableView'

# 使用
对做iOS开发的同学来说，写UI的过程中，最熟悉的、用的最多的也莫过于UITableView了吧，相信大家对这货的使用也已经炉火纯青：
1. alloc 一个实例
2. 塞到view中
3. 指定datasource
4. 书写datasource的协议方法，返回cell
5. 定义一个MyTableViewCell的类，它继承自UITableViewCell

于是你写下了形如以下的代码：
```
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"mycell";
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    [cell bindData:self.dataArr[indexPath.row]];
    
    return cell;
}
```
> 限于篇幅，上文没有贴出MyTableViewCell的代码，自行脑补吧。

大概经过以上几步，一个UITableView便会呈现在手机上，牛逼。

那么让我们进一步往下看，如果产品经理要求tableview的某一行可以点击触发一个子业务。你肯定会想：嗯，这个难不倒我，我可是熟练工。于是你写下了如下的代码：

- 首先，你给tableview指定了一个代理：
```
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
```
- 然后，写下了代理类方法如下：
```
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //巴拉巴拉
}
```

完美，打完收工。

可是产品经理还是不省心啊，大中午的，你刚打开王者荣耀，游戏还在检测更新，他又来烦你了，这次是要在tableview的每一行都加一个按钮，然后点击这个按钮可以处理相应的业务（比如订单的支付按钮？）。
这时你已经有点不爽了，但是你还是能搞定，这难不倒你。于是你关掉王者荣耀，整理了一下思路：
1. 在MyTableViewCell里加一个button
2. 给这个button来一个addTarget，指定action
3. 在button的action中去做事情
4. 3中提到的事情需要通过block回调到viewcontroller中去进行，以保证cell的业务无关性
5. 在viewcontroller中实现cell的block，进行相关业务执行

嗯，就是这样，虽然有点烦，尤其是写那个鸟block，但是你还是写下了如下的代码：

- 首先，你在你的MyTableViewCell中定义了一个属性：
```
@property (nonatomic, copy) void(^payBlock)(void);
```
- 然后，在你的ViewController的cellFor函数中加了一句：
```
cell.payBlock = ^{
    //布拉布拉
};
```
> 限于篇幅，省略了cell里面的代码修改。

到了这里，你松了一口气，这下应该完美了吧，一看小米手环4彩屏版，靠，午休时间就剩半小时了，赶紧睡个觉。

可是万万没想到啊，产品经理又来了，他说，这些订单要分块，每一块有个标题，标题颜色还不一样，然后标题旁边还有一个操作按钮，点了这个按钮之后要对这块订单进行批量支付。

你以为这就完了？当然没有，还要求订单列表的上方要展示一个活动横幅，用于公司爆款产品的推荐，横幅里面也有一个按钮，点这个按钮，可以跳转到相应的产品页面。

相信到了这里，你心中已经有一两只草泥马在奔跑（注意文明），但是你还是强忍着怒气，又开始了整理思路：
- 首先，要把tableview改成分组模式
- 要添加numberOfSectionsInTableView和- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section方法，里面又要用到dequeueReusableHeaderFooterViewWithIdentifier方法等
- 要写一个MySectionView，用作viewForHeaderInSection的返回
- 在在MySectionView里写button，然后就是block回调给viewcontroller

这还没完，你还没整理那个横幅的思路呢，要写形如`self.tableHeaderView = [MyBanner new];`的代码，要处理这个view的高度，里面的按钮操作，又要写block往外面回调。

你甚至能够想到，也许产品经理还会提在某个cell后面随机插入一条广告的cell等等变态需求，你的心情为此低落到了极点。

想到这里，尽管思路还是很清晰，但是你有没有感觉，你已经不太想写这些代码了，总感觉很烦，但是又说不清楚为什么。

那么好，下面我们来梳理一下所遇到的问题。

以上是常规写法，相信很多开发者也是这么做的。但是这里存在几个问题：
1. 要手动指定datasource和delegate
2. viewcontroller要遵从UITableViewDataSource和UITableViewDelegate这两个协议
3. 要实现UITableViewDataSource和UITableViewDelegate的一堆协议方法，而且每写一个列表页面，都要写这种方法，十分冗余，烦不烦？
4. cell、sectionview、headerView中的操作要用block往外回调，我想问问喜欢写block的有几个
5. 如果是那种数据源不同的tableview，需要临时去掉某个cell，或新增一个cell，或调整两个cell的显示顺序，你至少需要改动两个方法：`- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section`和`- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath`，如果是分组类型的tableview，你还要改`- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView`，如果每个cell有点击操作，你还要改`- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath`，呼，好多，改不好就出错了。
6. 逻辑分层很模糊，有的人直接把业务逻辑写在cell里，你说是对是错，这个我觉得见仁见智了，也有人在cell里直接定义一个类方法，直接返回cell，像这样：
`+ (instancetype) cellForTableView:(UITableView*) tableView model:(MyOrderModel*)model`
7. 如果要添加tablewview的header，需要自己去考虑它的高度，因为它看起来总不是那么听话。
8. 一旦业务逻辑改变，我上面枚举的3~7都可能会改变

#### 那么，如何解决这些问题呢？
答案：https://github.com/wochen85/FKTableView

前置条件：
> 1. 对RAC有一丢丢了解，不了解也没关系~~
> 2. 没了

---------
### Round 1 核心函数
都在`UITableView+FKExtension.h`这个头文件里了：
```
@interface UITableView (FKExtension)
-(void) fk_configRowModels:(NSArray<FKCellModel*>*) rowModels;
-(void) fk_configSectionModels:(NSArray<FKSectionModel*>*) sectionModels;
-(void) fk_configHeader:(nullable FKViewModel*) headerModel height:(CGFloat) height;
-(void) fk_configFooter:(FKViewModel*) footerModel height:(CGFloat) height;
@end
```
> 以上函数，暂不做解释说明，后面会一步步用到。

### Round 2 简单示例
假设我们要做一个设置页面，它长这样：

![1563419692489.jpg](https://i.loli.net/2019/07/18/5d2fe440428b251026.jpg)

按以下步骤即可：

1. 创建tablewview
```
@interface SettingViewController ()
@property (nonatomic, strong) UITableView* tablewView;
@end

- (UITableView *)tablewView
{
    if (!_tablewView)
    {
        _tablewView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tablewView.tableFooterView = [UIView new];
    }
    return _tablewView;
}
```
> 注意，此处SettingViewController不需要遵从UITableViewDataSource和UITableViewDelegate这两个协议

2. 把tablewView加入view，进行布局
```
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self configTableView];
}

- (void) configTableView
{
    [self.view addSubview:self.tablewView];
    [self.tablewView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
```
> 至此，和你以前的操作步骤应该相差不大。

3. 由于列表的前3项布局一样，所以可以用同一个cell：
```
@interface TextSettingCell()
@property (nonatomic, strong) UILabel* txtLabel;
@end

@implementation TextSettingCell
- (UILabel *)txtLabel
{
    if (!_txtLabel)
    {
        _txtLabel = [UILabel new];
    }
    return _txtLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initSubViews];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

-(void) initSubViews
{
    [self.contentView addSubview:self.txtLabel];
    [self.txtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.right.mas_equalTo(-10);
    }];
}
```

4. 和3差不多，创建一个switch的cell，用于夜间模式切换
```
@interface SwitchSettingCell()
@property (nonatomic, strong) UILabel* txtLabel;
@property (nonatomic, strong) UISwitch* switcher;
@end

@implementation SwitchSettingCell

- (UILabel *)txtLabel
{
    if (!_txtLabel)
    {
        _txtLabel = [UILabel new];
    }
    return _txtLabel;
}

- (UISwitch *)switcher
{
    if (!_switcher)
    {
        _switcher = [UISwitch new];
    }
    return _switcher;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self initSubViews];
    }
    return self;
}

-(void) initSubViews
{
    [self.contentView addSubview:self.txtLabel];
    [self.contentView addSubview:self.switcher];
    [self.txtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.right.mas_equalTo(self.switcher.mas_left);
    }];
    
    [self.switcher mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
    }];
}
```
> 到了这里，仍然还是熟悉的味道，你肯定忍不住想去ViewController里写UITableViewDataSource的协议方法了，是不是？但是你要记住，我们在第一步里并没有设置tablewView的数据源。

5. boss登场，定义TextSettingCellModel类
```
@interface TextSettingCellModel : FKCellModel
@property (nonatomic, copy) NSString* txt;
- (instancetype)initWithText:(NSString*) txt;
@end

@implementation TextSettingCellModel
- (instancetype)initWithText:(NSString*) txt
{
    self = [super init];
    if (self) {
        _txt = txt;
    }
    return self;
}
@end
```

> 注意这货的命名，它只是在TextSettingCell类名后面加上“Model”字样。这是FKTableView的默认命名约定，当然，你也可以不这么写，后面会说。

6. 同理，定义SwitchSettingCellModel类
```
@interface SwitchSettingCellModel : FKCellModel
@property (nonatomic, copy) NSString* txt;
@property (nonatomic) BOOL switchOn;
- (instancetype)initWithText:(NSString*) txt switchOn:(BOOL)switchOn;
@end

@implementation SwitchSettingCellModel
- (instancetype)initWithText:(NSString*) txt switchOn:(BOOL)switchOn
{
    self = [super init];
    if (self) {
        _txt = txt;
        _switchOn = switchOn;
    }
    return self;
}
@end
```

7. 在TextSettingCell里处理数据绑定
- 包含`#import <FKTableView.h>`和`#import "TextSettingCellModel.h"`头文件
- 包含了`FKTableView.h`头文件后，敲击“FK”字样，则会联想出父类的`(void)fk_bindModel:(id)model`函数
- 修改函数参数类型为`TextSettingCellModel`，并完成绑定数据的代码：
```
- (void)fk_bindModel:(TextSettingCellModel*)model
{
    self.txtLabel.text = model.txt;
}
```

8. 同理，`SwitchSettingCell`也做数据绑定
```
- (void)fk_bindModel:(SwitchSettingCellModel*)model
{
    self.txtLabel.text = model.txt;
    self.switcher.on = model.switchOn;
}
```

9. 现在可以来处理ViewContrller了，先包含头文件`#import <FKTableView.h>`，然后在原来的`configTableView`函数里，加入以下代码:
```
    //编辑资料
    TextSettingCellModel* editProfileCellModel = [[TextSettingCellModel alloc] initWithText:@"编辑资料"];
    //账号和隐私设置
    TextSettingCellModel* accountCellModel = [[TextSettingCellModel alloc] initWithText:@"账号和隐私设置"];
    //黑名单
    TextSettingCellModel* blackListCellModel = [[TextSettingCellModel alloc] initWithText:@"黑名单"];
    //夜间模式
    SwitchSettingCellModel* nightModeCellModel = [[SwitchSettingCellModel alloc] initWithText:@"夜间模式" switchOn:NO];
    
    [self.tablewView fk_configRowModels:@[editProfileCellModel, accountCellModel, blackListCellModel, nightModeCellModel]];
```
至此，这个页面就算完成了，为了力求讲的明细，所以步骤列的过于多，其实总结下来只有如下几步骤：
- 创建cell
- 创建cellModel
- cell绑定cellModel
- viewcontroller中进行`fk_configRowModels`

下面，让我们再来看看这么做的好处在哪里。
- 不需要指定viewcontroller遵从`UITableViewDataSource`和`UITableViewDelegate`协议
- 不需要手动指定tableview的`dataSource`和`delegate`
- 不需要实现UITableViewDataSource和UITableViewDelegate的一堆协议方法
> 那么dataSource和delegate到底是谁呢，没有这两货，tableview自己可玩不转啊，没错，就是要让它自己玩转，自己的事情自己去做去吧，具体可以看下`UITableView+FKExtension.m`文件。

### Round 3 处理cell的点击事件

你会不会又不由自主的想到要实现`- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath`方法了？

现在只需要去改cellModel，来订阅它的selectedSignal信号：

```
    //编辑资料
    TextSettingCellModel* editProfileCellModel = [[TextSettingCellModel alloc] initWithText:@"编辑资料"];
    [editProfileCellModel.selectedSignal subscribeNext:^(FKCellModel * _Nullable x) {
        [SVProgressHUD showInfoWithStatus:@"你点击了\"编辑资料\""];
    }];
    //账号和隐私设置
    TextSettingCellModel* accountCellModel = [[TextSettingCellModel alloc] initWithText:@"账号和隐私设置"];
    [accountCellModel.selectedSignal subscribeNext:^(FKCellModel * _Nullable x) {
        [SVProgressHUD showInfoWithStatus:@"你点击了\"账号和隐私设置\""];
    }];
    //黑名单
    TextSettingCellModel* blackListCellModel = [[TextSettingCellModel alloc] initWithText:@"黑名单"];
    [blackListCellModel.selectedSignal subscribeNext:^(FKCellModel * _Nullable x) {
        [SVProgressHUD showInfoWithStatus:@"你点击了\"黑名单\""];
    }];
```
> 有没有这种感觉，cell的数据存储，和操作存储都放到了cellModel里去，其实我们的tableview要做的事情无非也就这两样：展示数据（固定的或者从网络获取的）、对用户的操作做出响应。

优点： 
- 不用再去实现`- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath`这个方法

### Round 4 处理cell内部的控件事件

这里便以“夜间模式”这个cell的UISwitch控件的切换作为演示。

1. 加入`_switcher`的事件监听，这是不可避免的
```
- (UISwitch *)switcher
{
    if (!_switcher)
    {
        _switcher = [UISwitch new];
        [_switcher addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _switcher;
}

-(void) switchChanged:(UISwitch*) sender
{
    
}
```
> 到这里你是不是又想在`switchChanged`这个函数里去写block了？现在不要这么做做，因为定义block毕竟是很蛋疼的事情，所以你可以像下面这样做。

2. 在`SwitchSettingCellModel`里定义一个`RACSubject`

```
@property (nonatomic, strong) RACSubject<NSNumber*>* switchChangeSignal;

- (RACSubject<NSNumber*>*)switchChangeSignal
{
    if (!_switchChangeSignal)
    {
        _switchChangeSignal = [RACSubject subject];
    }
    return _switchChangeSignal;
}
```
> 有没有发现和前面用到的`selectedSignal`很像，他们的确是一样的用法，只不过`selectedSignal`这货是每个cellModel都可能需要支持的（毕竟大部分的cell都有可能要支持列表项点击），所以我把它放到了基类`FKCellModel`中去。

3. 把cell中UISwitch的点击事件通过上面定义的`switchChangeSignal`信号发送出去

```
-(void) switchChanged:(UISwitch*) sender
{
    SwitchSettingCellModel* cellModel = (SwitchSettingCellModel*)self.fk_viewModel;
    [cellModel.switchChangeSignal sendNext:@(sender.isOn)];
}
```
> fk_viewModel是每个`UIView+FKExtension`扩展的一个属性，它的类型就是你前文书写`fk_bindModel`函数时的参数类型。

4. 在viewcontroller中来监听cellModel的这个`switchChangeSignal`信号
```
    //夜间模式
    SwitchSettingCellModel* nightModeCellModel = [[SwitchSettingCellModel alloc] initWithText:@"夜间模式" switchOn:NO];
    [nightModeCellModel.switchChangeSignal subscribeNext:^(NSNumber * _Nullable x) {
        [SVProgressHUD showInfoWithStatus:x.boolValue?@"夜间模式 打开":@"夜间模式 关闭"];
    }];
```

下面再来列举下有哪些优点：
- 不用在cell中去定义block，而是将cell内部的事件处理抛给cellModel，cellModel再通过信号传递给viewcontroller。

### Round 5 应对业务改变

1. cell的顺序改变

比如“黑名单”要和“编辑资料”换个位置
我们先看看老式写法要做什么

首先，他要去改`- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath`这个函数，然后通过`indexPath`来判断哪一行显示哪一个，很容易出错。

其次，因为他的点击事件是在`- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath`这个函数里来写的，所以这里也要改，还是通过`indexPath`来判断哪一行被点击了，一不小心，又出错了。

那么，FKTableView怎么做呢？
你只需要更改下`fk_configRowModels`这个函数的参数数组顺序即可。
```
[self.tablewView fk_configRowModels:@[blackListCellModel, accountCellModel, editProfileCellModel, nightModeCellModel]];
```
> 是不是很爽？还不会出错，你不用去考虑点击事件，因为他已经被封装在cellModel里了，不论它被放到了tableview的哪个位置，它的点击事件都会跟着走。

2. 删除某个cell

你可能已经想到了，和cell顺序改变没啥两样，你只需要把要删除的cell对应的cellModel从数组重删除即可，比如要删除“夜间模式”:
```
[self.tablewView fk_configRowModels:@[editProfileCellModel, accountCellModel, blackListCellModel]
```
3. 新增一个cell

不再赘述，直接给`fk_configRowModels`的参数增加一个cellModel即可。


### Round 6 设置section的header和footer

比如，需要把“编辑资料”和“账号和隐私设置”放入一个section，而“黑名单”和“夜间模式”放入另一个的section。长得是下面这样的：

![1563434035685.jpg](https://i.loli.net/2019/07/18/5d301c50128e327614.jpg)

你只需在viewcontroller中要把原来的
```
[self.tablewView fk_configRowModels:@[editProfileCellModel, accountCellModel, blackListCellModel, nightModeCellModel]];
```
替换成：
```
    FKSectionHeaderFooterConfig* basicSectionHeadConfig = [[FKSectionHeaderFooterConfig alloc] initWithHeight:40 headFooterModel:nil];
    FKSectionModel* basicSectionModel = [[FKSectionModel alloc] initWithRowModels:@[editProfileCellModel, accountCellModel] headConfig:basicSectionHeadConfig footConfig:nil];
    FKSectionHeaderFooterConfig* otherSectionHeadConfig = [[FKSectionHeaderFooterConfig alloc] initWithHeight:40 headFooterModel:nil];
    FKSectionModel* otherSectionModel = [[FKSectionModel alloc] initWithRowModels:@[blackListCellModel, nightModeCellModel] headConfig:otherSectionHeadConfig footConfig:nil];
    [self.tablewView fk_configSectionModels:@[basicSectionModel, otherSectionModel]];
```
搞定！
产品说，要给第一个section加个标题，叫“基本设置”，第二个section加个标题，叫“其他设置”，长得这个鬼样：

![1563434709216.jpg](https://i.loli.net/2019/07/18/5d301ee6a71a726333.jpg)

那么你只需要给`FKSectionHeaderFooterConfig`指定一下`headFooterModel`参数，具体如下：

```
    FKHeaderFooterCommonModel* basicSectionHeaderModel = [[FKHeaderFooterCommonModel alloc] initWithText:[[NSAttributedString alloc] initWithString:@"基本设置"] bgColor:[UIColor clearColor] textAlignment:NSTextAlignmentCenter];
    FKSectionHeaderFooterConfig* basicSectionHeadConfig = [[FKSectionHeaderFooterConfig alloc] initWithHeight:40 headFooterModel:basicSectionHeaderModel];
    FKSectionModel* basicSectionModel = [[FKSectionModel alloc] initWithRowModels:@[editProfileCellModel, accountCellModel] headConfig:basicSectionHeadConfig footConfig:nil];
    
    FKHeaderFooterCommonModel* otherSectionHeaderModel = [[FKHeaderFooterCommonModel alloc] initWithText:[[NSAttributedString alloc] initWithString:@"其他设置"] bgColor:[UIColor clearColor] textAlignment:NSTextAlignmentCenter];
    FKSectionHeaderFooterConfig* otherSectionHeadConfig = [[FKSectionHeaderFooterConfig alloc] initWithHeight:40 headFooterModel:otherSectionHeaderModel];
    FKSectionModel* otherSectionModel = [[FKSectionModel alloc] initWithRowModels:@[blackListCellModel, nightModeCellModel] headConfig:otherSectionHeadConfig footConfig:nil];
    
    [self.tablewView fk_configSectionModels:@[basicSectionModel, otherSectionModel]];
```
> `FKHeaderFooterCommonModel`是考虑到tableview会经常用到这种只带有一个背景色和一串文本的sectionheader、sectionheader而内置到框架里的，至于其它类型的sectionheader、sectionheader可以参考`FKHeaderFooterCommonModel`和`FKHeaderFooterCommon`的写法自己去自定义，另外github上工程代码也有提供样例（`MyBookSectionHeadFootModel`类和`BookSectionHeadFoot`类），这里不再赘述。

另外，`FKHeaderFooterCommonModel`这个类也提供了一个`clickSignal`来发送section的点击事件。
你可以这么用：
```
[basicSectionHeaderModel.clickSignal subscribeNext:^(id  _Nullable x) {
        [SVProgressHUD showInfoWithStatus:@"你点击了基本设置"];
    }];
```

### Round 7 cellModel和cell不遵守类命名约定

前面提到过，cell与cellModel要遵守命名约定，具体来说就是cell如果是`xxx`,那么对应的`model`就应该是`xxxModel`(注意M大写)。
但是存在这么一种情况，你就是不想这么写，或者粗心大意写错了，那么可以在`cellModel`中重写一下`- (NSString *)nibOrClassName`这个方法，返回cell对应的nib或者class的名称。

比如，你的cell是`SettingCell`，而你的cellModel不小心写成了`MySettingCellModel`，那么只要在`MySettingCellModel.m`中：
```
- (NSString *)nibOrClassName
{
    return NSStringFromClass([SettingCell class]);
}
```

### Round 8 设置tablewview的header和footer

使用`UITableView+FKExtension`分类的如下两个方法：
```
-(void) fk_configHeader:(nullable FKViewModel*) headerModel height:(CGFloat) height;
-(void) fk_configFooter:(FKViewModel*) footerModel height:(CGFloat) height;
```
> 这里的`FKViewModel`你应该很熟悉了，前面一直用的FKCellModel就是继承它的。使用基本类似，不再赘述。

---------
总结：
> `FKTableView`依赖`FKTableCollectionExtensionBase`，这是`FKTableView`和[FKCollectionView](https://github.com/wochen85/FKCollectionView)公共功能的提取（`FKCollectionView`有时间我会单独写文章介绍），`FKTableCollectionExtensionBase`中有一个类`FKViewModel`，它是`FKTableView`赖以生存的基础，前面已经看到，我们的ViewController只跟Model打交道（CellModel、SectionHeadFootModel、TableHeadFootModel等），虽然我们也创建了对应的Cell、SectionHeadFoot、TableHeadFoot等UIView的子类，但是并没有直接去创建这些类的实例。就是基于`FKViewModel`这个类的`nibOrClassName`属性。

附注：
> 细心的朋友可能注意到，前面一直没有提到关于cell的高度的相关介绍，这是基于iOS自带的自动布局来计算的，也就是说在xib、storyboard或者Masonry中去布局cell时，要有一条自上而下的连贯约束，通过这条垂直的连贯约束，cell会被自动“撑高”到它合适的高度。

> 另外FKTableView同时支持xib和纯代码来书写Cell和View，本文只提供了纯代码的方式，xib的方式，参考工程代码，遇到问题的希望提出issue，喜欢的话麻烦给个小星星，谢谢。

