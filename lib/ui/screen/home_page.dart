part of 'screens.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final controller = Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            children: [
              GetBuilder<HomePageController>(
                id: 'user',
                builder: (_) => _header(),
              ),
              _menu(context),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Today's To Do List",
                  style: blackFontStyle2.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: white,
                  ),
                ),
              ),
              GetBuilder<HomePageController>(
                  id: 'daily',
                  builder: (_) => Expanded(
                        child: controller.loading.value
                            ? Shimmer.fromColors(
                                child: _listToDo(4),
                                highlightColor: Colors.grey[300]!,
                                baseColor: Colors.grey[100]!,
                              )
                            : _listToDo(controller.daily!.length,
                                daily: controller.daily),
                      )),
            ],
          ),
        ),
      ),
    );
  }

  _menu(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 170,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to((() => DailyTodo()), transition: Transition.cupertino);
                },
                child: _menuItem('daily.png', 'Daily'),
              ),
              GestureDetector(
                onTap: () => Get.to((() => WeeklyToDo()),
                    transition: Transition.cupertino),
                child: _menuItem('week.png', 'Weekly'),
              ),
              GestureDetector(
                onTap: () => Get.to(() => MonthlyToDo(),
                    transition: Transition.cupertino),
                child: _menuItem('monthly.png', 'Monthly'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () =>
                    snackbar(context, false, "Fitur belum proses develop"),
                child: _menuItem('result.png', 'Result'),
              ),
              GestureDetector(
                onTap: () =>
                    snackbar(context, false, "Fitur belum proses develop"),
                child: _menuItem('request.png', 'Request'),
              ),
              GestureDetector(
                onTap: () =>
                    snackbar(context, false, "Fitur belum proses develop"),
                child: _menuItem('approved.png', 'Approve'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _header() {
    return controller.loading.value
        ? Container(
            height: 110,
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Shimmer.fromColors(
              child: Container(
                  height: 90,
                  width: double.infinity - 20,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              highlightColor: Colors.grey[300]!,
              baseColor: Colors.grey[100]!,
              period: const Duration(milliseconds: 500),
            ),
          )
        : Container(
            height: 110,
            width: double.infinity,
            padding: const EdgeInsets.all(defaultMargin),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.user!.namaLengkap!,
                      style: blackFontStyle1.copyWith(
                          fontWeight: FontWeight.bold, color: white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${controller.user!.divisi!.nama!} - ${controller.user!.area!.nama}",
                      style: blackFontStyle3.copyWith(
                          fontWeight: FontWeight.w100, color: white),
                    ),
                  ],
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/usep.jpg'),
                  backgroundColor: white,
                )
              ],
            ),
          );
  }

  _menuItem(String image, String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                'assets/$image',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: blackFontStyle2.copyWith(
            fontSize: 10,
          ),
        )
      ],
    );
  }

  _listToDo(int lenght, {List<DailyModel>? daily}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: daily != null && daily.isEmpty
          ? Center(
              child: Text(
                "Tidak ada to do\n ${DateFormat('d MMMM y').format(DateTime.now())}",
                style: blackFontStyle2.copyWith(color: white),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: lenght,
              itemBuilder: (context, index) => daily != null
                  ? CardDailyHome(
                      daily: controller.daily![index],
                      index: index,
                    )
                  : Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 0.2, color: greyColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                      child: Container(
                        alignment: Alignment.center,
                        height: 125,
                        width: double.infinity,
                        padding: const EdgeInsetsDirectional.only(bottom: 10),
                      ),
                    ),
            ),
    );
  }
}
