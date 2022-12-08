import 'package:flixbus/consts/colors.dart';
import 'package:flixbus/controller.dart';
import 'package:flixbus/services/page_service.dart';
import 'package:flixbus/widgets/player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _topImageAnimationCtrl;
  final _topImageAnimation = Tween(begin: 0.0, end: 1.0);
  final _controller = Get.put(Controller());
  final _scrollCtrl = ScrollController();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown]);
    _topImageAnimationCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _topImageAnimation.animate(_topImageAnimationCtrl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          WebSmoothScroll(
            controller: _scrollCtrl,
            animationDuration: 600,
            scrollOffset: 90,
            curve: Curves.easeInOutCirc,
            child: SingleChildScrollView(
              controller: _scrollCtrl,
              child: Column(
                children: [
                  _titleBar(),
                  _topImage(),
                  Obx(
                    () => Visibility(
                      visible: !_controller.isPlayerFullScreen.value &&
                          _controller.tvName.value.isNotEmpty,
                      child: Container(
                          padding: const EdgeInsets.only(top: 40),
                          width: Get.width / 1.5,
                          child: const PlayerWidget()),
                    ),
                  ),
                  Padding(
                    padding: Get.width > 500
                        ? const EdgeInsets.only(top: 50, left: 100, right: 100)
                        : const EdgeInsets.only(top: 50),
                    child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      children: [
                        _tvItem(text: "TRT 1", channel: "trt1"),
                        _tvItem(text: "TRT 2", channel: "trt2"),
                        _tvItem(text: "TRT Çocuk", channel: "trtcocuk"),
                        _tvItem(text: "Show TV", channel: "showtv"),
                        _tvItem(text: "Star TV", channel: "startv"),
                        _tvItem(text: "Habertürk", channel: "haberturk"),
                        _tvItem(text: "Tv8", channel: "tv8"),
                        _tvItem(text: "ATV", channel: "atv"),
                        _tvItem(text: "A Spor", channel: "aspor"),
                        _tvItem(text: "NTV", channel: "ntv"),
                        _tvItem(text: "Power Türk TV", channel: "powerturk"),
                        _tvItem(text: "Power TV", channel: "power"),
                      ],
                    ),
                  ),
                  /* FutureBuilder<bool>(
                      future: NetworkService().checkIpAdress(),
                      builder: (context, snapshot) {
                        return snapshot.connectionState ==
                                ConnectionState.waiting
                            ? _infoLabel("Canlı TV Yükleniyor..")
                            : snapshot.data!
                                ? Padding(
                                    padding: Get.width > 500
                                        ? const EdgeInsets.only(
                                            top: 50, left: 100, right: 100)
                                        : const EdgeInsets.only(top: 50),
                                    child: Wrap(
                                      direction: Axis.horizontal,
                                      alignment: WrapAlignment.center,
                                      children: [
                                        _tvItem(text: "TRT 1", channel: "trt1"),
                                        _tvItem(text: "TRT 2", channel: "trt2"),
                                        _tvItem(
                                            text: "TRT Çocuk",
                                            channel: "trtcocuk"),
                                        _tvItem(
                                            text: "Show TV", channel: "showtv"),
                                        _tvItem(
                                            text: "Star TV", channel: "startv"),
                                        _tvItem(
                                            text: "Habertürk",
                                            channel: "haberturk"),
                                        _tvItem(text: "Tv8", channel: "tv8"),
                                        _tvItem(text: "ATV", channel: "atv"),
                                        _tvItem(
                                            text: "A Spor", channel: "aspor"),
                                        _tvItem(text: "NTV", channel: "ntv"),
                                        _tvItem(
                                            text: "Power Türk TV",
                                            channel: "powerturk"),
                                        _tvItem(
                                            text: "Power TV", channel: "power"),
                                      ],
                                    ),
                                  )
                                : _infoLabel(
                                    "Sadece paylaşımlı Wi-fi erişimi vardır");
                      }), */
                  const Divider(height: 100),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.center,
                      children: [
                        _infoItem(
                            svg: "saglik",
                            text: " Önceliğimiz Sağlık ",
                            subText:
                                "Sizler ve çalışanlarımız için tedbirlerimizi alıyor, konforlu bir seyahat için tüm imkânlarımızı hizmetinize sunuyoruz."),
                        _infoItem(
                            svg: "konfor",
                            text: "Konforlu Seyahat",
                            subText:
                                "Tüm seferlerimiz ücretsiz wi-fi, host hizmeti, ikram çeşitleri ve daha fazlası ile sizleri bekliyor!"),
                        _infoItem(
                            svg: "guvenlik",
                            text: "Güvenli Seyahat",
                            subText:
                                "Seyahat öncesi, esnası ve sonrası kontrollerimiz düzenli olarak yapılmaktadır."),
                        _infoItem(
                            svg: "iletisim",
                            text: "İletişim",
                            subText:
                                "İletişim adreslerimiz\n444 0 562\nkamilkoc@kamilkoc.com.tr")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.black,
            child: Obx(
              () => Visibility(
                visible: _controller.isPlayerFullScreen.value,
                child: const PlayerWidget(),
              ),
            ),
          )
        ],
      ),
    );
  }

  //  ✦•━━━━━━━━━━━━━━━━━•✦ //

  Widget _tvItem({
    required String text,
    required String channel,
  }) {
    return Container(
      width: 170,
      margin: EdgeInsets.all(Get.width > 500 ? 15 : 5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey.withOpacity(0.2))),
      child: InkWell(
        onTap: () {
          _controller.setTvName(channel);
          _scrollCtrl.jumpTo(_scrollCtrl.position.minScrollExtent + 200);
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset('assets/pictures/$channel.png'),
            ),
            Container(
              color: MyColors.tvItemBgColor,
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text,
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(fontSize: 16)),
                  ),
                  Icon(
                    Icons.play_arrow,
                    color: MyColors.svgIconColor,
                    size: 25,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _infoItem(
      {required String svg, required String text, required String subText}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      width: 250,
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/svg/$svg.svg',
            color: MyColors.svgIconColor,
            height: 35,
          ),
          const SizedBox(height: 5),
          Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                    color: Colors.black87)),
          ),
          const SizedBox(height: 5),
          Text(
            subText,
            style: GoogleFonts.roboto(
                textStyle:
                    const TextStyle(fontSize: 15, color: Colors.black87)),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  Widget _topImage() {
    _topImageAnimationCtrl.forward();
    return FadeTransition(
      opacity: _topImageAnimationCtrl,
      child: Image.asset(
        'assets/pictures/bus.jpeg',
        fit: BoxFit.cover,
        height: Get.width < 500 ? 220 : null,
      ),
    );
  }

  Container _titleBar() {
    return Container(
      color: MyColors.titleBarColor,
      padding: EdgeInsets.symmetric(
          horizontal: Get.width > 500 ? 100 : 40, vertical: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => PageService().refreshPage(),
            child: SvgPicture.asset(
              'assets/svg/kamilkoc.svg',
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoLabel(String text) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
          color: Colors.amberAccent[100],
          border: Border.all(color: Colors.black38)),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  @override
  void dispose() {
    _topImageAnimationCtrl.dispose();
    super.dispose();
  }
}
