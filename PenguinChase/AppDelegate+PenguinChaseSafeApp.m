//
//  AppDelegate+PenguinChaseSafeApp.m
//  PenguinChase
//
//  Created by zjlk03 on 2021/7/7.
//

#import "AppDelegate+PenguinChaseSafeApp.h"
#import "PenguinChaseDongtaiModel.h"
#import "PenguinChaseComentModel.h"
#import "PenguinChatMessageListModel.h"
#import "PenguinChaseMessageDetailModel.h"
#import "PenguinChaseVideoModel.h"
#import "PenguinHuatiLeftMoel.h"
#import "PenguinChaseVideoComentModel.h"
@implementation AppDelegate (PenguinChaseSafeApp)
+(void)load{
    [self PenguinChaseDongtaiModelConfigers];
    [self PenguinChaseComentModelConfigers];
    [self PenguinChatMessageListModelConfigers];
    [self PenguinChaseMessageDetailModelConfigers];
    [self PenguinHuatiLeftMoelConfigers];
    [self PenguinChaseVideoModelConfigers];
    [self PenguinChaseVideoComentModelConfigers];
}
+(void)PenguinChaseDongtaiModelConfigers{
    
    NSMutableArray * tempArr = [NSMutableArray array];
    PenguinChaseDongtaiModel * penguinModel = [[PenguinChaseDongtaiModel alloc]init];
    penguinModel.headerImgurl = @"https://img2.doubanio.com/icon/u214422614-2.jpg";
    penguinModel.userName = @"卡列宁_ ";
    penguinModel.userLevel =2;
    penguinModel.time = @"2021-07-03 01:15:47";
    penguinModel.content = @"电影角度来说很差，流水账一般的叙事，有点名气的演员有好几十个，其中至少20个角色只是露脸对剧情没有推动作用，每个人露脸2分钟，就是40分钟！";
    penguinModel.imgArr = @[@"https://img2.doubanio.com/view/photo/l/public/p2663174502.jpg",@"https://img9.doubanio.com/view/photo/l/public/p2663174504.jpg"];
    penguinModel.userID = 0;
    penguinModel.isLike = NO;
    penguinModel.CellHeight = 0;
    [tempArr addObject:penguinModel];
    
    
    
    PenguinChaseDongtaiModel * penguinModel1 = [[PenguinChaseDongtaiModel alloc]init];
    penguinModel1.headerImgurl = @"https://img9.doubanio.com/icon/u53672944-24.jpg";
    penguinModel1.userName = @"冷暖自知";
    penguinModel1.userLevel = 0;
    penguinModel1.time = @"2021-06-19";
    penguinModel1.content = @"首映有幸看过影片，这部片子对1921那段历史非常还原，平均28岁的13位“一大代表”很有青春感，黄轩和倪妮的伉俪情深也感人戳泪，黄建新真的做到了创新，回顾全片，节奏、人物以及时局都展现的特别好，这是一次全新的尝试还原历史的影片，也算是给我上了一节历史课。能在今年看这部电影，也算是给党庆生了。";
    penguinModel1.imgArr = @[@"https://img2.doubanio.com/view/photo/l/public/p2663175522.jpg",@"https://img3.doubanio.com/view/photo/l/public/p2663174250.jpg"];
    penguinModel1.userID = 1;
    penguinModel1.isLike = NO;
    penguinModel1.CellHeight = 0;
    [tempArr addObject:penguinModel1];
    
    
    
    PenguinChaseDongtaiModel * penguinModel2 = [[PenguinChaseDongtaiModel alloc]init];
    penguinModel2.headerImgurl = @"https://img2.doubanio.com/icon/u74102027-1.jpg";
    penguinModel2.userName = @"毛线球鸭子";
    penguinModel2.userLevel = 0;
    penguinModel2.time = @"2021-07-04 15:19:30";
    penguinModel2.content = @"3.5星，算是近期质量比较高的科幻电影，合格的爆米花，依旧是看特效，许多大场面还算是可以，找到了难得的快感，最后BOSS战也不错（真的，让我想到玩《生化危机8》刀通的时候）。不要在乎那些剧情，漏洞有些多，看个过瘾就OK咯～～～";
    penguinModel2.imgArr = @[@"https://img1.doubanio.com/view/photo/l/public/p2573878649.jpg",@"https://img1.doubanio.com/view/photo/l/public/p2658059718.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2644391913.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2642946101.jpg"];
    penguinModel2.userID = 2;
    penguinModel2.isLike = NO;
    penguinModel2.CellHeight = 0;
    [tempArr addObject:penguinModel2];
    
    
    PenguinChaseDongtaiModel * penguinModel3 = [[PenguinChaseDongtaiModel alloc]init];
    penguinModel3.headerImgurl = @"https://img9.doubanio.com/icon/u45442872-6.jpg";
    penguinModel3.userName = @"小岩井";
    penguinModel3.userLevel = 0;
    penguinModel3.time = @"2021-06-23 13:56:26";
    penguinModel3.content = @"刘烨是当之无愧的演技派、实力派。 能把守岛人这样即朴素又坚韧的硬汉形象，完美的表现出来。举手投足间，仿佛他就是海岛的礁石，任凭风吹雨打、我自巍然不动。 这种坚韧的精神，的确是很难得、也是其他新生代小生比较难以展现出来的一面。看好刘烨的表演。";
    penguinModel3.imgArr = @[@"https://img9.doubanio.com/view/photo/l/public/p2654813224.jpg"];
    penguinModel3.userID = 3;
    penguinModel3.isLike = NO;
    penguinModel3.CellHeight = 0;
    [tempArr addObject:penguinModel3];
    
    
    PenguinChaseDongtaiModel * penguinModel4 = [[PenguinChaseDongtaiModel alloc]init];
    penguinModel4.headerImgurl = @"https://img2.doubanio.com/icon/u163515512-42.jpg";
    penguinModel4.userName = @"我才是江湖骗子 ";
    penguinModel4.userLevel = 0;
    penguinModel4.time = @"2021-04-05 17:13:00";
    penguinModel4.content = @"智障爱情故事。2021年了还在拍这些狗血垃圾玩意，剧作巨失败，全片人物没有任何的成长，男主从头到尾幼稚冲动，女主从头到尾不清醒加瞎眼，结尾又臭又长，全片充斥着对穷人的恶意，对观众的侮辱。导演是电影配乐师出身吧，全片无抒情音乐地方加起来大概不超过十分钟，抱歉，你越抒情我越想笑。故事只值一星，另一星给邱泽后半段帅气的脸以及忽闪忽闪的大眼睛，还有好吃的爆米花以及荧光笔周边。";
    penguinModel4.imgArr = @[@"https://img9.doubanio.com/view/photo/l/public/p2640618804.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2640618803.jpg"];
    penguinModel4.userID = 4;
    penguinModel4.isLike = NO;
    penguinModel4.CellHeight = 0;
    [tempArr addObject:penguinModel4];
    
    
    
    PenguinChaseDongtaiModel * penguinModel5 = [[PenguinChaseDongtaiModel alloc]init];
    penguinModel5.headerImgurl = @"https://img2.doubanio.com/icon/u207511282-1.jpg";
    penguinModel5.userName = @"MMIAO";
    penguinModel5.userLevel = 0;
    penguinModel5.time = @"2021-04-05 17:13:00";
    penguinModel5.content = @"观感太割裂了，一边频频被视觉设计上的创意惊艳到，一边又不知道导演在吃力地表达什么，库伊拉这个本来能有深度挖掘空间的主角最终沦为了一种纯猎奇式的空壳人物，视觉残影散去以后，我还是没有懂她为何会逐渐演化成后传中的极端恶人。但终归两位艾玛对戏实在太精彩，戏剧张力拉满。影片虽然整体不完美，但是足够被牢记。";
    penguinModel5.imgArr = @[@"https://img2.doubanio.com/view/photo/l/public/p2635972581.jpg",@"https://img9.doubanio.com/view/photo/l/public/p2633681644.jpg"];
    penguinModel5.userID = 5;
    penguinModel5.isLike = NO;
    penguinModel5.CellHeight = 0;
    [tempArr addObject:penguinModel5];
    
    
    PenguinChaseDongtaiModel * penguinModel6 = [[PenguinChaseDongtaiModel alloc]init];
    penguinModel6.headerImgurl = @"https://img2.doubanio.com/icon/u231316237-1.jpg";
    penguinModel6.userName = @"电影挖掘机";
    penguinModel6.userLevel = 0;
    penguinModel6.time = @"2021-04-05 17:13:00";
    penguinModel6.content = @"不认识彼得兔，结果超好笑的，梗真的好多，配乐契合度很高，几乎是另一个配角。文化挪用、eye candy笑傻我，隔壁小孩一家也看得超开心（我怎么感觉贴片预告是乔乔兔那会看的，居然过了这么久吗？";
    penguinModel6.imgArr = @[@"https://img9.doubanio.com/view/photo/l/public/p2658914314.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2658914313.jpg"];
    penguinModel6.userID = 6;
    penguinModel6.isLike = NO;
    penguinModel6.CellHeight = 0;
    [tempArr addObject:penguinModel6];
    
    
    PenguinChaseDongtaiModel * penguinModel7 = [[PenguinChaseDongtaiModel alloc]init];
    penguinModel7.headerImgurl = @"https://img2.doubanio.com/icon/u192427282-1.jpg";
    penguinModel7.userName = @"多亲我1口";
    penguinModel7.userLevel = 0;
    penguinModel7.time = @"2021-04-05 17:13:00";
    penguinModel7.content = @"感觉有点爱有天意的影子，男主莫名有点眼熟。前半段心里骂了无数遍渣男！拳头都硬了！即使猜到有内情！明明知道自己要走了还要和女孩子纠缠，不是渣男是什么？大河是个工具人无误了心疼。个别音乐听着还不错，本身挺喜欢音乐追梦题材的，但是真的，求别掺杂太多狗血元素。";
    penguinModel7.imgArr = @[@"https://img3.doubanio.com/view/photo/l/public/p2657273380.jpg",@"https://img1.doubanio.com/view/photo/l/public/p2657273379.jpg"];
    penguinModel7.userID = 7;
    penguinModel7.isLike = NO;
    penguinModel7.CellHeight = 0;
    [tempArr addObject:penguinModel7];
    
    
    PenguinChaseDongtaiModel * penguinModel8 = [[PenguinChaseDongtaiModel alloc]init];
    penguinModel8.headerImgurl = @"https://img9.doubanio.com/icon/u1045350-16.jpg";
    penguinModel8.userName = @"托尼·王大拿 ";
    penguinModel8.userLevel = 0;
    penguinModel8.time = @"2021-04-05 17:13:00";
    penguinModel8.content = @"在中国电影资料馆先看了177分钟版本的导剪版，感觉后半段特别糟心；随后立刻找来124分钟国际版扫了一眼，感叹这片的制片人和国际发行商够牛逼，直接将一个狗血剧剪成了未央歌：爱情无果而终，影院坍塌解体，不完美的完美。";
    penguinModel8.imgArr = @[@"https://img9.doubanio.com/view/photo/l/public/p678292805.jpg"];
    penguinModel8.userID = 8;
    penguinModel8.isLike = NO;
    penguinModel8.CellHeight = 0;
    [tempArr addObject:penguinModel8];
    
    PenguinChaseDongtaiModel * penguinModel9 = [[PenguinChaseDongtaiModel alloc]init];
    penguinModel9.headerImgurl = @"https://img2.doubanio.com/icon/u157374956-1.jpg";
    penguinModel9.userName = @"唐婉不哭 ";
    penguinModel9.userLevel = 0;
    penguinModel9.time = @"2021-04-05 17:13:00";
    penguinModel9.content = @"电影质感廉价 网大既视感 但反家暴题材值得肯定 尤其是结尾男主的回忆批判了现实生活中警察对于家暴问题和稀泥调解只会酿成后续一系列更多惨剧 还有一点很重要 父权制结构下的心理问题不是问题 不是病！受害者没病 病的是这个压迫剥削你的社会结构！心理咨询不能帮助受害者解决任何实际问题 只会鼓励受害者做一个快乐的受害者 把事情往好的一面想 这样反而会导致受害者不容易逃离加害她的人 她接受完心理咨询越想开了越.";
    penguinModel9.imgArr = @[@"https://img2.doubanio.com/view/photo/l/public/p2653242683.jpg"];
    penguinModel9.userID = 9;
    penguinModel9.isLike = NO;
    penguinModel9.CellHeight = 0;
    [tempArr addObject:penguinModel9];
    
    BOOL isSucced = [[NSUserDefaults standardUserDefaults] boolForKey:@"PenguinChaseDongtaiModel"];
    if (isSucced == NO) {
        BOOL  isInserSucced =   [WHC_ModelSqlite inserts:tempArr.copy];
        [[NSUserDefaults standardUserDefaults] setBool:isInserSucced forKey:@"PenguinChaseDongtaiModel"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
+(void)PenguinChaseComentModelConfigers{
    NSMutableArray * tempArr = [NSMutableArray array];
    
    PenguinChaseComentModel * conmentModel = [[PenguinChaseComentModel alloc]init];
    conmentModel.headerImgurl = @"https://img2.doubanio.com/icon/u191635006-2.jpg";
    conmentModel.userName = @"小雪";
    conmentModel.time = @"2021-07-03 00:48:05";
    conmentModel.content = @"老实说跟预期不一样，可能我期望值有点高。那个时期的革命者真的不容易，他们的信仰，理想的坚定，用生命的代价换来我们现在的生活，无论后期如何，他们都为新中国都付出了自己的努力，但是1921我无法共情，每个人物的行为没有铺垫，导致我看到行为之后都要反应一下才了解。跟不同的政党的分歧，也没有详写，共产党成立的时候一定是惊心动魄，但是电影里我没有感受到，间谍部分除了车技那一块，完全不觉得精彩。到最后点电影快结束，优秀的共产党人被杀害，电影也没有让我感受到戳心。";
    conmentModel.zoneID  =0;
    conmentModel.comentID = 0;
    conmentModel.CellHeight = 0;
    [tempArr addObject:conmentModel];
    
    
    
    PenguinChaseComentModel * conmentModel1 = [[PenguinChaseComentModel alloc]init];
    conmentModel1.headerImgurl = @"https://img1.doubanio.com/icon/u147825975-7.jpg";
    conmentModel1.userName = @"一只甜桃";
    conmentModel1.time = @"2021-07-01 13:37:34";
    conmentModel1.content = @"沉稳坚定的书生？不可一世的青年？在各派表演中，有关真实陈独秀的争议，让我忍不住好奇地调查了解。他振臂一呼，顷刻应者云集，便定不是只会发狠的粗人之辈；他在反抗时那种近乎撕裂的信念感，以及可以置自己的生死于不顾的悍劲，又断然不只是个文弱的读书人。从1919年到1920年，在经历了对西方列强从失望、怀疑到最终抛弃的历程之后，或许他的觉醒进入了新的阶段，开始将反抗变得更加犀利。自传中他说：“有人称赞我疾恶如仇，有人批评我性情暴躁。其实我性情暴躁则有之，疾恶如仇则不尽然。”如此，便不难理解陈坤版陈独秀的火爆。";
    conmentModel1.zoneID  =0;
    conmentModel1.comentID = 1;
    conmentModel1.CellHeight = 0;
    [tempArr addObject:conmentModel1];
    
    
    
    
    PenguinChaseComentModel * conmentModel2 = [[PenguinChaseComentModel alloc]init];
    conmentModel2.headerImgurl = @"https://img9.doubanio.com/icon/u1355591-46.jpg";
    conmentModel2.userName = @"影随茵动";
    conmentModel2.time = @"2021-07-01 13:37:34";
    conmentModel2.content = @"6月是高考季，也是毕业季，在这个充满青春气息的季节，强烈建议年轻人看一下这部电影，对于有小孩的家庭来说这也是一部不错的亲子观影选择。当影片中的人物唱起《国际歌》的时候，我浑身热血沸腾了，这部电影可以说是一场跨越百年的致敬！百年前的中国，内外交困，人民生活于水深火热之中，幸而有一群那个时代满怀理想和壮志的年轻人奋勇而起，勇担重任，献身革命";
    conmentModel2.zoneID  =1;
    conmentModel2.comentID = 2;
    conmentModel2.CellHeight = 0;
    [tempArr addObject:conmentModel2];
    
    
    PenguinChaseComentModel * conmentModel3 = [[PenguinChaseComentModel alloc]init];
    conmentModel3.headerImgurl = @"https://img1.doubanio.com/icon/u147825975-7.jpg";
    conmentModel3.userName = @"nananana";
    conmentModel3.time = @"2021-06-19";
    conmentModel3.content = @"黄轩、袁文康非常棒，张颂文、倪妮也很可。没想到泪点在李达和王会悟天台唱国际歌时就出现了，更没想到这个情节是演员现场发挥。有些表演和细节确实做得不错。";
    conmentModel3.zoneID  =1;
    conmentModel3.comentID = 3;
    conmentModel3.CellHeight = 0;
    [tempArr addObject:conmentModel3];
    
    
    PenguinChaseComentModel * conmentModel4 = [[PenguinChaseComentModel alloc]init];
    conmentModel4.headerImgurl = @"https://img2.doubanio.com/icon/u208012610-1.jpg";
    conmentModel4.userName = @"纪梵嘻嘻哈哈";
    conmentModel4.time = @"2021-07-03 01:15:47";
    conmentModel4.content = @"天台描述火种那段即兴表演得也太棒了吧，有真实的情绪演出来真的不一样。好的演员互相感染互相成就，挺感动的。";
    conmentModel4.zoneID  =1;
    conmentModel4.comentID = 4;
    conmentModel4.CellHeight = 0;
    [tempArr addObject:conmentModel4];
    
    PenguinChaseComentModel * conmentModel5 = [[PenguinChaseComentModel alloc]init];
    conmentModel5.headerImgurl = @"https://img2.doubanio.com/icon/u195665053-1.jpg";
    conmentModel5.userName = @"Jorge. Wo 🍇";
    conmentModel5.time = @"2021-07-03 01:15:47";
    conmentModel5.content = @"僵尸世界大战之后在没看过如此密集的场面，还是蛮爽的。话说古天乐的明日战记何时上映";
    conmentModel5.zoneID  = 2;
    conmentModel5.comentID = 5;
    conmentModel5.CellHeight = 0;
    [tempArr addObject:conmentModel5];
    
    
    PenguinChaseComentModel * conmentModel6 = [[PenguinChaseComentModel alloc]init];
    conmentModel6.headerImgurl = @"https://img2.doubanio.com/icon/u74102027-1.jpg";
    conmentModel6.userName = @"夏天的雨";
    conmentModel6.time = @"2021-07-03 01:01:44";
    conmentModel6.content = @"找未来的人来解决现在的事我还能理解，毕竟未来的人知识储备就比我们多，也有很多先进的科那找现在的人去解决未来的事基本就只有一种逻辑，那就是现在人的所作所为会影响未来的事态发展，可以参考【终结者】系列，这部片子却反其道而行，让现在的人去未来帮他们打怪，你们军队都解决不了的事，到30年前抓壮丁就能解决？而且大多数还是40岁以上的菜鸡，能分配这么多资源用来跳跃和武装，就没有资源给怪物来几个致命打击？";
    conmentModel6.zoneID  = 2;
    conmentModel6.comentID = 6;
    conmentModel6.CellHeight = 0;
    [tempArr addObject:conmentModel6];
    
    
    PenguinChaseComentModel * conmentModel7 = [[PenguinChaseComentModel alloc]init];
    conmentModel7.headerImgurl = @"https://img2.doubanio.com/icon/u216100253-2.jpg";
    conmentModel7.userName = @"球场终结者行云";
    conmentModel7.time = @" 2021-06-13";
    conmentModel7.content = @"男女主演，岛主原型都很棒——然而我的思绪始终纠结在组织的“无奈'上，三十多年里怎么就找不到一个值得信任的人，那么多党旗下宣誓的党员，通过考试的公务员呢？";
    conmentModel7.zoneID  = 3;
    conmentModel7.comentID = 7;
    conmentModel7.CellHeight = 0;
    [tempArr addObject:conmentModel7];
    
    
    PenguinChaseComentModel * conmentModel8 = [[PenguinChaseComentModel alloc]init];
    conmentModel8.headerImgurl = @"https://img9.doubanio.com/icon/u1068489-4.jpg";
    conmentModel8.userName = @"穎軒Amanda";
    conmentModel8.time = @" 2021-06-13";
    conmentModel8.content = @"三星里面两星给女主演技，一星给刘烨。 有感动，更多的是干涩。整部影片编剧都极力体现着一种“道理我都懂，但我就不这么干”的倔强和蠢劲儿，十七年和纹格电影的忆苦思甜模式被原封不动地挪用到今天，那么所谓的“时代精神”，真的有在与时俱进吗";
    conmentModel8.zoneID  = 3;
    conmentModel8.comentID = 8;
    conmentModel8.CellHeight = 0;
    [tempArr addObject:conmentModel8];
    
    PenguinChaseComentModel * conmentModel9 = [[PenguinChaseComentModel alloc]init];
    conmentModel9.headerImgurl = @"https://img9.doubanio.com/icon/u132527345-5.jpg";
    conmentModel9.userName = @"胡晓晨";
    conmentModel9.time = @"2021-06-11 22:12:31";
    conmentModel9.content = @"对于爱情片，我总是抱有比较谨慎的态度，倒不是不愿相信美好的爱情，而是当电影仅有爱情的颂歌时，它就只会沉溺在疲乏而扁平的自我感动中，最后回归到那几种让人倦乏的套路，比如今年五一档的《你的婚礼》。";
    conmentModel9.zoneID  = 4;
    conmentModel9.comentID = 9;
    conmentModel9.CellHeight = 0;
    [tempArr addObject:conmentModel9];
    
    PenguinChaseComentModel * conmentModel10 = [[PenguinChaseComentModel alloc]init];
    conmentModel10.headerImgurl = @"https://img1.doubanio.com/icon/u1680355-8.jpg";
    conmentModel10.userName = @"胡晓晨";
    conmentModel10.time = @"2021-06-03 08:17:16";
    conmentModel10.content = @"迪士尼今天放出了最近上映的《黑白魔女库伊拉》的网友们自制的海报，每一张都好美！ ";
    conmentModel10.zoneID  = 5;
    conmentModel10.comentID = 10;
    conmentModel10.CellHeight = 0;
    [tempArr addObject:conmentModel10];
    
    
    PenguinChaseComentModel * conmentModel11 = [[PenguinChaseComentModel alloc]init];
    conmentModel11.headerImgurl = @"https://img2.doubanio.com/icon/u181097401-2.jpg";
    conmentModel11.userName = @"哥谭精神病人";
    conmentModel11.time = @"2021-06-13 15:47:20";
    conmentModel11.content = @"天堂电影院删减了42min，斟酌了许久还是推辞了朋友一起去重温的邀请，可是做完决定了还是有点后悔。不过看完彼得兔之后，我觉得确实我已经体会到了我自己的天堂电影院。 ";
    conmentModel11.zoneID  = 6;
    conmentModel11.comentID = 11;
    conmentModel11.CellHeight = 0;
    [tempArr addObject:conmentModel11];
    
    BOOL isSucced = [[NSUserDefaults standardUserDefaults] boolForKey:@"PenguinChaseComentModel"];
    if (isSucced == NO) {
        BOOL  isInserSucced =   [WHC_ModelSqlite inserts:tempArr.copy];
        [[NSUserDefaults standardUserDefaults] setBool:isInserSucced forKey:@"PenguinChaseComentModel"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
+(void)PenguinChatMessageListModelConfigers{
    NSMutableArray * tempArr = [NSMutableArray array];
    PenguinChatMessageListModel * chatModel  =[[PenguinChatMessageListModel alloc]init];
    chatModel.headerimgurl = @"https://img2.doubanio.com/icon/u214422614-2.jpg";
    chatModel.username = @"卡列宁_ ";
    chatModel.Content = @"这个电影最多也就给个5.2分吧";
    chatModel.time = @"周三";
    chatModel.msgNum = 1;
    chatModel.userID = 0;
    [tempArr addObject:chatModel];
    
    //那你觉得这个电影应该打分的话，打多少分合适？
    //我觉得最多也就给个5.2分吧。
    //哦。厉害了，真是人才！
    //那你觉得这个电影能打多少分?
    
    PenguinChatMessageListModel * chatModel1  =[[PenguinChatMessageListModel alloc]init];
    chatModel1.headerimgurl = @"https://img9.doubanio.com/icon/u53672944-24.jpg";
    chatModel1.username = @"冷暖自知";
    chatModel1.Content = @"一起为祖国庆生😉";
    chatModel1.time = @"周五";
    chatModel1.msgNum = 0;
    chatModel1.userID = 1;
    [tempArr addObject:chatModel1];
    
    //楼主说的没毛病，算是给祖国庆生了，哈哈😄
    //一起为祖国庆生😉
    
    
    
    PenguinChatMessageListModel * chatModel2  =[[PenguinChatMessageListModel alloc]init];
    chatModel2.headerimgurl = @"https://img2.doubanio.com/icon/u74102027-1.jpg";
    chatModel2.username = @"毛线球鸭子";
    chatModel2.Content = @"哈哈，是吧～";
    chatModel2.time = @"周五";
    chatModel2.msgNum = 0;
    chatModel2.userID = 2;
    [tempArr addObject:chatModel2];
    //这部电影算是借鉴了生化系列的拍摄手法了，确实有待加强
    //哈哈，是吧～
    
    BOOL isInser = [[NSUserDefaults standardUserDefaults] boolForKey:@"PenguinChatMessageListModel"];
    if (isInser == NO) {
        BOOL isChatSuccced =    [WHC_ModelSqlite inserts:tempArr.copy];
        [[NSUserDefaults standardUserDefaults] setBool:isChatSuccced forKey:@"PenguinChatMessageListModel"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
+(void)PenguinChaseMessageDetailModelConfigers{
    NSMutableArray * tempArr = [NSMutableArray array];
    PenguinChaseMessageDetailModel * detailModel = [[PenguinChaseMessageDetailModel alloc]init];
    detailModel.msgname =  @"那你觉得这个电影应该打分的话，打多少分合适？";
    detailModel.userID = 0;
    detailModel.imgUrl = @"https://img2.doubanio.com/icon/u214422614-2.jpg";
    detailModel.msgisMe = YES;
    detailModel.CellHeight  = 0;
    [tempArr addObject:detailModel];
    
    PenguinChaseMessageDetailModel * detailModel1 = [[PenguinChaseMessageDetailModel alloc]init];
    detailModel1.msgname =  @"我觉得最多也就给个5.2分吧。";
    detailModel1.userID = 0;
    detailModel1.imgUrl = @"https://img2.doubanio.com/icon/u214422614-2.jpg";
    detailModel1.msgisMe = NO;
    detailModel1.CellHeight  = 0;
    [tempArr addObject:detailModel1];
    
    PenguinChaseMessageDetailModel * detailModel2 = [[PenguinChaseMessageDetailModel alloc]init];
    detailModel2.msgname =  @"哦。厉害了，真是人才！";
    detailModel2.userID = 0;
    detailModel2.imgUrl = @"https://img2.doubanio.com/icon/u214422614-2.jpg";
    detailModel2.msgisMe = YES;
    detailModel2.CellHeight  = 0;
    [tempArr addObject:detailModel2];
    
    
    PenguinChaseMessageDetailModel * detailModel3 = [[PenguinChaseMessageDetailModel alloc]init];
    detailModel3.msgname =  @"那你觉得这个电影能打多少分?！";
    detailModel3.userID = 0;
    detailModel3.imgUrl = @"https://img2.doubanio.com/icon/u214422614-2.jpg";
    detailModel3.msgisMe = NO;
    detailModel3.CellHeight  = 0;
    [tempArr addObject:detailModel3];
    
    
    
    
    PenguinChaseMessageDetailModel * detailModel4 = [[PenguinChaseMessageDetailModel alloc]init];
    detailModel4.msgname =  @"楼主说的没毛病，算是给祖国庆生了，哈哈😄";
    detailModel4.userID = 1;
    detailModel4.imgUrl = @"https://img9.doubanio.com/icon/u53672944-24.jpg";
    detailModel4.msgisMe = YES;
    detailModel4.CellHeight  = 0;
    [tempArr addObject:detailModel4];
    
    PenguinChaseMessageDetailModel * detailModel5 = [[PenguinChaseMessageDetailModel alloc]init];
    detailModel5.msgname =  @"一起为祖国庆生😉";
    detailModel5.userID = 1;
    detailModel5.imgUrl = @"https://img9.doubanio.com/icon/u53672944-24.jpg";
    detailModel5.msgisMe = NO;
    detailModel5.CellHeight  = 0;
    [tempArr addObject:detailModel5];
    
    
    
    PenguinChaseMessageDetailModel * detailModel6 = [[PenguinChaseMessageDetailModel alloc]init];
    detailModel6.msgname =  @"这部电影算是借鉴了生化系列的拍摄手法了，确实有待加强";
    detailModel6.userID = 2;
    detailModel6.imgUrl = @"https://img2.doubanio.com/icon/u74102027-1.jpg";
    detailModel6.msgisMe = YES;
    detailModel6.CellHeight  = 0;
    [tempArr addObject:detailModel6];
    
    
    PenguinChaseMessageDetailModel * detailModel7 = [[PenguinChaseMessageDetailModel alloc]init];
    detailModel7.msgname =  @"哈哈，是吧～";
    detailModel7.userID = 2;
    detailModel7.imgUrl = @"https://img2.doubanio.com/icon/u74102027-1.jpg";
    detailModel7.msgisMe = NO;
    detailModel7.CellHeight  = 0;
    [tempArr addObject:detailModel7];
    
    
    BOOL isSucced = [[NSUserDefaults standardUserDefaults] boolForKey:@"PenguinChaseMessageDetailModel"];
    if (isSucced == NO) {
        BOOL isInser = [WHC_ModelSqlite inserts:tempArr.copy];
        [[NSUserDefaults standardUserDefaults] setBool:isInser forKey:@"PenguinChaseMessageDetailModel"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
+(void)PenguinHuatiLeftMoelConfigers{
    NSMutableArray * tempArr = [NSMutableArray array];
    PenguinHuatiLeftMoel * huatiModel = [[PenguinHuatiLeftMoel alloc]init];
    huatiModel.isSeltecd  =NO;
    huatiModel.title = @"我的关注";
    huatiModel.typeID = 0;
    [tempArr addObject:huatiModel];
    
    PenguinHuatiLeftMoel * huatiModel1 = [[PenguinHuatiLeftMoel alloc]init];
    huatiModel1.isSeltecd  =YES;
    huatiModel1.title = @"热门";
    huatiModel1.typeID = 1;
    [tempArr addObject:huatiModel1];
    
    PenguinHuatiLeftMoel * huatiModel2 = [[PenguinHuatiLeftMoel alloc]init];
    huatiModel2.isSeltecd  =NO;
    huatiModel2.title = @"最新";
    huatiModel2.typeID = 2;
    [tempArr addObject:huatiModel2];
    
    PenguinHuatiLeftMoel * huatiModel3 = [[PenguinHuatiLeftMoel alloc]init];
    huatiModel3.isSeltecd  =NO;
    huatiModel3.title = @"经典";
    huatiModel3.typeID = 3;
    [tempArr addObject:huatiModel3];
    
    PenguinHuatiLeftMoel * huatiModel4 = [[PenguinHuatiLeftMoel alloc]init];
    huatiModel4.isSeltecd  =NO;
    huatiModel4.title = @"豆瓣高分";
    huatiModel4.typeID = 4;
    [tempArr addObject:huatiModel4];
    
    PenguinHuatiLeftMoel * huatiModel5 = [[PenguinHuatiLeftMoel alloc]init];
    huatiModel5.isSeltecd  =NO;
    huatiModel5.title = @"冷门佳片";
    huatiModel5.typeID = 5;
    [tempArr addObject:huatiModel5];
    
    PenguinHuatiLeftMoel * huatiModel6 = [[PenguinHuatiLeftMoel alloc]init];
    huatiModel6.isSeltecd  =NO;
    huatiModel6.title = @"华语";
    huatiModel6.typeID = 6;
    [tempArr addObject:huatiModel6];
    
    PenguinHuatiLeftMoel * huatiModel7 = [[PenguinHuatiLeftMoel alloc]init];
    huatiModel7.isSeltecd  =NO;
    huatiModel7.title = @"欧美";
    huatiModel7.typeID = 7;
    [tempArr addObject:huatiModel7];
    
    
    BOOL isTempFirst = [[NSUserDefaults standardUserDefaults] boolForKey:@"PenguinHuatiLeftMoel"];
    if (isTempFirst == NO) {
        BOOL isInset = [WHC_ModelSqlite inserts:tempArr.copy];
        [[NSUserDefaults standardUserDefaults] setBool:isInset forKey:@"PenguinHuatiLeftMoel"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
+(void)PenguinChaseVideoModelConfigers{
    NSMutableArray * tempArr = [NSMutableArray array];
    PenguinChaseVideoModel * penguinModle = [[PenguinChaseVideoModel alloc]init];
    penguinModle.WantNums = 123;
    penguinModle.penguinChase_MoviewName = @"明日之战";
    penguinModle.penguinChase_EngilshMoviewName = @"The Tomorrow War";
    penguinModle.penguinChase_MoviewIocnurl = @"https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2666541015.jpg";
    penguinModle.penguinChase_MoviewImgArr = @[@"https://img1.doubanio.com/view/photo/l/public/p2573878649.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2666616823.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2666616821.jpg",@"https://img1.doubanio.com/view/photo/l/public/p2666616818.jpg"];
    penguinModle.penguinChase_MoviewTitle = @"作为爆米花，是十分合格的";
    penguinModle.penguinChase_MoviewDesc = @"克里斯·帕拉特商谈主演科幻影片[幽灵征募](Ghost Draft，暂译)，克里斯·麦凯([乐高大电影])执导，扎克·迪恩([陷阱])操刀剧本。故事讲述一对父子被征募到一场未来战争中，这场战争决定着人类的命运。天空之舞(Skydance)出资制作。";
    penguinModle.penguinChase_MoviewArtistArr =@[@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/p1410316482.29.jpg",@"title":@"克里斯·麦凯"},@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p1408711300.32.jpg",@"title":@"克里斯·帕拉特"},@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p1416039581.21.jpg",@"title":@"伊冯娜·斯特拉霍夫斯基"},@{@"img":@"https://img9.doubanio.com/view/celebrity/raw/public/p44006.jpg",@"title":@"J·K·西蒙斯"},@{@"img":@"https://img9.doubanio.com/view/celebrity/raw/public/p1364129382.55.jpg",@"title":@"艾德文·霍德吉"},@{@"img":@"https://img9.doubanio.com/view/celebrity/raw/public/p1570654509.85.jpg",@"title":@"山姆·理查森"}];
    penguinModle.penguinChase_MoviewTime =@"2021-07-02(美国网络)";
    penguinModle.penguinChase_MoviewType = @"动作 / 科幻";
    penguinModle.penguinChase_isColltecd = NO;
    penguinModle.penguinChase_DBSourecd  =6.5;
    penguinModle.penguinChase_RateSourecd = 47;
    penguinModle.penguinChase_MoviewID = 0;
    penguinModle.TopType = @"0";
    [tempArr addObject:penguinModle];
    
    
    
    
    PenguinChaseVideoModel * penguinModle1 = [[PenguinChaseVideoModel alloc]init];
    penguinModle1.WantNums = 451;
    penguinModle1.penguinChase_MoviewName = @"狼行者";
    penguinModle1.penguinChase_EngilshMoviewName = @"Wolfwalkers";
    penguinModle1.penguinChase_MoviewIocnurl = @"https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2654733189.jpg";
    penguinModle1.penguinChase_MoviewImgArr = @[@"https://img1.doubanio.com/view/photo/l/public/p2666732797.jpg",@"https://img1.doubanio.com/view/photo/l/public/p2666732699.jpg",@"https://img3.doubanio.com/view/photo/l/public/p2666732600.jpg",@"https://img1.doubanio.com/view/photo/l/public/p2666731818.jpg",@"https://img1.doubanio.com/view/photo/l/public/p2666731648.jpg",@"https://img3.doubanio.com/view/photo/l/public/p2666731570.jpg"];
    penguinModle1.penguinChase_MoviewTitle = @"畅游爱尔兰的森林文化之旅，与狼同行的它，是这个冬季不可多得的温暖。";
    penguinModle1.penguinChase_MoviewDesc = @"　讲述了11岁女孩萝宾的神奇经历。萝宾作为一个年轻的学徒猎人，她和父亲一起来到爱尔兰，准备消灭最后一批在那里的狼，但是改变她的事情来了，她发现了狼行者，此后一连串的古怪故事就发生了……";
    penguinModle1.penguinChase_MoviewArtistArr =@[@{@"img":@"https://img9.doubanio.com/view/celebrity/raw/public/p1415542643.24.jpg",@"title":@"汤姆·摩尔 "},@{@"img":@"https://img9.doubanio.com/view/celebrity/raw/public/p1609677348.06.jpg",@"title":@"罗斯·斯图尔特"},@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p53.jpg",@"title":@"肖恩·宾"},@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/puuli7vvsABUcel_avatar_uploaded1416584733.89.jpg",@"title":@"霍纳·妮芙茜 "},@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p1609675324.31.jpg",@"title":@"伊娃·惠塔克"},@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/p33967.jpg",@"title":@"西蒙·迈克伯尼"}];
    penguinModle1.penguinChase_MoviewTime =@"2021-07-03(中国大陆) / 2020-09-12(多伦多电影节) / 2020-12-11(美国)";
    penguinModle1.penguinChase_MoviewType = @"动画 / 奇幻 / 冒险";
    penguinModle1.penguinChase_isColltecd = NO;
    penguinModle1.penguinChase_DBSourecd  =7.8;
    penguinModle1.penguinChase_RateSourecd = 78;
    penguinModle1.penguinChase_MoviewID = 1;
    penguinModle1.TopType = @"0";
    [tempArr addObject:penguinModle1];
    
    
    PenguinChaseVideoModel * penguinModle2= [[PenguinChaseVideoModel alloc]init];
    penguinModle2.WantNums = 456;
    penguinModle2.penguinChase_MoviewName = @"午夜天鹅 ";
    penguinModle2.penguinChase_EngilshMoviewName = @"ミッドナイトスワン";
    penguinModle2.penguinChase_MoviewIocnurl = @"https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2614297584.jpg";
    penguinModle2.penguinChase_MoviewImgArr = @[@"https://img3.doubanio.com/view/photo/l/public/p2635981980.jpg",@"https://img1.doubanio.com/view/photo/l/public/p2635981447.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2635981373.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2635887301.jpg",@"https://img1.doubanio.com/view/photo/l/public/p2635887297.jpg"];
    penguinModle2.penguinChase_MoviewTitle = @"服部树咲是本片最大的亮点";
    penguinModle2.penguinChase_MoviewDesc = @"草剪刚演一名跨性别者。当凪沙与不被父母所爱、梦想成为芭蕾舞者的少女“一果”相遇后，潜藏在她体内的母性开始觉醒。";
    penguinModle2.penguinChase_MoviewArtistArr =@[@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p1483513664.61.jpg",@"title":@"内田英治"},@{@"img":@"https://img9.doubanio.com/view/celebrity/raw/public/p1355654328.95.jpg",@"title":@"草彅刚"},@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/pk6WkBCfzyI4cel_avatar_uploaded1603791028.18.jpg",@"title":@"服部树咲"},@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/p1495956297.77.jpg",@"title":@"田中俊介"},@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/pK-1Su90hTf0cel_avatar_uploaded1492101942.2.jpg",@"title":@"吉村界人"},@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/p7878.jpg",@"title":@"佐藤江梨子"}];
    penguinModle2.penguinChase_MoviewTime =@"2020-09-25(日本)";
    penguinModle2.penguinChase_MoviewType = @"同性";
    penguinModle2.penguinChase_isColltecd = NO;
    penguinModle2.penguinChase_DBSourecd  =7.8;
    penguinModle2.penguinChase_RateSourecd = 82;
    penguinModle2.penguinChase_MoviewID = 2;
    penguinModle2.TopType = @"0";
    [tempArr addObject:penguinModle2];
    
    
    
    PenguinChaseVideoModel * penguinModle3 = [[PenguinChaseVideoModel alloc]init];
    penguinModle3.WantNums = 135;
    penguinModle3.penguinChase_MoviewName = @"浴火鸟 ";
    penguinModle3.penguinChase_EngilshMoviewName = @"Firebird";
    penguinModle3.penguinChase_MoviewIocnurl = @"https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2633279574.jpg";
    penguinModle3.penguinChase_MoviewImgArr = @[@"https://img1.doubanio.com/view/photo/l/public/p2633241018.jpg",@"https://img1.doubanio.com/view/photo/l/public/p2662559297.jpg",@"https://img9.doubanio.com/view/photo/l/public/p2662558534.jpg",@"https://img9.doubanio.com/view/photo/l/public/p2662442714.jpg",@""];
    penguinModle3.penguinChase_MoviewTitle = @"爱和真诚永远是最打动人的";
    penguinModle3.penguinChase_MoviewDesc = @"根据真实的故事改编，《浴火鸟》是一部冷战惊悚片，背景设定于1970年代的苏联。故事讲述，谢尔盖（Sergey，一名陷入困境的应征者，他的最好的朋友路易莎（Luisa），一位迷人有野心的基地指挥官秘书，以及一个胆大的年轻战斗机飞行员罗曼，三者之间如何形成危险的三角恋爱关系。在好奇心的驱使下，他们开启了禁忌之恋，在暧昧与欺骗之间，爱情与友谊的界限开始模糊。随着罗曼的职业生涯受到威胁，谢尔盖被迫面对自己的过去，而路易莎（Luisa）也努力使家人团聚。在围城之内，他们冒着失去自由和生命的危险，面对克格勃不断升级的调查，他们之间的命运会走向何方？";
    penguinModle3.penguinChase_MoviewArtistArr =@[@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p51982.jpg",@"title":@"尼古拉斯·伍德森 "},@{@"img":@"https://img9.doubanio.com/view/celebrity/raw/public/p1417246200.5.jpg",@"title":@"汤姆·普赖尔 "},@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/p1526235088.87.jpg",@"title":@"戴安娜·波扎尔斯卡娅 "},@{@"img":@"https://img9.doubanio.com/view/celebrity/raw/public/p1518072858.34.jpg",@"title":@"卡斯帕·威尔伯格"}];
    penguinModle3.penguinChase_MoviewTime =@"2021-03-18(英国)";
    penguinModle3.penguinChase_MoviewType = @"同性 / 历史 / 战争";
    penguinModle3.penguinChase_isColltecd = NO;
    penguinModle3.penguinChase_DBSourecd  =7.5;
    penguinModle3.penguinChase_RateSourecd = 75;
    penguinModle3.penguinChase_MoviewID = 3;
    penguinModle3.TopType = @"0";
    [tempArr addObject:penguinModle3];
    
    
    
    PenguinChaseVideoModel * penguinModle4 = [[PenguinChaseVideoModel alloc]init];
    penguinModle4.WantNums = 521;
    penguinModle4.penguinChase_MoviewName = @"爱在疯人院";
    penguinModle4.penguinChase_EngilshMoviewName = @"Loco Por Ella";
    penguinModle4.penguinChase_MoviewIocnurl = @"https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2630022800.jpg";
    penguinModle4.penguinChase_MoviewImgArr = @[@"https://img1.doubanio.com/view/photo/l/public/p2634130748.jpg",@"https://img1.doubanio.com/view/photo/l/public/p2634130747.jpg",@"https://img9.doubanio.com/view/photo/l/public/p2634130746.jpg",@"https://img9.doubanio.com/view/photo/l/public/p2634130745.jpg"];
    penguinModle4.penguinChase_MoviewTitle = @"现代爱情童话故事";
    penguinModle4.penguinChase_MoviewDesc = @"在与神秘莫测的卡拉（苏珊娜·阿巴图纳饰）度过了美妙的一夜后，为了再次见到她，阿德里（阿尔瓦罗·塞万提斯饰）决定混进卡拉居住的精神病院。但他很快发现，从精神病院中全身而退并不像自己想象得那么容易。";
    penguinModle4.penguinChase_MoviewArtistArr =@[@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p1584673706.3.jpg",@"title":@"达尼·德拉奥尔登"},@{@"img":@"https://img3.doubanio.com/view/celebrity/raw/public/p58730.jpg",@"title":@"阿尔瓦罗·塞万提斯"},@{@"img":@"https://img9.doubanio.com/view/celebrity/raw/public/p1551542998.46.jpg",@"title":@"苏珊娜·阿巴图纳·戈麦斯 "},@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/p1516868178.99.jpg",@"title":@"路易斯·扎赫拉"},@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/p1407603127.57.jpg",@"title":@"克拉拉·塞古拉 "},@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p16041.jpg",@"title":@"阿尔维托·圣胡安"}];
    penguinModle4.penguinChase_MoviewTime =@"2021-02-26(西班牙网络)";
    penguinModle4.penguinChase_MoviewType = @"喜剧 / 爱情";
    penguinModle4.penguinChase_isColltecd = NO;
    penguinModle4.penguinChase_DBSourecd  =6.8;
    penguinModle4.penguinChase_RateSourecd = 82;
    penguinModle4.penguinChase_MoviewID = 4;
    penguinModle4.TopType = @"0";
    [tempArr addObject:penguinModle4];
    
    
    PenguinChaseVideoModel * penguinModle5 = [[PenguinChaseVideoModel alloc]init];
    penguinModle5.WantNums = 563;
    penguinModle5.penguinChase_MoviewName = @"夏日友晴天 ";
    penguinModle5.penguinChase_EngilshMoviewName = @"Luca";
    penguinModle5.penguinChase_MoviewIocnurl = @"https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2633883449.jpg";
    penguinModle5.penguinChase_MoviewImgArr = @[@"https://img2.doubanio.com/view/photo/l/public/p2616012541.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2615644003.jpg"];
    penguinModle5.penguinChase_MoviewTitle = @"在这个世界上，无论你是多么与众不同，请相信，总有人愿意接纳你。";
    penguinModle5.penguinChase_MoviewDesc = @"故事发生在意大利里维埃拉，讲述了一个小男孩卢卡（雅各布·特伦布莱 配音）在充满冰激凌、意大利面香气和摩托车骑行的夏天，经历的难忘成长之旅。卢卡与他新结交的好友（杰克·迪伦·格雷泽 配音）一起经历了这些冒险，但所有的乐趣都受到了一个深藏的秘密的威胁：他是一个来自海底世界的海怪。";
    penguinModle5.penguinChase_MoviewArtistArr =@[@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p1351758779.13.jpg",@"title":@"埃里康·卡萨罗萨 "},@{@"img":@"https://img9.doubanio.com/view/celebrity/raw/public/p1603462343.45.jpg",@"title":@"雅各布·特伦布莱"},@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p1526985587.91.jpg",@"title":@"杰克·迪伦·格雷泽"},@{@"img":@"https://img3.doubanio.com/view/personage/raw/public/6379820812ea1fae31b547eef71724b0.jpg",@"title":@"艾玛·伯曼 "}];
    penguinModle5.penguinChase_MoviewTime =@"2021-07(中国大陆) / 2021-06-18(美国网络)";
    penguinModle5.penguinChase_MoviewType = @"喜剧 / 动画 / 奇幻 / 冒险";
    penguinModle5.penguinChase_isColltecd = NO;
    penguinModle5.penguinChase_DBSourecd  =7.3;
    penguinModle5.penguinChase_RateSourecd = 63;
    penguinModle5.penguinChase_MoviewID = 5;
    penguinModle5.TopType = @"0";
    [tempArr addObject:penguinModle5];
    
    
    PenguinChaseVideoModel * penguinModle6 = [[PenguinChaseVideoModel alloc]init];
    penguinModle6.WantNums = 312;
    penguinModle6.penguinChase_MoviewName = @"我要我们在一起 ";
    penguinModle6.penguinChase_EngilshMoviewName = @"Love Will Tear Us Apart";
    penguinModle6.penguinChase_MoviewIocnurl = @"https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2641399262.jpg";
    penguinModle6.penguinChase_MoviewImgArr = @[@"https://img2.doubanio.com/view/photo/l/public/p2565733802.jpg",@"https://img9.doubanio.com/view/photo/l/public/p2564381165.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2564381162.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2564381161.jpg",@"https://img3.doubanio.com/view/photo/l/public/p2564381160.jpg"];
    penguinModle6.penguinChase_MoviewTitle = @"与我十年长跑的女友明天要嫁人了";
    penguinModle6.penguinChase_MoviewDesc = @"你有没有爱过一个人，曾经拼了命，只为和TA在一起。十年前，差生吕钦扬当众告白凌一尧，两人从校园步入社会，为了让她幸福，他不惜以命相搏。然而金钱、房子、婚姻等现实的考验，却将两人越推越远。十年长跑，他们能否还记得曾经刻在心底的约定：我要我们在一起。电影改编自长帖《与我十年长跑的女友明天要嫁人了》。";
    penguinModle6.penguinChase_MoviewArtistArr =@[@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/p1464590639.98.jpg",@"title":@"沙漠"},@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/p1549940214.19.jpg",@"title":@"屈楚萧"},@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/p1615384750.48.jpg",@"title":@"张婧仪"},@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p1510545221.92.jpg",@"title":@"孙宁"},@{@"img":@"https://img9.doubanio.com/view/celebrity/raw/public/p1513324479.75.jpg",@"title":@"张垚"},@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/pQOGSFCU90A8cel_avatar_uploaded1570621635.48.jpg",@"title":@"李嘉灏"}];
    penguinModle6.penguinChase_MoviewTime =@"2021-05-20(中国大陆)";
    penguinModle6.penguinChase_MoviewType = @"剧情 / 爱情";
    penguinModle6.penguinChase_isColltecd = NO;
    penguinModle6.penguinChase_DBSourecd  =6.1;
    penguinModle6.penguinChase_RateSourecd = 47;
    penguinModle6.penguinChase_MoviewID = 6;
    penguinModle6.TopType = @"0";
    [tempArr addObject:penguinModle6];
    
    
    PenguinChaseVideoModel * penguinModle7 = [[PenguinChaseVideoModel alloc]init];
    penguinModle7.WantNums = 235;
    penguinModle7.penguinChase_MoviewName = @"黑白魔女库伊拉";
    penguinModle7.penguinChase_EngilshMoviewName = @"Cruella";
    penguinModle7.penguinChase_MoviewIocnurl = @"https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2653946775.jpg";
    penguinModle7.penguinChase_MoviewImgArr = @[@"https://img2.doubanio.com/view/photo/l/public/p2633266021.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2633266003.jpg",@"https://img3.doubanio.com/view/photo/l/public/p2588391640.jpg",@"https://img9.doubanio.com/view/photo/l/public/p2574213804.jpg",@"https://img1.doubanio.com/view/photo/l/public/p2573389007.jpg",@"https://img9.doubanio.com/view/photo/l/public/p2573389006.jpg"];
    penguinModle7.penguinChase_MoviewTitle = @"童年阴影是艾玛·斯通~";
    penguinModle7.penguinChase_MoviewDesc = @"　影片改编自道迪·史密斯的小说，故事设定在20世纪70年代朋克摇滚革命时期的伦敦，讲述了一个名叫艾丝黛拉（艾玛·斯通 饰）的年轻骗子的故事。艾丝黛拉是一个聪明又有创意的女孩，她决心用自己的设计让自己出名。她和一对欣赏她的恶作剧嗜好的小偷交上了朋友，并能够一起在伦敦的街道上建立自己的生活。有一天，艾丝黛拉的时尚品味吸引了冯·赫尔曼男爵夫人（艾玛·汤普森 饰）的眼球，她是一位时尚界的传奇人物，拥有毁灭性的时尚和可怕的高雅，但他们的关系引发了一系列事件，导致艾丝黛拉去拥抱她的邪恶一面，成为了兼具疯狂、时尚和报复心的库伊拉。";
    penguinModle7.penguinChase_MoviewArtistArr =@[@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p28271.jpg",@"title":@"克雷格·吉勒斯佩 "},@{@"img":@"https://img9.doubanio.com/view/celebrity/raw/public/p1398005949.4.jpg",@"title":@"艾玛·斯通"},@{@"img":@"https://img9.doubanio.com/view/celebrity/raw/public/p26576.jpg",@"title":@"艾玛·汤普森 "},@{@"img":@"https://img9.doubanio.com/view/celebrity/raw/public/p1623239545.74.jpg",@"title":@"乔尔·弗莱"},@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/p1579450902.87.jpg",@"title":@"保罗·沃尔特·豪泽"},@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/pbeDzh8wToIcel_avatar_uploaded1584958598.23.jpg",@"title":@"约翰·麦克雷"}];
    penguinModle7.penguinChase_MoviewTime =@" 2021-06-06(中国大陆) / 2021-05-28(美国/美国网络)";
    penguinModle7.penguinChase_MoviewType = @" 喜剧 / 犯罪";
    penguinModle7.penguinChase_isColltecd = NO;
    penguinModle7.penguinChase_DBSourecd  =7.0;
    penguinModle7.penguinChase_RateSourecd = 45;
    penguinModle7.penguinChase_MoviewID = 7;
    penguinModle7.TopType = @"0";
    [tempArr addObject:penguinModle7];
    
    
    
    PenguinChaseVideoModel * penguinModle8 = [[PenguinChaseVideoModel alloc]init];
    penguinModle7.WantNums = 126;
    penguinModle8.penguinChase_MoviewName = @"寂静之地2";
    penguinModle8.penguinChase_EngilshMoviewName = @"A Quiet Place: Part II";
    penguinModle8.penguinChase_MoviewIocnurl = @"https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2651298629.jpg";
    penguinModle8.penguinChase_MoviewImgArr = @[@"https://img1.doubanio.com/view/photo/l/public/p2645117557.jpg",@"https://img9.doubanio.com/view/photo/l/public/p2644950716.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2644950712.jpg",@"https://img3.doubanio.com/view/photo/l/public/p2644950710.jpg",@"https://img3.doubanio.com/view/photo/l/public/p2644950700.jpg",@"https://img1.doubanio.com/view/photo/l/public/p2644950697.jpg"];
    penguinModle8.penguinChase_MoviewTitle = @"它从天上来，怕吵又怕水。";
    penguinModle8.penguinChase_MoviewDesc = @"故事紧承上一部展开。在丈夫为保护家人牺牲后，伊芙琳（艾米莉·布朗特 饰）不得不独自带着孩子们（米莉森·西蒙斯、诺亚·尤佩 饰）面对全新的生存挑战。他们将被迫离开家园，踏上一段未知的旅途。在无声的世界里，除了要躲避“猎声怪物”的捕杀，铺满细沙的道路尽头还暗藏着新的危机。";
    penguinModle8.penguinChase_MoviewArtistArr =@[@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p1352.jpg",@"title":@"约翰·卡拉辛斯基 "},@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/p32548.jpg",@"title":@"艾米莉·布朗特"},@{@"img":@"https://img3.doubanio.com/view/celebrity/raw/public/p1440.jpg",@"title":@"基里安·墨菲"},@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/p1622427478.79.jpg",@"title":@"米利森特·西蒙兹"},@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p1516598354.03.jpg",@"title":@"诺亚·尤佩"}];
    penguinModle8.penguinChase_MoviewTime =@"2021-05-28(中国大陆/美国)";
    penguinModle8.penguinChase_MoviewType = @"科幻 / 惊悚 / 恐怖";
    penguinModle8.penguinChase_isColltecd = NO;
    penguinModle8.penguinChase_DBSourecd  =6.6;
    penguinModle8.penguinChase_RateSourecd = 72;
    penguinModle8.penguinChase_MoviewID = 8;
    penguinModle8.TopType = @"0";
    [tempArr addObject:penguinModle8];
    
    
    
    PenguinChaseVideoModel * penguinModle9= [[PenguinChaseVideoModel alloc]init];
    penguinModle9.WantNums = 452;
    penguinModle9.penguinChase_MoviewName = @"悬崖之上 ";
    penguinModle9.penguinChase_EngilshMoviewName = @"Impasse / Cliff Walkers";
    penguinModle9.penguinChase_MoviewIocnurl = @"https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2641614433.jpg";
    penguinModle9.penguinChase_MoviewImgArr = @[@"https://img2.doubanio.com/view/photo/l/public/p2640318171.jpg",@"https://img9.doubanio.com/view/photo/l/public/p2640315484.jpg",@"https://img3.doubanio.com/view/photo/l/public/p2639899530.jpg",@"https://img1.doubanio.com/view/photo/l/public/p2639359048.jpg",@"https://img1.doubanio.com/view/photo/l/public/p2639359047.jpg",@"https://img9.doubanio.com/view/photo/l/public/p2639359045.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2639359043.jpg"];
    penguinModle9.penguinChase_MoviewTitle = @"你看我为了革命卧薪尝胆";
    penguinModle9.penguinChase_MoviewDesc = @"上世纪三十年代，四位曾在苏联接受特训的共产党特工组成任务小队，回国执行代号为“乌特拉”的秘密行动。由于叛徒的出卖，他们从跳伞降落的第一刻起， 就已置身于敌人布下的罗网之中。同志能否脱身，任务能否完成，雪一直下，立于“悬崖之上”的行动小组面临严峻考验。";
    penguinModle9.penguinChase_MoviewArtistArr =@[@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/p568.jpg",@"title":@"张艺谋 "},@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/p1608309015.99.jpg",@"title":@"张译"},@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p1365451897.03.jpg",@"title":@"于和伟"},@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p1559632146.61.jpg",@"title":@"秦海璐"}];
    penguinModle9.penguinChase_MoviewTime =@"2021-04-30(中国大陆)";
    penguinModle9.penguinChase_MoviewType = @"剧情 / 动作 / 悬疑";
    penguinModle9.penguinChase_isColltecd = NO;
    penguinModle9.penguinChase_DBSourecd  =7.6;
    penguinModle9.penguinChase_RateSourecd = 79;
    penguinModle9.penguinChase_MoviewID = 9;
    penguinModle9.TopType = @"0";
    [tempArr addObject:penguinModle9];
    
    
    
    
    PenguinChaseVideoModel * penguinModle10 = [[PenguinChaseVideoModel alloc]init];
    penguinModle10.WantNums = 123;
    penguinModle10.penguinChase_MoviewName = @"比得兔2：逃跑计划";
    penguinModle10.penguinChase_EngilshMoviewName = @"Peter Rabbit 2: The Runaway";
    penguinModle10.penguinChase_MoviewIocnurl = @"https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2656009080.jpg";
    penguinModle10.penguinChase_MoviewImgArr = @[@"https://img2.doubanio.com/view/photo/l/public/p2655134943.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2655134941.jpg",@"https://img1.doubanio.com/view/photo/l/public/p2654533489.jpg",@"https://img1.doubanio.com/view/photo/l/public/p2654533488.jpg",@"https://img1.doubanio.com/view/photo/l/public/p2644392869.jpg"];
    penguinModle10.penguinChase_MoviewTitle = @"她在别人眼里是个好女孩，说话从不跑题";
    penguinModle10.penguinChase_MoviewDesc = @"为了追求自己的“兔”生意义，年少轻狂的比得（詹姆斯·柯登 James Corden 配音）踏上了背井离乡的路并成功赢得老江湖巴拿巴的青睐、成为了团伙中的扛把子，怎料却将追随而来的昔日老友们推入死亡陷阱。 幡然醒悟后，比得化身“兔界阿汤哥”带领同伴展开海陆空三栖大营救。高空跳伞、水下救援、雪山速滑、快艇追击，无所不能。在这场冒险旅途中，比得收获了友情，理解了亲情，最终实现了自我成长，成为真正的“兔一哥”。";
    penguinModle10.penguinChase_MoviewArtistArr =@[@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/p12038.jpg",@"title":@"威尔·古勒"},@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/p1449532609.88.jpg",@"title":@"詹姆斯·柯登"},@{@"img":@"https://img9.doubanio.com/view/celebrity/raw/public/p3186.jpg",@"title":@"罗丝·伯恩"},@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p1361026097.22.jpg",@"title":@"多姆纳尔·格里森"},@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p1389939796.3.jpg",@"title":@"玛格特·罗比"}];
    penguinModle10.penguinChase_MoviewTime =@"2021-06-11(中国大陆/美国) / 2021-03-25(澳大利亚)";
    penguinModle10.penguinChase_MoviewType = @"喜剧 / 动画 / 冒险";
    penguinModle10.penguinChase_isColltecd = NO;
    penguinModle10.penguinChase_DBSourecd  =7.2;
    penguinModle10.penguinChase_RateSourecd = 60;
    penguinModle10.penguinChase_MoviewID = 10;
    penguinModle10.TopType = @"0";
    [tempArr addObject:penguinModle10];
    
    
    
    PenguinChaseVideoModel * penguinModle11 = [[PenguinChaseVideoModel alloc]init];
    penguinModle11.penguinChase_MoviewName = @"恐惧街";
    penguinModle11.penguinChase_EngilshMoviewName = @"Fear Street";
    penguinModle11.penguinChase_MoviewIocnurl = @"https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2665617507.jpg";
    penguinModle11.penguinChase_MoviewImgArr = @[@"https://img2.doubanio.com/view/photo/l/public/p2667010452.jpg",@"https://img1.doubanio.com/view/photo/l/public/p2667010429.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2667010402.jpg",@"https://img9.doubanio.com/view/photo/l/public/p2667010375.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2666758433.jpg"];
    penguinModle11.penguinChase_MoviewTitle = @"";
    penguinModle11.penguinChase_MoviewDesc = @"声名狼藉的小镇发生一连串残忍屠杀案，一名青少女和朋友们决定挺身而出，对抗缠扰当地数百年的邪恶力量。欢迎光临阴暗小镇。　1994年，一群青少年发现横跨不同世代，闹得小镇人心惶惶的多起骇人事件系出同源，而且下一个待宰对象恐怕就是他们。《恐惧街》三部曲改编自 R·L·斯坦的畅销恐怖小说系列，记叙阴暗小镇梦魇般的险恶历史。";
    penguinModle11.penguinChase_MoviewArtistArr =@[@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p1564320075.23.jpg",@"title":@"丽恩·贾尼埃克 "},@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p1478570330.41.jpg",@"title":@"基亚娜·马德拉 "},@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/p1622631969.7.jpg",@"title":@"奥利维亚·韦尔奇"},@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/p1507545044.8.jpg",@"title":@"玛雅·霍克 Maya Hawke"},@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/pGjVf4Cm1t4ocel_avatar_uploaded1513867204.38.jpg",@"title":@"小本杰明·弗洛雷斯 "}];
    penguinModle11.penguinChase_MoviewTime =@"《恐惧街》三部曲改编自美国著名惊险小说作家R.L.斯坦畅销恐怖小说系列";
    penguinModle11.penguinChase_MoviewType = @" 悬疑 / 恐怖";
    penguinModle11.penguinChase_isColltecd = NO;
    penguinModle11.penguinChase_DBSourecd  =5.8;
    penguinModle11.penguinChase_RateSourecd = 51;
    penguinModle11.penguinChase_MoviewID = 11;
    penguinModle11.TopType = @"0";
    [tempArr addObject:penguinModle];
    
    
    
    PenguinChaseVideoModel * penguinModle12 = [[PenguinChaseVideoModel alloc]init];
    penguinModle12.penguinChase_MoviewName = @"鬼灭之刃 剧场版";
    penguinModle12.penguinChase_EngilshMoviewName = @"劇場版 鬼滅の刃";
    penguinModle12.penguinChase_MoviewIocnurl = @"https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2623798236.jpg";
    penguinModle12.penguinChase_MoviewImgArr = @[@"https://img9.doubanio.com/view/photo/l/public/p2571997336.jpg",@"https://img9.doubanio.com/view/photo/l/public/p2570052125.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2668428803.jpg"];
    penguinModle12.penguinChase_MoviewTitle = @"太阳燃烧了整夜，却在黎明时陨落";
    penguinModle12.penguinChase_MoviewDesc = @"该片基于吾峠呼世所著漫画《鬼灭之刃》创作而成，是2019年播出的TV动画的续篇，讲述灶门炭治郎和炼狱杏寿郎与下弦之壹魇梦作战的故事。";
    penguinModle12.penguinChase_MoviewArtistArr =@[@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/p1596443252.88.jpg",@"title":@"外崎春雄"},@{@"img":@"https://img9.doubanio.com/view/celebrity/raw/public/p1502065915.06.jpg",@"title":@"花江夏树"},@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/p1500952619.29.jpg",@"title":@"鬼头明里"},@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p10163.jpg",@"title":@"下野纮"}];
    penguinModle12.penguinChase_MoviewTime =@"2020-10-16(日本)";
    penguinModle12.penguinChase_MoviewType = @"动画";
    penguinModle12.penguinChase_isColltecd = NO;
    penguinModle12.penguinChase_DBSourecd  =8.0;
    penguinModle12.penguinChase_RateSourecd = 66;
    penguinModle12.penguinChase_MoviewID = 12;
    penguinModle12.TopType = @"0";
    [tempArr addObject:penguinModle12];
    
    
    PenguinChaseVideoModel * penguinModle13 = [[PenguinChaseVideoModel alloc]init];
    penguinModle13.penguinChase_MoviewName = @"机动战士高达";
    penguinModle13.penguinChase_EngilshMoviewName = @"機動戦士ガンダム 閃光のハサウェイ";
    penguinModle13.penguinChase_MoviewIocnurl = @"https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2591960411.jpg";
    penguinModle13.penguinChase_MoviewImgArr = @[@"https://img2.doubanio.com/view/photo/l/public/p2608996952.jpg",@"https://img9.doubanio.com/view/photo/l/public/p2608996875.jpg"];
    penguinModle13.penguinChase_MoviewTitle = @"世界会和平很多。";
    penguinModle13.penguinChase_MoviewDesc = @"本作以哈萨维为主角，采取三部曲的形式，讲述“逆袭的夏亚”之后的故事。";
    penguinModle13.penguinChase_MoviewArtistArr =@[@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/p1509088323.78.jpg",@"title":@"村濑修功"},@{@"img":@"https://img9.doubanio.com/view/celebrity/raw/public/p57124.jpg",@"title":@"小野贤章 "},@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/p1550466761.98.jpg",@"title":@"上田丽奈"},@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p5771.jpg",@"title":@"诹访部顺一"}];
    penguinModle13.penguinChase_MoviewTime =@"2021-06-11(日本)";
    penguinModle13.penguinChase_MoviewType = @"剧情 / 科幻 / 动画 / 战争";
    penguinModle13.penguinChase_isColltecd = NO;
    penguinModle13.penguinChase_DBSourecd  =8.7;
    penguinModle13.penguinChase_RateSourecd = 87;
    penguinModle13.penguinChase_MoviewID = 13;
    penguinModle13.TopType = @"";
    [tempArr addObject:penguinModle13];
    
    
    PenguinChaseVideoModel * penguinModle14 = [[PenguinChaseVideoModel alloc]init];
    penguinModle14.penguinChase_MoviewName = @"普吉岛的最后黄昏";
    penguinModle14.penguinChase_EngilshMoviewName = @"แปลรักฉันด้วยใจเธอ Side Story";
    penguinModle14.penguinChase_MoviewIocnurl = @"https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2652268085.jpg";
    penguinModle14.penguinChase_MoviewImgArr = @[@"https://img9.doubanio.com/view/photo/l/public/p2653025645.jpg",@"https://img9.doubanio.com/view/photo/l/public/p2651789266.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2651788983.jpg"];
    penguinModle14.penguinChase_MoviewTitle = @"我爱的少年永远在热恋";
    penguinModle14.penguinChase_MoviewDesc = @"即将迎接曼谷的大学生活，离开普吉岛之前，德要给欧儿一个特别的一天…";
    penguinModle14.penguinChase_MoviewArtistArr =@[@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/p1605104164.48.jpg",@"title":@"纳卢拜·库诺"},@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/p1605900355.08.jpg",@"title":@"普提蓬·阿萨拉塔纳功 "},@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p1605581788.31.jpg",@"title":@"克里特·安努艾德奇康"},@{@"img":@"https://img1.doubanio.com/view/celebrity/raw/public/pr3E8LGxNGWkcel_avatar_uploaded1621952998.88.jpg",@"title":@"小纳隆·切德索恩"}];
    penguinModle14.penguinChase_MoviewTime =@"2021-05-20(中国大陆)";
    penguinModle14.penguinChase_MoviewType = @" 剧情 / 喜剧 / 同性";
    penguinModle14.penguinChase_isColltecd = NO;
    penguinModle14.penguinChase_DBSourecd  =9.2;
    penguinModle14.penguinChase_RateSourecd = 98;
    penguinModle14.penguinChase_MoviewID = 14;
    penguinModle14.TopType = @"";
    [tempArr addObject:penguinModle14];
    
    
    
    PenguinChaseVideoModel * penguinModle15 = [[PenguinChaseVideoModel alloc]init];
    penguinModle15.penguinChase_MoviewName = @"酒精计划";
    penguinModle15.penguinChase_EngilshMoviewName = @"Druk";
    penguinModle15.penguinChase_MoviewIocnurl = @"https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2628440526.jpg";
    penguinModle15.penguinChase_MoviewImgArr = @[@"https://img3.doubanio.com/view/photo/l/public/p2629237370.jpg",@"https://img1.doubanio.com/view/photo/l/public/p2629200568.jpg",@"https://img1.doubanio.com/view/photo/l/public/p2629155078.jpg",@"https://img9.doubanio.com/view/photo/l/public/p2629155074.jpg"];
    penguinModle15.penguinChase_MoviewTitle = @"人类血液酒精浓度达到0.05％会更幸福吗";
    penguinModle15.penguinChase_MoviewDesc = @"　本片将围绕马丁(米科尔森饰)和他三个朋友展开，这四个高中老师为了摆脱日常的循规蹈矩，开始了一项持续醉酒的实验。虽然计划最初很成功，但最终失败了。";
    penguinModle15.penguinChase_MoviewArtistArr =@[@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p50973.jpg",@"title":@"托马斯·温特伯格"},@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p57893.jpg",@"title":@"麦斯·米科尔森"},@{@"img":@"https://img9.doubanio.com/view/celebrity/raw/public/p48344.jpg",@"title":@"托玛斯·博·拉森 "},@{@"img":@"https://img2.doubanio.com/view/personage/raw/public/760c696ade1c8127a1da1f7835efda71.jpg",@"title":@"马格努斯·米兰 "}];
    penguinModle15.penguinChase_MoviewTime =@"2020-09-12(多伦多电影节) / 2020-09-24(丹麦)";
    penguinModle15.penguinChase_MoviewType = @" 剧情 / 喜剧";
    penguinModle15.penguinChase_isColltecd = NO;
    penguinModle15.penguinChase_DBSourecd  =7.7;
    penguinModle15.penguinChase_RateSourecd = 78;
    penguinModle15.penguinChase_MoviewID = 15;
    penguinModle15.TopType = @"";
    [tempArr addObject:penguinModle15];
    
    
    PenguinChaseVideoModel * penguinModle16 = [[PenguinChaseVideoModel alloc]init];
    penguinModle16.penguinChase_MoviewName = @"酒精计划";
    penguinModle16.penguinChase_EngilshMoviewName = @"Druk";
    penguinModle16.penguinChase_MoviewIocnurl = @"https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2628440526.jpg";
    penguinModle16.penguinChase_MoviewImgArr = @[@"https://img3.doubanio.com/view/photo/l/public/p2629237370.jpg",@"https://img1.doubanio.com/view/photo/l/public/p2629200568.jpg",@"https://img1.doubanio.com/view/photo/l/public/p2629155078.jpg",@"https://img9.doubanio.com/view/photo/l/public/p2629155074.jpg"];
    penguinModle16.penguinChase_MoviewTitle = @"人类血液酒精浓度达到0.05％会更幸福吗";
    penguinModle16.penguinChase_MoviewDesc = @"　本片将围绕马丁(米科尔森饰)和他三个朋友展开，这四个高中老师为了摆脱日常的循规蹈矩，开始了一项持续醉酒的实验。虽然计划最初很成功，但最终失败了。";
    penguinModle16.penguinChase_MoviewArtistArr =@[@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p50973.jpg",@"title":@"托马斯·温特伯格"},@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p57893.jpg",@"title":@"麦斯·米科尔森"},@{@"img":@"https://img9.doubanio.com/view/celebrity/raw/public/p48344.jpg",@"title":@"托玛斯·博·拉森 "},@{@"img":@"https://img2.doubanio.com/view/personage/raw/public/760c696ade1c8127a1da1f7835efda71.jpg",@"title":@"马格努斯·米兰 "}];
    penguinModle16.penguinChase_MoviewTime =@"2020-09-12(多伦多电影节) / 2020-09-24(丹麦)";
    penguinModle16.penguinChase_MoviewType = @" 剧情 / 喜剧";
    penguinModle16.penguinChase_isColltecd = NO;
    penguinModle16.penguinChase_DBSourecd  =7.7;
    penguinModle16.penguinChase_RateSourecd = 78;
    penguinModle16.penguinChase_MoviewID = 16;
    penguinModle16.TopType = @"";
    [tempArr addObject:penguinModle16];
    
    
    PenguinChaseVideoModel * penguinModle17 = [[PenguinChaseVideoModel alloc]init];
    penguinModle17.penguinChase_MoviewName = @"黑道与家族 ";
    penguinModle17.penguinChase_EngilshMoviewName = @"ヤクザと家族";
    penguinModle17.penguinChase_MoviewIocnurl = @"https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2625912897.jpg";
    penguinModle17.penguinChase_MoviewImgArr = @[@"https://img9.doubanio.com/view/photo/l/public/p2646796036.jpg",@"https://img9.doubanio.com/view/photo/l/public/p2646796035.jpg",@"https://img9.doubanio.com/view/photo/l/public/p2646796034.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2646796033.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2646796032.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2646796031.jpg"];
    penguinModle17.penguinChase_MoviewTitle = @"古惑仔都停刊了，一个时代结束了。";
    penguinModle17.penguinChase_MoviewDesc = @"　凭借《新闻记者》荣获2019年日本电影学院奖最佳影片的藤井道人导演，其最新力作转而呈现黑帮家族史诗，以1999，2005，2019三个年份为切入点，故事线跨越平成与令和时代的风云变迁，以极度压迫性的镜头语言诠释现代社会中的黑社会真相以及黑道族人的生存准则。绫野刚再度贡献影帝级别的表演，实力演绎年少漂泊被黑帮收留的主人公贤治，自此一生陷入残酷恶斗与亲情挚爱的两难之中。";
    penguinModle17.penguinChase_MoviewArtistArr =@[@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p1485061658.43.jpg",@"title":@"藤井道人"},@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p1354602963.53.jpg",@"title":@"绫野刚"},@{@"img":@"https://img9.doubanio.com/view/celebrity/raw/public/p1373863535.56.jpg",@"title":@"馆博"},@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p34423.jpg",@"title":@"北村有起哉"}];
    penguinModle17.penguinChase_MoviewTime =@"2020-12-06(海南岛电影节) / 2021-01-29(日本)";
    penguinModle17.penguinChase_MoviewType = @"剧情 / 犯罪";
    penguinModle17.penguinChase_isColltecd = NO;
    penguinModle17.penguinChase_DBSourecd  =7.7;
    penguinModle17.penguinChase_RateSourecd = 77;
    penguinModle17.penguinChase_MoviewID = 17;
    penguinModle17.TopType = @"";
    [tempArr addObject:penguinModle17];
    
    
    PenguinChaseVideoModel * penguinModle18 = [[PenguinChaseVideoModel alloc]init];
    penguinModle18.penguinChase_MoviewName = @"黑道与家族 ";
    penguinModle18.penguinChase_EngilshMoviewName = @"ヤクザと家族";
    penguinModle18.penguinChase_MoviewIocnurl = @"https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2625912897.jpg";
    penguinModle18.penguinChase_MoviewImgArr = @[@"https://img9.doubanio.com/view/photo/l/public/p2646796036.jpg",@"https://img9.doubanio.com/view/photo/l/public/p2646796035.jpg",@"https://img9.doubanio.com/view/photo/l/public/p2646796034.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2646796033.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2646796032.jpg",@"https://img2.doubanio.com/view/photo/l/public/p2646796031.jpg"];
    penguinModle18.penguinChase_MoviewTitle = @"古惑仔都停刊了，一个时代结束了。";
    penguinModle18.penguinChase_MoviewDesc = @"　凭借《新闻记者》荣获2019年日本电影学院奖最佳影片的藤井道人导演，其最新力作转而呈现黑帮家族史诗，以1999，2005，2019三个年份为切入点，故事线跨越平成与令和时代的风云变迁，以极度压迫性的镜头语言诠释现代社会中的黑社会真相以及黑道族人的生存准则。绫野刚再度贡献影帝级别的表演，实力演绎年少漂泊被黑帮收留的主人公贤治，自此一生陷入残酷恶斗与亲情挚爱的两难之中。";
    penguinModle18.penguinChase_MoviewArtistArr =@[@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p1485061658.43.jpg",@"title":@"藤井道人"},@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p1354602963.53.jpg",@"title":@"绫野刚"},@{@"img":@"https://img9.doubanio.com/view/celebrity/raw/public/p1373863535.56.jpg",@"title":@"馆博"},@{@"img":@"https://img2.doubanio.com/view/celebrity/raw/public/p34423.jpg",@"title":@"北村有起哉"}];
    penguinModle18.penguinChase_MoviewTime =@"2020-12-06(海南岛电影节) / 2021-01-29(日本)";
    penguinModle18.penguinChase_MoviewType = @"剧情 / 犯罪";
    penguinModle18.penguinChase_isColltecd = NO;
    penguinModle18.penguinChase_DBSourecd  =7.7;
    penguinModle18.penguinChase_RateSourecd = 77;
    penguinModle18.penguinChase_MoviewID = 17;
    penguinModle18.TopType = @"";
    [tempArr addObject:penguinModle18];
    
    
    PenguinChaseVideoModel * penguinModle19 = [[PenguinChaseVideoModel alloc]init];
    penguinModle19.penguinChase_MoviewName = @"扎克·施奈德版正义联盟";
    penguinModle19.penguinChase_EngilshMoviewName = @" Zack Snyder's Justice League ";
    penguinModle19.penguinChase_MoviewIocnurl = @"https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2634360594.jpg";
    penguinModle19.penguinChase_MoviewImgArr = @[@"https://img9.doubanio.com/view/photo/l/public/p2618157025.jpg",@"https://img9.doubanio.com/view/photo/l/public/p2618157024.jpg",@"https://img1.doubanio.com/view/photo/l/public/p2618157017.jpg"];
    penguinModle19.penguinChase_MoviewTitle = @"很喜欢女侠的女声吟唱主旋律";
    penguinModle19.penguinChase_MoviewDesc = @"布鲁斯·韦恩（本·阿弗莱克饰）为了确保不让超人（亨利·卡维尔饰）白白牺牲，他决定与戴安娜·普林斯（盖尔·加朵饰）联手并计划招募一支超能力者团队来保护世界免遭即将到来的灾难性威胁。但这项任务比布鲁斯想象中要困难，因为每位成员都必须面对并跨越自己过去的心魔，团结起来，最终形成一个前所未有的英雄联盟。 蝙蝠侠、神奇女侠、海王（杰森·莫玛饰）、钢骨（雷·费舍饰）、闪电侠（埃兹拉·米勒饰）现在必须联合起来，否则就无法阻止荒原狼（塞伦·希德饰）、狄萨德（彼得·吉尼斯饰）以及达克赛德（雷·波特饰）毁灭地球的可怕计划。";
    penguinModle19.penguinChase_MoviewArtistArr =@[];
    penguinModle19.penguinChase_MoviewTime =@"2021-05-03(中国大陆网络) / 2021-03-18(美国)";
    penguinModle19.penguinChase_MoviewType = @"动作 / 科幻 / 奇幻 / 冒险";
    penguinModle19.penguinChase_isColltecd = NO;
    penguinModle19.penguinChase_DBSourecd  =8.2;
    penguinModle19.penguinChase_RateSourecd = 94;
    penguinModle19.penguinChase_MoviewID = 18;
    penguinModle19.TopType = @"";
    [tempArr addObject:penguinModle19];
    
    
    
    PenguinChaseVideoModel * penguinModle20 = [[PenguinChaseVideoModel alloc]init];
    penguinModle20.penguinChase_MoviewName = @"切尔诺贝利";
    penguinModle20.penguinChase_EngilshMoviewName = @"Чернобыль";
    penguinModle20.penguinChase_MoviewIocnurl = @"https://img9.doubanio.com/view/photo/s_ratio_poster/public/p2640665946.jpg";
    penguinModle20.penguinChase_MoviewImgArr = @[@"https://img9.doubanio.com/view/photo/l/public/p2631666175.jpg",@"https://img9.doubanio.com/view/photo/l/public/p2631666174.jpg",@"https://img1.doubanio.com/view/photo/l/public/p2611016269.jpg"];
    penguinModle20.penguinChase_MoviewTitle = @"再好的戏剧也没有真实纪录更感人。";
    penguinModle20.penguinChase_MoviewDesc = @"这是俄罗斯第一部大型电影，讲述了切尔诺贝利核电站事故的后果以及为避免全球灾难付出生命代价的人们的复原情况。并将欧洲大陆的大部分地区变成一个巨大的异地区和无人居住的沙漠。主角是消防队员阿列克谢，初看起来不像英雄。瓦莱尔卡工程师和鲍里斯的潜水员自愿同他一起去进行危险的突袭。 几乎没有时间制定详细的计划。由于熔化的堆芯临近，反应堆容器内的水每小时都变得越来越热。该小组面临着一个致命的任务，一个最危险的任务-去地狱，也许是最可怕的灾难后果。";
    penguinModle20.penguinChase_MoviewArtistArr =@[];
    penguinModle20.penguinChase_MoviewTime =@"2021-04-15(俄罗斯)";
    penguinModle20.penguinChase_MoviewType = @"剧情 / 灾难";
    penguinModle20.penguinChase_isColltecd = NO;
    penguinModle20.penguinChase_DBSourecd  =6.4;
    penguinModle20.penguinChase_RateSourecd = 42;
    penguinModle20.penguinChase_MoviewID = 19;
    penguinModle20.TopType = @"";
    [tempArr addObject:penguinModle20];
    

    
    BOOL  isMoview = [[NSUserDefaults standardUserDefaults] boolForKey:@"PenguinChaseVideoModel"];
    if (isMoview  == NO) {
        BOOL isMoviewInset = [WHC_ModelSqlite inserts:tempArr.copy];
        [[NSUserDefaults standardUserDefaults] setBool:isMoviewInset forKey:@"PenguinChaseVideoModel"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
+(void)PenguinChaseVideoComentModelConfigers{
    NSMutableArray * tempArr = [NSMutableArray array];
    PenguinChaseVideoComentModel * penguinModel = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel.userName = @"夏天的雨";
    penguinModel.userHeadeurl = @"https://img2.doubanio.com/icon/u74102027-1.jpg";
    penguinModel.starNum = 2;
    penguinModel.content = @"说真的，看了这么多穿越类的电影，我也算是资深影迷了，可这部片子看的我实在是问号连连！! 这部逻辑BUG太严重了，连基础常识逻辑都不通， 一，30年后一群专业军队都解决不了的怪物，跑到30年前找菜鸡过去送死 找未来的人来解决现在的事我还能理解，毕竟未来的人知识储备就比我...";
    penguinModel.MoviewID = 0;
    penguinModel.ComentID = 0;
    penguinModel.CellHeight = 0;
    [tempArr addObject:penguinModel];
    
    PenguinChaseVideoComentModel * penguinModel1 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel1.userName = @"无理คิดถึง ";
    penguinModel1.userHeadeurl = @"https://img2.doubanio.com/icon/u195665053-1.jpg";
    penguinModel1.starNum = 4;
    penguinModel1.content = @"F22超低空去扔几百磅的普通炸弹。F22都养得起，能不能随便弄几发云爆弹用用？集束炸弹也能勉强用啊。 明知道这帮怪兽防高，小队里连个重火力都不配，班用机枪、榴弹发射器、单兵火箭筒，一堆人拿着 AR是去打吃鸡吧？ 最后的海上堡垒，好几层的防御，居然最主要的防御是靠第一层.";
    penguinModel1.MoviewID = 0;
    penguinModel1.ComentID = 1;
    penguinModel1.CellHeight = 0;
    [tempArr addObject:penguinModel1];
    
    
    PenguinChaseVideoComentModel * penguinModel2 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel2.userName = @"20个小明≯";
    penguinModel2.userHeadeurl = @"https://img2.doubanio.com/icon/u4515467-2.jpg";
    penguinModel2.starNum = 3;
    penguinModel2.content = @"神一样的制作，智障一样的剧情……期间数度想砸电脑（不过还是下不去手给三星），卡通沙龙可长点心吧……";
    penguinModel2.MoviewID = 1;
    penguinModel2.ComentID = 2;
    penguinModel2.CellHeight = 0;
    [tempArr addObject:penguinModel2];
    
    
    PenguinChaseVideoComentModel * penguinModel3 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel3.userName = @"软宇宙";
    penguinModel3.userHeadeurl = @"https://img2.doubanio.com/icon/u158617043-3.jpg";
    penguinModel3.starNum = 3;
    penguinModel3.content = @"本人并没有多少关于爱尔兰民间传说故事的知识储备，因此很难剖析其中的隐喻。作为一名普通观众，为了不剧透只能浅浅谈谈感受。和前作比较，《凯尔经的秘密》讲述一件艺术传奇的诞生，中间有冒险和继承，有友情和亲情，也有关于侵略的思考；《海洋之歌》更加唯美，思考城市的冷漠，描绘亲情和爱情的力量，试图抚平失去的痛苦；《狼行者》则主要勾画了人与自然的矛盾，用一条友情线和两条亲情线串连起来，最终交织出结局。剧情不算意外，大可轻松欣赏，可能会联想到宫崎骏的《幽灵公主》《风之谷》。因此如果真要批评本作剧情欠缺点力量，稍显老套，也可以接受。";
    penguinModel3.MoviewID = 1;
    penguinModel3.ComentID = 3;
    penguinModel3.CellHeight = 0;
    [tempArr addObject:penguinModel3];
    
    PenguinChaseVideoComentModel * penguinModel4 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel4.userName = @"舞动柯布斯";
    penguinModel4.userHeadeurl = @"https://img9.doubanio.com/icon/u132527345-5.jpg";
    penguinModel4.starNum = 4;
    penguinModel4.content = @"从《凯尔经的秘密》到《海洋之歌》再到这部《狼行者》，不得不说，汤姆·摩尔成功绘制了自己的凯尔特宇宙。 粗粝的笔触和如梦似幻的画面，仿佛我们小时候看过的绘本，有种返璞归真的纯净。在故事上，没有太多复杂的人性，直来直往，也没有旁逸斜出的情节，真就像说给小孩听的睡..";
    penguinModel4.MoviewID = 1;
    penguinModel4.ComentID = 4;
    penguinModel4.CellHeight = 0;
    [tempArr addObject:penguinModel4];
    
    
    PenguinChaseVideoComentModel * penguinModel5 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel5.userName = @"KNSZ ";
    penguinModel5.userHeadeurl = @"https://img2.doubanio.com/icon/u162219036-1.jpg";
    penguinModel5.starNum = 3;
    penguinModel5.content = @"阿剛給大家講一個為母則剛的故事，阿剛太可憐了 T_T 而有些母親是真的不太配做母親，唉。服部少女真是天賜的芭蕾材料。";
    penguinModel5.MoviewID = 2;
    penguinModel5.ComentID = 5;
    penguinModel5.CellHeight = 0;
    [tempArr addObject:penguinModel5];
    
    
    PenguinChaseVideoComentModel * penguinModel6 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel6.userName = @"刘不自在";
    penguinModel6.userHeadeurl = @"https://img1.doubanio.com/icon/u25422224-9.jpg";
    penguinModel6.starNum = 4;
    penguinModel6.content = @"说起草剪刚，我对他的印象还停留在他醉酒在公园裸奔的狼狈新闻里。不过由此可见草剪刚内心或许存在有点违背日本人民族性格的奔放和大胆。从这个角度说来，草剪刚饰演一名性别错位的lgbt人士或许可行。但是从我全场观影来看，草剪刚的表演还是缺乏说服力。首先还是剧情背锅。个人感觉本片最大的问题是，导演一直在商业和文艺，克制和肆意甚至博狗血，大众和小众之间毫无逻辑的跳转。举个例子，草剪刚（以演员名字代替角色名字）作为变性ing人士，会产生不断的动摇是很正常的。无论这种动摇是受生活所迫，还是内心本身动摇都是很正常的。正是这种动摇的存在，才是人性真实的体现";
    penguinModel6.MoviewID = 2;
    penguinModel6.ComentID = 6;
    penguinModel6.CellHeight = 0;
    [tempArr addObject:penguinModel6];
    
    
    PenguinChaseVideoComentModel * penguinModel7 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel7.userName = @"德小科";
    penguinModel7.userHeadeurl = @"https://img2.doubanio.com/icon/u119554701-2.jpg";
    penguinModel7.starNum = 4;
    penguinModel7.content = @"故事真的老到牙床都没了，同类的电影都可以凑出一个101了。但是！！这个男主！！这是什么钟灵毓秀出来的绝绝子！！这楚楚可怜的小狗眼！！阿伟挫骨扬灰！！为了男主加分加分加分！！";
    penguinModel7.MoviewID = 3;
    penguinModel7.ComentID = 7;
    penguinModel7.CellHeight = 0;
    [tempArr addObject:penguinModel7];
    
    
    PenguinChaseVideoComentModel * penguinModel8 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel8.userName = @"Dp昊";
    penguinModel8.userHeadeurl = @"https://img2.doubanio.com/icon/u175683958-2.jpg";
    penguinModel8.starNum = 2;
    penguinModel8.content = @"在soapone看完了浴火鸟。很像电影燃烧蓝还有腐国前几年拍的橘衫男子。剧情还行，俗套归俗套，但毕竟人家真实故事改编，很少有人说真事俗套的对吧。 和看断背山一样的感觉，特别是看到结尾真实照片心里就开始堵，暂停盯照片看，有一种脱虚入实的惋惜，一边回想电影的情节片段，...  ";
    penguinModel8.MoviewID = 3;
    penguinModel8.ComentID = 8;
    penguinModel8.CellHeight = 0;
    [tempArr addObject:penguinModel8];
    
    
    PenguinChaseVideoComentModel * penguinModel9 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel9.userName = @"轻风羽";
    penguinModel9.userHeadeurl = @"https://img2.doubanio.com/icon/u2339941-3.jpg";
    penguinModel9.starNum = 4;
    penguinModel9.content = @"女主角这个病算不上疯，但也可能带给人最无望的爱情．恰好手边书是毛姆的短篇集，中有一故事讲述一男子因事坐了牢，疯狂想念准备结婚的女朋友，在出狱前却突然再也不想见她了，因为长时间过于想念终于发展到想她想到一想就吐...可见适度的压抑才有益于健康，过于释放自己不一定好．本片虽有噱头，感情戏其实也不出彩，亮点在男主那个疑神疑鬼的室友．";
    penguinModel9.MoviewID = 4;
    penguinModel9.ComentID = 9;
    penguinModel9.CellHeight = 0;
    [tempArr addObject:penguinModel9];
    
    
    PenguinChaseVideoComentModel * penguinModel10 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel10.userName = @"柳三行 ";
    penguinModel10.userHeadeurl = @"https://img1.doubanio.com/icon/u77299768-9.jpg";
    penguinModel10.starNum = 4;
    penguinModel10.content = @"内容倒还不错，少给一星就为这个结尾。 个人认为，看电影就是看别人的故事，另一种生活。 一部喜剧片，不一定要发人深省，但一定要让观看者身心愉悦。 男主爱这个姑娘，其实是爱的就是她的疯狂，觉得那些刺激的事才叫发泄。毫无节制的发泄才是病。 把自己伪装成病人住进疯人院...";
    penguinModel10.MoviewID = 4;
    penguinModel10.ComentID = 10;
    penguinModel10.CellHeight = 0;
    [tempArr addObject:penguinModel10];
    
    
    
    PenguinChaseVideoComentModel * penguinModel11 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel11.userName = @"不要再睡觉了 ";
    penguinModel11.userHeadeurl = @"https://img2.doubanio.com/icon/u173470605-3.jpg";
    penguinModel11.starNum = 3;
    penguinModel11.content = @"作为Pixar的死忠粉...看到消息18号3点在Disney+上映就掐点看完了。 依旧是我爱的那个Pixar";
    penguinModel11.MoviewID = 5;
    penguinModel11.ComentID = 11;
    penguinModel11.CellHeight = 0;
    [tempArr addObject:penguinModel11];
    
    PenguinChaseVideoComentModel * penguinModel12 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel12.userName = @"电影榨汁";
    penguinModel12.userHeadeurl = @"https://img1.doubanio.com/icon/u57474452-9.jpg";
    penguinModel12.starNum = 3;
    penguinModel12.content = @"连同性之间都不能有单纯的友情了吗？ 是被LGBT洗脑太深了吗？ 本人不反对LGBT，但是为什么只要是同性之间的友谊都会被往那个方向猜忌呢？ 现在的人再也回不到过去的单纯了吗？ 一部动画片，一个单纯的故事，被解读成隐喻LGBT？…… 它不就是一部简单的励志片吗？ 不就是鼓励你.";
    penguinModel12.MoviewID = 5;
    penguinModel12.ComentID = 12;
    penguinModel12.CellHeight = 0;
    [tempArr addObject:penguinModel12];
    
    
    PenguinChaseVideoComentModel * penguinModel13 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel13.userName = @"迷影映画";
    penguinModel13.userHeadeurl = @"https://img2.doubanio.com/icon/u131090109-3.jpg";
    penguinModel13.starNum = 4;
    penguinModel13.content = @"泪如雨下，打工人加班故而错过了片头男女主的甜蜜告白，进场后看到的故事感觉一直在被刀，被现实无情鞭打的小情侣，替他们唏嘘惋惜同时也有羡慕，一生一次最炙热的相爱，不管结局如何！男演员虽然现实里比较渣，但演技是真可以！";
    penguinModel13.MoviewID = 6;
    penguinModel13.ComentID = 13;
    penguinModel13.CellHeight = 0;
    [tempArr addObject:penguinModel13];
    
    
    PenguinChaseVideoComentModel * penguinModel14 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel14.userName = @"润泽万生";
    penguinModel14.userHeadeurl = @"https://img9.doubanio.com/icon/u20840262-4.jpg";
    penguinModel14.starNum = 4;
    penguinModel14.content = @"有了现实故事改编的基础，让本片中除了爱情的浪漫之外还多了份生活的烟火气。起码有关土木工程的戏份让我这种对该行业不甚了解的观众多少有些信服。 剧作中关于爱情的描述其实缺乏循序渐进的过程，这里并非在说情愫产生的速度，而是过程。我知道爱情可以来得飞快，但再快其中也... ";
    penguinModel14.MoviewID = 6;
    penguinModel14.ComentID = 14;
    penguinModel14.CellHeight = 0;
    [tempArr addObject:penguinModel14];
    
    PenguinChaseVideoComentModel * penguinModel15 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel15.userName = @"一只卤煮猫";
    penguinModel15.userHeadeurl = @"https://img2.doubanio.com/icon/u207511282-1.jpg";
    penguinModel15.starNum = 3;
    penguinModel15.content = @"观感太割裂了，一边频频被视觉设计上的创意惊艳到，一边又不知道导演在吃力地表达什么，库伊拉这个本来能有深度挖掘空间的主角最终沦为了一种纯猎奇式的空壳人物，视觉残影散去以后，我还是没有懂她为何会逐渐演化成后传中的极端恶人。但终归两位艾玛对戏实在太精彩，戏剧张力拉满。影片虽然整体不完美，但是足够被牢记。";
    penguinModel15.MoviewID = 7;
    penguinModel15.ComentID = 15;
    penguinModel15.CellHeight = 0;
    [tempArr addObject:penguinModel15];
    
    
    PenguinChaseVideoComentModel * penguinModel16 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel16.userName = @"鐘綠 ";
    penguinModel16.userHeadeurl = @"https://img2.doubanio.com/icon/u3578609-13.jpg";
    penguinModel16.starNum = 3;
    penguinModel16.content = @"本片的服装设计是10次获得奥斯卡最佳服装设计提名，并凭借《看得见风景的房间》《疯狂麦克斯：狂暴之路》两夺桂冠的电影服饰大师Jenny Beavan。她为女主设计了47套服装，本文将展示其中的36套（不包括孩童时期的若干套和做服务员时期的两套）。 Jenny Beavan的10次提名在奥斯卡..";
    penguinModel16.MoviewID = 7;
    penguinModel16.ComentID = 16;
    penguinModel16.CellHeight = 0;
    [tempArr addObject:penguinModel16];
    
    
    
    PenguinChaseVideoComentModel * penguinModel17 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel17.userName = @"sTill-Life ";
    penguinModel17.userHeadeurl = @"https://img2.doubanio.com/icon/u2174910-33.jpg";
    penguinModel17.starNum = 3;
    penguinModel17.content = @"不知道有没有人和我一样，小时候会经常梦见自己遇到险情时无法发声。有一次梦见我和父亲同行，我在后面被人抓住了，走在前面的父亲浑然不知，我使劲叫喊却怎么也发不出声，最终在巨大的恐慌中醒来。被禁声，是人类最深的恐惧之一。";
    penguinModel17.MoviewID = 8;
    penguinModel17.ComentID = 17;
    penguinModel17.CellHeight = 0;
    [tempArr addObject:penguinModel17];
    
    PenguinChaseVideoComentModel * penguinModel18 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel18.userName = @"李唐星辰 ";
    penguinModel18.userHeadeurl = @"https://img3.doubanio.com/icon/u64751632-10.jpg";
    penguinModel18.starNum = 3;
    penguinModel18.content = @"相比较《寂静之地1》，《寂静之地2》呈现出了一个更完整的故事和架构。我们不需要去想象过去发生了什么，在那447天之前，怪兽席卷而来，无声的生存成为唯一活下去的希望。 1、第一部的叙事非常简单，围绕一家人的生存展开，我们能够看到每个人为了家庭存活下去的努力与坚持";
    penguinModel18.MoviewID = 8;
    penguinModel18.ComentID = 18;
    penguinModel18.CellHeight = 0;
    [tempArr addObject:penguinModel18];
    
    PenguinChaseVideoComentModel * penguinModel19 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel19.userName = @"Neptune";
    penguinModel19.userHeadeurl = @"https://img1.doubanio.com/icon/u2458096-8.jpg";
    penguinModel19.starNum = 3;
    penguinModel19.content = @"画面很美，情节也很棒。 个人最喜欢的是其中各个场景（或者说章节）里的「信息战」，里面不同角色基于自己信息的行事逻辑，很漂亮很有美感。 还是试着用问答的形式，来梳理一下自己觉得精彩的地方。 . 先说下演员和角色的对应，以便下面好指代 [张译]饰 张宪臣（后面简称张） [";
    penguinModel19.MoviewID = 9;
    penguinModel19.ComentID = 19;
    penguinModel19.CellHeight = 0;
    [tempArr addObject:penguinModel19];
    
    
    PenguinChaseVideoComentModel * penguinModel20 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel20.userName = @"旅客 ";
    penguinModel20.userHeadeurl = @"https://img2.doubanio.com/icon/u144098530-2.jpg";
    penguinModel20.starNum = 4;
    penguinModel20.content = @"看的点映。带着些许期待去看的，不多。毕竟这可是张艺谋阿，但这是现在的张艺谋阿。懒得写正经的影评了，就随便说说吧。 标题也能看出，我对刘浩存在《悬崖之上》里的表现非常不满，可以说这部影片因为她成了失败之作。 这里就要提醒下刘浩存的粉丝理性，标题也是这个意思。你..";
    penguinModel20.MoviewID = 9;
    penguinModel20.ComentID = 20;
    penguinModel20.CellHeight = 0;
    [tempArr addObject:penguinModel20];
    
    PenguinChaseVideoComentModel * penguinModel21 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel21.userName = @"旅客 ";
    penguinModel21.userHeadeurl = @"https://img2.doubanio.com/icon/u144098530-2.jpg";
    penguinModel21.starNum = 3;
    penguinModel21.content = @"24th SSIF No.03@虹桥艺术中心。好看好看。放映完影院自发三波掌声。我对追忆篇比较执着，人诛篇随缘，但看完算是远超预期。动作设计一部好过一部，到这部说是达到了类型片最高水准也不为过，决战的环境战损真实丰富且与动作戏衔接一气呵成。宗次郎出场跟剑心背靠背，《飞天》千呼万唤终于响起的时候，简直不要太燃。桥段笑点也不错，因为有上海背景，每次三脚猫中文都集体笑场。左之助那句：你就是剑心的小舅子吧是最强笑点。村花39分钟出场，巴的造型头发放下来遮脸正好造就她的颜值巅峰。44分开始追忆的名场面被剧透了个底朝天。于是对一手明牌来为系列压轴的追忆篇更添期待。";
    penguinModel21.MoviewID = 10;
    penguinModel21.ComentID = 21;
    penguinModel21.CellHeight = 0;
    [tempArr addObject:penguinModel21];
    
    PenguinChaseVideoComentModel * penguinModel22 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel22.userName = @"Nobody ";
    penguinModel22.userHeadeurl = @"https://img9.doubanio.com/icon/u178987364-6.jpg";
    penguinModel22.starNum = 4;
    penguinModel22.content = @"24th SSIF No.03@虹桥艺术中心。好看好看。放映完影院自发三波掌声。我对追忆篇比较执着，人诛篇随缘，但看完算是远超预期。动作设计一部好过一部，到这部说是达到了类型片最高水准也不为过，决战的环境战损真实丰富且与动作戏衔接一气呵成。宗次郎出场跟剑心背靠背，《飞天》千呼万唤终于响起的时候，简直不要太燃。桥段笑点也不错，因为有上海背景，每次三脚猫中文都集体笑场。左之助那句：你就是剑心的小舅子吧是最强笑点。村花39分钟出场，巴的造型头发放下来遮脸正好造就她的颜值巅峰。44分开始追忆的名场面被剧透了个底朝天。于是对一手明牌来为系列压轴的追忆篇更添期待。";
    penguinModel22.MoviewID = 10;
    penguinModel22.ComentID = 22;
    penguinModel22.CellHeight = 0;
    [tempArr addObject:penguinModel22];
    
    
    PenguinChaseVideoComentModel * penguinModel23 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel23.userName = @"呆头猫猫";
    penguinModel23.userHeadeurl = @"https://img2.doubanio.com/icon/u146054266-1.jpg";
    penguinModel23.starNum = 3;
    penguinModel23.content = @"第一幕有点过于冗长了，谈情说爱有点过多了，最后半钟头突然支棱起来。作为系列电影第一部还行，挖了不少坑，作为独立电影看不大行";
    penguinModel23.MoviewID = 11;
    penguinModel23.ComentID = 23;
    penguinModel23.CellHeight = 0;
    [tempArr addObject:penguinModel23];
    
    PenguinChaseVideoComentModel * penguinModel24 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel24.userName = @"Seiyu";
    penguinModel24.userHeadeurl = @"https://img1.doubanio.com/icon/u98368808-7.jpg";
    penguinModel24.starNum = 4;
    penguinModel24.content = @"这个IP太火了，于是跟风看了剧场版。言简意赅，该打斗的时候打斗，该煽情的时候煽情，结尾成功让我把口罩哭湿。可是真的像宫崎骏那样是部几十年后依然经典的动画吗？我想不是。。。";
    penguinModel24.MoviewID = 12;
    penguinModel24.ComentID = 24;
    penguinModel24.CellHeight = 0;
    [tempArr addObject:penguinModel24];
    
    PenguinChaseVideoComentModel * penguinModel25 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel25.userName = @"野乃花";
    penguinModel25.userHeadeurl = @"https://img2.doubanio.com/icon/u197318912-11.jpg";
    penguinModel25.starNum = 4;
    penguinModel25.content = @"像太阳一样耀眼的大哥最后说：‘‘就算停下脚步蹲坐下来，时间的流动也不会为你停止，时间不可能陪伴你承担悲伤。’’ 常以为人是一种容器，盛着快乐，盛着悲哀。但人不是容器，人是导管，快乐流过，悲哀流过，导管只是导管。各种快乐悲哀流过，一直到死，导管才空了。 ";
    penguinModel25.MoviewID = 12;
    penguinModel25.ComentID = 25;
    penguinModel25.CellHeight = 0;
    [tempArr addObject:penguinModel25];
    
    PenguinChaseVideoComentModel * penguinModel26 = [[PenguinChaseVideoComentModel alloc]init];
    penguinModel26.userName = @"灯塔映画";
    penguinModel26.userHeadeurl = @"https://img2.doubanio.com/icon/u76465552-3.jpg";
    penguinModel26.starNum = 3;
    penguinModel26.content = @"直白地说，《闪哈》是一部超级纯粹的Fan Movie，且精准定位对CCA有一定读解的宇宙世纪粉。如果你看到这篇影评，期待战斗刻画的友邻，友善地建议你绕道。本片的格调和主题重心注定其战斗密度无法和《NT》、《UC》、更别说《00:AoT》相比。但影片在富野风格基础上做了很多台词和...";
    penguinModel26.MoviewID = 13;
    penguinModel26.ComentID = 26;
    penguinModel26.CellHeight = 0;
    [tempArr addObject:penguinModel26];
    
    
    BOOL isMoel = [[NSUserDefaults standardUserDefaults] boolForKey:@"PenguinChaseVideoComentModel"];
    
    if (isMoel == NO) {
        BOOL isiinModl =  [WHC_ModelSqlite inserts:tempArr.copy];
        [[NSUserDefaults standardUserDefaults] setBool:isiinModl forKey:@"PenguinChaseVideoComentModel"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
@end
