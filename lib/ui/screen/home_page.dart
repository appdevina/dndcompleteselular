// ignore_for_file: use_key_in_widget_constructors

part of 'screens.dart';

class HomePage extends StatelessWidget {
  final controller = Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              "To Do List Today",
              style: blackFontStyle2.copyWith(
                  fontWeight: FontWeight.w600, fontSize: 18),
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
                            model: controller.daily),
                  )),
        ],
      ),
    );
  }

  _menu(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.grey[200],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Get.to((() => DailyTodo()), transition: Transition.cupertino);
            },
            child: _menuItem('day.png', 'Daily'),
          ),
          GestureDetector(
            onTap: () {
              Get.to((() => WeeklyToDo()), transition: Transition.cupertino);
            },
            child: _menuItem('week.png', 'Weekly'),
          ),
          GestureDetector(
            onTap: () {
              Get.to((() => MonthlyToDo()), transition: Transition.cupertino);
            },
            child: _menuItem('month.png', 'Monthly'),
          ),
        ],
      ),
    );
  }

  _header() {
    return controller.loading.value
        ? Shimmer.fromColors(
            child: Container(
              height: 100,
              width: double.infinity,
              color: white,
            ),
            highlightColor: Colors.grey[300]!,
            baseColor: Colors.grey[100]!,
            period: const Duration(milliseconds: 500),
          )
        : Container(
            height: 100,
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
                      style:
                          blackFontStyle1.copyWith(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      controller.user!.divisi!.nama!,
                      style:
                          blackFontStyle3.copyWith(fontWeight: FontWeight.w100),
                    ),
                  ],
                ),
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'http://serveritcs.ddnsku.my.id:3900/itsupport/member/usep.jpg'),
                  backgroundColor: white,
                )
              ],
            ),
          );
  }

  _menuItem(String image, String name) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 80,
          width: 80,
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
          height: 10,
        ),
        Text(
          name,
          style: blackFontStyle2,
        )
      ],
    );
  }

  _listToDo(int lenght, {List<DailyModel>? model}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: model != null && model.isEmpty
          ? Center(
              child: Text(
                "Tidak ada daftar daily hari ini",
                style: blackFontStyle2,
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => Get.to(() => DetailDaily(daily: model![index]),
                    transition: Transition.cupertino),
                child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    borderOnForeground: false,
                    shadowColor: white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    elevation: 10,
                    color: model == null
                        ? white
                        : model[index].status!
                            ? Colors.green[300]
                            : Colors.red[300],
                    child: ListTile(
                      title: Text(
                        model == null ? '' : model[index].task!.toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        style: blackFontStyle2.copyWith(
                            color: white, fontSize: 16),
                      ),
                      subtitle: Text(
                        model == null
                            ? ''
                            : "JAM : ${model[index].time!} || ${model[index].status == false ? 'OPEN' : 'CLOSED'}",
                        style: blackFontStyle2.copyWith(color: white),
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: model == null
                          ? const SizedBox()
                          : Icon(
                              model[index].status!
                                  ? MdiIcons.check
                                  : MdiIcons.close,
                              color: model[index].status!
                                  ? Colors.green[800]
                                  : Colors.red[800],
                              size: 30,
                            ),
                    )),
              ),
              itemCount: lenght,
              padding: const EdgeInsetsDirectional.only(bottom: 10),
            ),
    );
  }
}
