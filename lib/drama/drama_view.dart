import 'package:flutter/material.dart';
import 'package:flutter_mood/utils/ui/base_scaffold.dart';
import 'package:flutter_mood/utils/ui/button.dart';
import 'package:flutter_mood/utils/ui/dialog.dart';
import 'package:flutter_mood/utils/ui/text.dart';
import 'package:flutter_mood/utils/values/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class DramaPage extends StatelessWidget {
  DramaPage({Key? key}) : super(key: key);

  final List<String> links = [
    'https://m.iqiyi.com/lib/m_200057814.html?vfrm=2-3-3-1',
    'https://m.iqiyi.com/search.html?source=suggest&key=梨泰院&pos=1&vfrm=2-3-3-1',
    'https://search.youku.com/search_video?keyword=匹诺曹',
  ];

  final List<String> images = [
    'assets/png/继承者们.png',
    'assets/png/梨泰院.png',
    'assets/png/匹诺曹.png',
  ];

  final List<String> desc = [
    '《继承者们》为韩国SBS预计自2013年10月起播出的水木迷你连续剧。由《秘密花园》、《绅士的品格》等多部人气作品的金恩淑作家执笔，自《恋人系列》起至《绅士的品格》已经和申宇哲导演连续打造七部电视剧的金恩淑，此作则是与《老千》、《Midas》导演姜信孝合作。故事是讲述富家子弟高中生们之间爱情与友情的一部青春偶像剧。',
    '个性正直的青年朴世路（朴叙俊饰）的父亲在一场意外中去世，因肇事者出身财阀而逃脱法律制裁，朴世路想为父亲讨回公道却因此入狱。朴世路父亲生前的嘱托成为支撑男主坚持下去的信念，这份固执的坚守被朴世路用在了人生规划上，他为自己的复仇之路制定了一个长达15年之久的计划，出狱后，仅有初中学历、还有犯罪前科的朴世路，辛苦工作7年，攒钱在梨泰院开设小酒馆。那些跟随他一起创业逆袭的店员们，则都是充满灰暗底色的边缘群体，有一度迷失自我的前黑社会成员，有身为男身却渴望打工赚钱接受变性手术的跨性别者，还有从小到大被原生家庭所歧视的可怜庶子。这些在社会上被以异样眼光看待的人，却是朴世路十分珍惜的打拼伙伴。朴世路一路逆袭实现商业抱负，并向害死父亲的人复仇，让一个个被旁人看作是在痴人说梦的目标一一实现。',
    '崔达布原名奇河明，14岁时曾落水，被崔仁荷的爷爷所救并收养，改名为崔达布， 和同岁却不同辈的“侄女”崔仁荷成为一家人。因为内心的真挚和对救命恩人的感激，他抛弃过往的身份和经历，一直以崔达布的身份生活着，头发经常是蓬乱的，考试、衣着等都是一团糟，但是为了省钱供“侄女”崔仁荷读书，崔达布开起了出租车，最后却因为超强的记忆力和天生的聪明头脑当上了记者，而崔仁荷也因患有说谎就会打嗝不止的“匹诺曹症”，难以从事其他职业，最终直面病症，选择做一名报道真实情况的社会部记者。',
  ];

  final List<String> titles = ['继承者们', '梨泰院', '匹诺曹'];

  final List<List<String>> numbers = [
    ['1', '2', '...', '18', '19', '20'],
    ['1', '2', '...', '14', '15', '16'],
    ['1', '2', '...', '18', '19', '20'],
  ];

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      titleStr: '韩剧推荐',
      child: ListView.separated(
        itemCount: links.length,
        separatorBuilder: (BuildContext context, int index) => Container(height: 1.w, color: AppColors.grayEe),
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(titles[index], images[index], links[index], desc[index], numbers[index]);
        },
      ),
    );
  }

  Widget _buildItem(String title, String icon, String link, String desc, List<String> numbers) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
      child: ButtonWidget(
        onTap: () {
          CommonDialog.twoButton(
            title: '提示',
            description: '此内容由第三方提供',
            onConfirm: () {
              Uri uri = Uri.parse(link);
              launchUrl(uri, mode: LaunchMode.externalApplication);
            },
          );
        },
        hasInkWell: false,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 70.w,
                  child: AspectRatio(
                    aspectRatio: 0.72,
                    child: Image.asset(icon),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget.oneLine(text: title, fontSize: 16, color: AppColors.textLevelOne),
                      SizedBox(height: 5.w),
                      TextWidget.moreLine(text: desc, fontSize: 12, color: AppColors.textLevelTwo, maxLines: 4),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.w),
            LayoutBuilder(
              builder: (_, BoxConstraints constraints) {
                double margin = 10.w;
                double width = (constraints.maxWidth - (numbers.length - 1) * margin) / numbers.length;
                return Wrap(
                  spacing: margin,
                  children: numbers
                      .map((e) => Container(
                            width: width.floorToDouble(),
                            height: width.floorToDouble(),
                            color: AppColors.grayF8,
                            alignment: Alignment.center,
                            child: TextWidget.oneLine(text: e, fontSize: 15, color: AppColors.textLevelOne),
                          ))
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
