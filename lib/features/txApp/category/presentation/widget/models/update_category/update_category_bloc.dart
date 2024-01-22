import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:go_router/go_router.dart';
import 'package:sparrow/core/services.dart';
import 'package:sparrow/features/txApp/category/domain/models/category.dart';
import 'package:sparrow/features/txApp/category/domain/models/category_enum.dart';
import 'package:sparrow/features/txApp/category/domain/services/category_service.dart';
import 'package:sparrow/features/txApp/category/presentation/widget/models/update_category/update_category.dart';
import 'package:sparrow/features/txApp/category/repository/category_repository.dart';
import 'package:sparrow/features/txApp/currency/domain/models/currency.dart';
import 'package:sparrow/features/txApp/currency/domain/services/currency_service.dart';
import 'package:reactive_variables/reactive_variables.dart';

abstract class UpdateCategoryBloc extends State<UpdateCategory> {
  // Page variables
  final CurrencyService currencyService = CurrencyService.instance;
  final CategoryService categoryService = CategoryService.instance;

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController amountCtrl = TextEditingController();

  Rv<List<Currency>?> currencies = Rv(null);
  Rv<Currency?> newCurrency = Rv(null);
  Rv<CategoryType?> categoryType = Rv(null);
  Rv<Color> color = Rv(Colors.red);
  Rv<Icon?> icon = Rv(null);

  // .................

  // Initialization
  @override
  void initState() {
    super.initState();
    initVar();
  }

  Future<void> initVar() async {
    nameCtrl.text = widget.category.name;
    newCurrency.value = widget.category.currency;
    color.value = Color(widget.category.color);
    icon.value = Icon(
      IconData(
        widget.category.icon,
        fontFamily: 'MaterialIcons',
      ),
      color: Colors.white,
    );
    amountCtrl.text = widget.category.amount.toString();
    categoryType.value = widget.category.type;
  }
  //........

  // Page Methods
  pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]);

    this.icon.value = Icon(icon);
    setState(() {});

    debugPrint('Picked Icon:  $icon');
  }
  //......

  // Page settings
  bool get isValidForm {
    return nameCtrl.text == "" ||
        newCurrency.value == null ||
        icon.value == null ||
        categoryType.value == null;
  }

  String get amountAllow =>
      r'([+-]?(?=\.\d|\d)(?:\d+)?(?:\.?\d*))(?:[Ee]([+-]?\d+))?';

  String get chooseCategoryTypeText =>
      "Choose тип категории : ${categoryType.value == null ? "" : categoryType.value == CategoryType.income ? "Income" : "Expense"}";

  //........................

  // Interaction with object

  Future<void> Function()? onUpdateCategory() {
    return isValidForm
        ? null
        : () async {
            final Connectivity connectivity = Connectivity();
            final connectivityResult = await connectivity.checkConnectivity();
            Category account = Category(
              id: widget.category.id,
              name: nameCtrl.text,
              currency: newCurrency.value!,
              type: categoryType.value!,
              color: color.value.value,
              icon: icon.value!.icon!.codePoint,
              amount: amountCtrl.text.isNotEmpty
                  ? double.parse(amountCtrl.text)
                  : 0,
              isSyncOrDelete: false,
            );
            await widget.onChange?.call(account);
            if (connectivityResult != ConnectivityResult.none) {
              final CategoryRepository categoryRepository =
                  CategoryRepository();
              final result = await categoryRepository.updateCategory(
                id: account.id,
                name: account.name,
                currency: account.currency.name,
                categoryType: account.type.name,
                icon: account.icon,
                color: account.color,
                amount: account.amount,
                description: null,
              );
              if (result.isSuccess) {
                account.isSyncOrDelete = true;
                await categoryService.updateCategory(account);
              } else {
                final Services services = Services();
                await services.check();
              }
            } else {
              final Services services = Services();
              await services.check();
            }
            if (mounted) {
              context.pop();
            }
          };
  }

  // ..................
}
